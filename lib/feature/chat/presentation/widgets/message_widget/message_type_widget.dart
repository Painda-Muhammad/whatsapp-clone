import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/constants/message_type_const.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/message_widget/message_audio_widget.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/message_widget/message_video_widget.dart';

class MessageTypeWidget extends StatelessWidget {
  const MessageTypeWidget({super.key,this.message, this.type});

  final String? type;
  final String? message;

  @override
  Widget build(BuildContext context) {

    if(type == MessageTypeConst.textMessage){
      return Text(
        '$message',
        style:const TextStyle(color: Colors.white,fontSize: 16),
      );
    }else if(type == MessageTypeConst.photoMessage){
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: profileWidget(imageUrl: message),
      );
    }else if (type == MessageTypeConst.videoMessage){
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CachedVideoMessageWidget(url: message!,),
      );
    }else if(type == MessageTypeConst.gifMessage){
      return Padding(padding:const EdgeInsets.only(bottom: 20),
      child: CachedNetworkImage(
        imageUrl: message!,
        errorWidget: (context, url, error) =>const Icon(Icons.error),
        placeholder: (context, url) => const CircularProgressIndicator(color: tabColor,),
        ) ,
      );
    }else if(type == MessageTypeConst.audioMessage){
      return MessageAudioWidget(audioUrl: message!);
    }else{
      return Text('$message',style:const TextStyle(color: greyColor, fontSize: 12, overflow: TextOverflow.ellipsis),);
    }
  }
}