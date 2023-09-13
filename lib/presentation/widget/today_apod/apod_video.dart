import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum VideoPlataform { standart, youtube, vimeo }

class ApodVideo extends StatefulWidget {
  final String urlVideo;
  const ApodVideo({
    super.key,
    required this.urlVideo,
  });

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  VideoPlataform videoPlataform = VideoPlataform.standart;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    checkVideoPlataform();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  void checkVideoPlataform() {
    String youtubeHost = "https://www.youtube.com";
    String vimeoHost = "https://vimeo.com";
    if (widget.urlVideo.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlataform = VideoPlataform.youtube;
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.urlVideo) ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
      setState(() {});
    } else if (widget.urlVideo.substring(0, vimeoHost.length) == vimeoHost) {
      videoPlataform = VideoPlataform.vimeo;
    } else {
      videoPlataform = VideoPlataform.standart;
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.urlVideo))
            ..initialize().then((_) {
              setState(() {});
            });
    }
  }

  Widget buildVideoPlayer() {
    Widget videoWidget;
    if (videoPlataform == VideoPlataform.youtube) {
      videoWidget = YoutubePlayer(
        controller: youtubePlayerController!,
      );
    } else if (videoPlataform == VideoPlataform.vimeo) {
      videoWidget = VimeoVideoPlayer(
        url: widget.urlVideo,
        autoPlay: false,
      );
    } else {
      if (videoPlayerController!.value.hasError) {
        videoWidget = const Text(
          "Sorry! We can't play this video. Try open in your browser",
        );
      } else {
        videoWidget = GestureDetector(
          onTap: () {
            videoPlayerController!.value.isPlaying
                ? videoPlayerController!.pause()
                : videoPlayerController!.play();
          },
          child: Container(
            color: Colors.black,
            child: videoPlayerController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(
                      videoPlayerController!,
                    ))
                : const SizedBox(),
          ),
        );
        videoPlayerController!.play();
      }
    }
    return videoWidget;
  }
}
