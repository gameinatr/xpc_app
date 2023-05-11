import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xpc_app/constants/general.dart';
import 'package:xpc_app/models/actions/action_model.dart';
import 'package:xpc_app/models/trackbar_model.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/utils/index.dart';
import 'package:xpc_app/widgets/actions/action_checkmark.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';
import 'package:xpc_app/widgets/trackbar_widget.dart';

class TrainingActionItem extends StatefulWidget {
  final TrainingAction action;
  final int courseId;
  const TrainingActionItem(
      {super.key, required this.action, required this.courseId});

  @override
  State<TrainingActionItem> createState() => _TrainingActionItemState();
}

class _TrainingActionItemState extends State<TrainingActionItem> {
  late final TrainingAction action;
  late bool isCompleted;
  late bool isCorrectAnswer;
  late Duration answerDelay;
  final formKey = GlobalKey<FormState>();
  final TextEditingController essayController = TextEditingController();
  late List<int> currentAnswers;
  Timer? countdownTimer;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final seconds = answerDelay!.inSeconds - 1;
    if (seconds < 0) {
      countdownTimer!.cancel();
      currentAnswers = [];
      isCorrectAnswer = true;
    } else {
      answerDelay = Duration(seconds: seconds);
    }
    setState(() {});
  }

  @override
  void initState() {
    action = widget.action;
    isCompleted = widget.action.isCompleted;
    essayController.text = action.essay ?? '';
    isCorrectAnswer = action.displayType != ActionTypes.multichoice
        ? true
        : action.lastAnswers?.correct ?? true;
    final lastAnswerDate = action.displayType != ActionTypes.multichoice
        ? null
        : DateTime.parse(action.lastAnswers!.created);
    answerDelay = action.displayType != ActionTypes.multichoice ||
            action.multichoiceSettings == null
        ? Duration.zero
        : lastAnswerDate!
            .add(Duration(
                minutes: action.multichoiceSettings!.tryItPeriodNumber.toInt()))
            .difference(DateTime.now());
    currentAnswers =
        answerDelay.inSeconds > 0 ? action.lastAnswers?.answers ?? [] : [];

    if (answerDelay.inSeconds > 0 && !isCorrectAnswer) {
      startTimer();
    }
    super.initState();
  }

  Future<void> actionHandler() async {
    if (action.displayType == ActionTypes.multichoice &&
        !isCorrectAnswer &&
        answerDelay.inSeconds > 0) return;
    try {
      bool validated = action.displayType != ActionTypes.essay ||
          formKey.currentState!.validate();
      if (validated) {
        final actionResponse = await Authorized().request(
            method: HttpMethod.post,
            endpoint: 'v2/membership/action_status/',
            data: {
              'entity': action.entity,
              'done': !isCompleted,
              'course': widget.courseId,
              'module': action.module,
              'action': action.id,
              'add_tags': action.addTags ?? [],
              'remove_tags': action.removeTags ?? [],
              'essay': essayController.text,
              'answers': isCompleted ? [] : currentAnswers,
              'last_answers': action.lastAnswers,
            });
        final actionData = actionResponse.data;
        context.read<TrackBarBloc>().add(
            TrackBarUpdated(trackbar: Trackbar.fromJson(actionData['points'])));
        if (actionResponse.statusCode == 201) {
          if (isCompleted && action.displayType == ActionTypes.multichoice) {
            currentAnswers = [];
          }
          isCompleted = !isCompleted;
          setState(() {});
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: TrackbarWidget()));
        }
      }
    } catch (err) {
      if (err is DioError &&
          err.response?.statusCode == 400 &&
          action.displayType == ActionTypes.multichoice) {
        isCorrectAnswer = false;
        answerDelay = DateTime.now()
            .add(Duration(
                minutes: action.multichoiceSettings!.tryItPeriodNumber.toInt()))
            .difference(DateTime.now());
        startTimer();
        setState(() {});
      }
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> widgets;
    switch (action.displayType) {
      case ActionTypes.checkbox:
        {
          widgets = [
            TokenizedHtml(
              htmlData: action.title,
              styles: {'div': Style(fontSize: FontSize(24))},
            ),
            TokenizedHtml(htmlData: action.description),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ActionCheckmark(
                      isCompleted: isCompleted,
                      checkmarkHandler: actionHandler,
                      label: action.label),
                ),
                Expanded(
                    child: TokenizedHtml(
                        htmlData:
                            '${action.value} ${action.type.toUpperCase()}')),
              ],
            ),
          ];
        }
        break;
      case ActionTypes.essay:
        {
          widgets = [
            TokenizedHtml(
              htmlData: action.title,
              styles: {'div': Style(fontSize: FontSize(24))},
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  style: !isCompleted
                      ? null
                      : const TextStyle(color: Color.fromRGBO(55, 65, 81, 0.5)),
                  enabled: !isCompleted,
                  controller: essayController,
                  maxLines: 6,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.split(' ').length <
                            action.essaySettings!.essayMinWordsCount) {
                      return 'Please type at least ${action.essaySettings!.essayMinWordsCount} words';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ActionCheckmark(
                      isCompleted: isCompleted,
                      checkmarkHandler: actionHandler,
                      label: action.label),
                ),
                Expanded(
                    child: TokenizedHtml(
                        htmlData:
                            '${action.value} ${action.type.toUpperCase()}')),
              ],
            ),
          ];
        }
        break;
      case ActionTypes.multichoice:
        {
          widgets = [
            TokenizedHtml(
              htmlData: action.multichoiceSettings!.text,
              styles: {'div': Style(fontSize: FontSize(24))},
            ),
            TokenizedHtml(htmlData: action.multichoiceSettings!.subtitle),
            ...action.multichoiceSettings!.answers!.map((answer) {
              bool isAnswerPresent = currentAnswers
                  .any((currentAnswer) => currentAnswer == answer.id);
              return ActionCheckmark(
                  isCompleted: isAnswerPresent,
                  checkmarkHandler: () {
                    if (isCompleted) return;
                    if (isAnswerPresent) {
                      currentAnswers = currentAnswers
                          .where((currentAnswer) => currentAnswer != answer.id)
                          .toList();
                      setState(() {});
                    } else {
                      currentAnswers.add(answer.id);
                      setState(() {});
                    }
                  },
                  label: answer.text);
            }),
            Row(
              children: [
                Expanded(
                  child: ActionCheckmark(
                      isCompleted: isCompleted,
                      checkmarkHandler: actionHandler,
                      label: action.label),
                ),
                Expanded(
                    child: TokenizedHtml(
                        htmlData:
                            '${action.value} ${action.type.toUpperCase()}')),
              ],
            ),
            if (!isCorrectAnswer && answerDelay!.inSeconds > 0)
              Text(
                  'Not quite! Try again in ${answerDelay.inSeconds > 60 ? '${(answerDelay.inSeconds / 60).ceil()} minutes' : '${answerDelay.inSeconds} seconds'}')
          ].toList();
        }
        break;
      default:
        {
          widgets = [const SizedBox(height: 10)].toList();
        }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
                radius: 40, backgroundImage: NetworkImage(action.image)),
            ...widgets,
          ],
        ),
      ),
    );
  }
}
