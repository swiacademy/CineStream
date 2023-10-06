import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  final String youtubeId;
  const VideoPlayer(this.youtubeId, {super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    super.initState();

    youtubePlayerController = YoutubePlayerController(
        params: const YoutubePlayerParams(
            mute: true,
            showControls: true,
            showFullscreenButton: false,
            loop: false));

    youtubePlayerController.loadVideoById(videoId: widget.youtubeId);
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController.stopVideo();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: youtubePlayerController);
  }
}
