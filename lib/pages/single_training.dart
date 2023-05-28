import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/store/single_training_state.dart';
import 'package:xpc_app/widgets/actions/action_item.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';
import 'package:xpc_app/widgets/video_player_widget.dart';

@RoutePage()
class SingleTrainingPage extends StatefulWidget {
  final int siteId;
  final int courseId;
  final int moduleId;
  final int trainingId;
  final String trainingTitle;
  const SingleTrainingPage({
    super.key,
    required this.siteId,
    required this.courseId,
    required this.moduleId,
    required this.trainingId,
    required this.trainingTitle,
  });

  @override
  State<SingleTrainingPage> createState() => _SingleTrainingPageState();
}

class _SingleTrainingPageState extends State<SingleTrainingPage> {
  InAppWebViewController? _webViewController;
  @override
  void didChangeDependencies() {
    final SingleTrainingBloc singleTrainingBloc =
        BlocProvider.of<SingleTrainingBloc>(context);
    singleTrainingBloc.add(SingleTrainingLoadEvent(
        siteId: widget.siteId,
        courseId: widget.courseId,
        moduleId: widget.moduleId,
        trainingId: widget.trainingId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trainingTitle),
        backgroundColor: const Color(0xff5ce0aa),
      ),
      body: BlocBuilder<SingleTrainingBloc, SingleTrainingState>(
        builder: (context, state) {
          if (state is SingleTrainingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SingleTrainingLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Column(
                  children: [
                    VideoPlayerWidget(videoUrl: state.training.videoUrl),
                    const SizedBox(height: 15),
                    TokenizedHtml(htmlData: state.training.notes),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.training.actions.length,
                      itemBuilder: (context, index) {
                        final action = state.training.actions[index];
                        return TrainingActionItem(
                            action: action, courseId: widget.courseId);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is SingleTrainingLoadFailed) {
            return Center(
              child: Text(state.errorText),
            );
          }
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
