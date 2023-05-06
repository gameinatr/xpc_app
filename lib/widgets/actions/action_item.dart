import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xpc_app/models/actions/action_model.dart';
import 'package:xpc_app/models/trackbar_model.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/utils/index.dart';
import 'package:xpc_app/widgets/actions/action_checkmark.dart';

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
    isCorrectAnswer = action.displayType != 'MULTIPLE_CHOICE'
        ? true
        : action.lastAnswers?.correct ?? true;
    final lastAnswerDate = action.displayType != 'MULTIPLE_CHOICE'
        ? null
        : DateTime.parse(action.lastAnswers!.created);
    answerDelay = action.displayType != 'MULTIPLE_CHOICE' ||
            action.multichoiceSettings == null
        ? Duration.zero
        : lastAnswerDate!
            .add(Duration(
                minutes: action.multichoiceSettings!.tryItPeriodNumber.toInt()))
            .difference(DateTime.now());
    currentAnswers =
        answerDelay.inSeconds > 0 ? action.lastAnswers?.answers ?? [] : [];
    // if (action.displayType == 'MULTIPLE_CHOICE') {
    //   print(isCorrectAnswer);
    //   print(action.lastAnswers?.correct);
    //   print('delay: ${answerDelay.inSeconds}');
    // }

    if (answerDelay.inSeconds > 0 && !isCorrectAnswer) {
      startTimer();
    }
    super.initState();
  }

  Future<void> actionHandler() async {
    if (action.displayType == 'MULTIPLE_CHOICE' &&
        !isCorrectAnswer &&
        answerDelay.inSeconds > 0) return;
    try {
      bool validated = action.displayType != 'ESSAY_RESPONSE' ||
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
        print(actionResponse.statusCode);
        final actionData = actionResponse.data;
        print(actionData);
        context.read<TrackBarBloc>().add(
            TrackBarUpdated(trackbar: Trackbar.fromJson(actionData['points'])));
        if (actionResponse.statusCode == 201) {
          if (isCompleted && action.displayType == 'MULTIPLE_CHOICE') {
            currentAnswers = [];
          }
          isCompleted = !isCompleted;
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
              BlocBuilder<TrackBarBloc, TrackBarState>(
                  builder: (context, state) {
            final trackbar = state.trackbar;
            return Text(
                'Your total points: ${trackbar.earnedXp}/${trackbar.totalXp} XP | ${trackbar.earnedXxp}/${trackbar.totalXxp} XXP');
          })));
        }
        if (actionResponse.statusCode == 400 &&
            action.displayType == 'MULTIPLE_CHOICE') {
          isCorrectAnswer = false;
          answerDelay = DateTime.now()
              .add(Duration(
                  minutes:
                      action.multichoiceSettings!.tryItPeriodNumber.toInt()))
              .difference(DateTime.now());
          startTimer();
          setState(() {});
        }
      }
    } catch (err) {
      print('action error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    switch (action.displayType) {
      case 'SIMPLE_CHECKBOX':
        {
          widget = Column(
            children: [
              Html(data: action.title),
              ActionCheckmark(
                  isCompleted: isCompleted,
                  checkmarkHandler: actionHandler,
                  label: action.label),
            ],
          );
        }
        break;
      case 'ESSAY_RESPONSE':
        {
          widget = Column(
            children: [
              Html(data: action.title),
              Form(
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
              ActionCheckmark(
                  isCompleted: isCompleted,
                  checkmarkHandler: actionHandler,
                  label: action.label),
            ],
          );
        }
        break;
      case 'MULTIPLE_CHOICE':
        {
          widget = Column(
            children: [
              Html(data: action.multichoiceSettings!.text),
              Html(data: action.multichoiceSettings!.subtitle),
              ...action.multichoiceSettings!.answers!.map((answer) {
                bool isAnswerPresent = currentAnswers
                    .any((currentAnswer) => currentAnswer == answer.id);
                return ActionCheckmark(
                    isCompleted: isAnswerPresent,
                    checkmarkHandler: () {
                      if (isAnswerPresent) {
                        currentAnswers = currentAnswers
                            .where(
                                (currentAnswer) => currentAnswer != answer.id)
                            .toList();
                        setState(() {});
                      } else {
                        currentAnswers.add(answer.id);
                        setState(() {});
                      }
                    },
                    label: answer.text);
              }),
              ActionCheckmark(
                  isCompleted: isCompleted,
                  checkmarkHandler: actionHandler,
                  label: action.label),
              if (!isCorrectAnswer && answerDelay!.inSeconds > 0)
                Text(
                    'Not quite! Try again in ${answerDelay.inSeconds > 60 ? '${(answerDelay.inSeconds / 60).ceil()} minutes' : '${answerDelay.inSeconds} seconds'}')
            ],
          );
        }
        break;
      default:
        {
          widget = const SizedBox(height: 10);
        }
    }
    return widget;
  }
}
