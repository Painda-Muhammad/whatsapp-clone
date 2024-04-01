import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CachedVideoMessageWidget extends StatefulWidget {
  const CachedVideoMessageWidget({super.key,required this.url});
  final String url;

  @override
  State<CachedVideoMessageWidget> createState() => _CachedVideoMessageWidgetState();
}

class _CachedVideoMessageWidgetState extends State<CachedVideoMessageWidget> {

  late  VideoPlayerController videoPlayerController;
    bool isPlay = false;

    @override
    void initState(){
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url))..initialize().then((value) => videoPlayerController.setVolume(1));
      super.initState();
    }
    @override
   void dispose(){
    videoPlayerController.dispose();
    super.dispose();
   }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayer(videoPlayerController),

        Align(
          alignment: Alignment.center,
          child: IconButton(icon: Icon(isPlay? Icons.pause_circle:Icons.play_circle),
            onPressed: () {
              if(isPlay){
                videoPlayerController.play();
              }else{
                videoPlayerController.pause();
              }
              setState(() {
                isPlay = !isPlay;
              });
            },
          ),
        )
      ],
    );
  }
}