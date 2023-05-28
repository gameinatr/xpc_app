import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:xpc_app/utils/index.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoType videoType = VideoType.other;
  @override
  void initState() {
    if (widget.videoUrl.contains('xperiencify.com')) {
      videoType = VideoType.uploaded;
    }
    if (
        // widget.videoUrl.contains('vimeo.com') ||
        widget.videoUrl.contains('youtube.com') ||
            widget.videoUrl.contains('youtu.be') ||
            widget.videoUrl.contains('youtube-nocookie.com')) {
      videoType = VideoType.embed;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (videoType) {
      case VideoType.uploaded:
        return BetterPlayer.network('${widget.videoUrl}/playlist.m3u8');
      case VideoType.embed:
      case VideoType.other:
        InAppWebViewController webViewController;
        return SizedBox(
          height: 275,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.videoUrl)),
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
            },
          ),
        );
      default:
        return const SizedBox(height: 150);
    }
  }
}
