import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player_new/pod_player_new.dart';
import 'package:xpc_app/store/single_training_state.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/utils/index.dart';
import 'package:xpc_app/widgets/actions/action_item.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class SingleTrainingPage extends StatefulWidget {
  final int siteId;
  final int courseId;
  final int moduleId;
  final int trainingId;
  const SingleTrainingPage({
    super.key,
    required this.siteId,
    required this.courseId,
    required this.moduleId,
    required this.trainingId,
  });

  @override
  State<SingleTrainingPage> createState() => _SingleTrainingPageState();
}

class _SingleTrainingPageState extends State<SingleTrainingPage> {
  PodPlayerController? podPlayerController;
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
      body: BlocBuilder<SingleTrainingBloc, SingleTrainingState>(
        builder: (context, state) {
          if (state is SingleTrainingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SingleTrainingLoaded) {
            VideoType videoType = VideoType.other;
            final String videoUrl = 'https://app.searchie.io/watch/OpN0j1gJ2a';
            if (state.training.videoUrl.contains('xperiencify.com'))
              videoType = VideoType.uploaded;
            if (state.training.videoUrl.contains('vimeo.com') ||
                state.training.videoUrl.contains('youtube.com') ||
                state.training.videoUrl.contains('youtu.be') ||
                state.training.videoUrl.contains('youtube-nocookie.com'))
              videoType = VideoType.embed;
            if (videoType == VideoType.embed) {
              final bool isVimeoVideo =
                  state.training.videoUrl.contains('vimeo.com');
              podPlayerController = PodPlayerController(
                  playVideoFrom: isVimeoVideo
                      ? PlayVideoFrom.vimeo(
                          state.training.videoUrl.split('/').last)
                      : PlayVideoFrom.youtube(state.training.videoUrl),
                  podPlayerConfig: const PodPlayerConfig(
                      autoPlay: true,
                      isLooping: false,
                      videoQualityPriority: [1080, 720, 360]))
                ..initialise();
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(state.training.title),
                    if (videoType == VideoType.uploaded)
                      BetterPlayer.network(
                          '${state.training.videoUrl}/playlist.m3u8'),
                    if (videoType == VideoType.embed)
                      PodVideoPlayer(controller: podPlayerController!),
                    if (videoType == VideoType.other)
                      SizedBox(
                        height: 250,
                        child: InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(videoUrl)),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                        ),
                      ),
                    // TODO: move video player to separate widget
                    TokenizedHtml(
                        htmlData:
                            '<div>{Course Name} {First Name} {Last Name}</div>'),
                    Html(data: state.training.notes),
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
