import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

class MessageAudioWidget extends StatefulWidget {
  const MessageAudioWidget({super.key, required this.audioUrl});
  final String audioUrl;

  @override
  State<MessageAudioWidget> createState() => _MessageAudioWidgetState();
}

class _MessageAudioWidgetState extends State<MessageAudioWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          constraints:const BoxConstraints(minWidth: 50),
          onPressed:  ()async {
          if(isPlay){
            await audioPlayer.pause();
            setState(() {
              isPlay = false;
            },);
          }else{
            await audioPlayer.setSourceUrl(widget.audioUrl).then((value) => setState(() {
              isPlay = true;
            },),);
            await audioPlayer.play(UrlSource(widget.audioUrl)).then((value) => setState(() {
              isPlay = false;
            },),);
            await audioPlayer.stop();
          }
        }, icon: Icon(
            isPlay ? Icons.pause_circle : Icons.play_circle,
            size: 30,
            color: greyColor,
          ),),
          const SizedBox(width: 15,),
          isPlay ? StreamBuilder<Duration>(stream: audioPlayer.onPositionChanged, builder: (context, snapshot) {
            if(snapshot.hasData){
            late  Duration currentDuration ;
              audioPlayer.onDurationChanged.listen((position) {
                currentDuration = position;
              });
              
              return  Container(
            margin:  const EdgeInsets.only(top: 20),
                width: 190,
                height: 2,
            child:  LinearProgressIndicator(
              value: snapshot.data!.inMilliseconds.toDouble() / currentDuration.inMilliseconds.toDouble(),
            valueColor:const AlwaysStoppedAnimation(Colors.white),
            backgroundColor: greyColor,
            ),
          );
            }else{
              return Container(
            margin:  const EdgeInsets.only(top: 20),
                width: 190,
                height: 2,
            child: const LinearProgressIndicator(value: 0,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: greyColor,
            ),
          );
            }
          },) : Container(
            margin:  const EdgeInsets.only(top: 20),
                width: 190,
                height: 2,
            child: const LinearProgressIndicator(value: 0,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: greyColor,
            ),
          ),
      ],
    );
  }
}