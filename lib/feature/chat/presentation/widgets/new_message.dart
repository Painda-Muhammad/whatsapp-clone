
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_app/feature/app/constants/message_type_const.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/chat_util.dart';
import 'package:whatsapp_clone_app/storage/storage_provider.dart';


class NewMessage extends StatefulWidget {
  const NewMessage(
      { 
      super.key,
      this.messageController,
      required this.isShowAttach,
      required this.messageEntity,
      required this.scrollToBottom,
      });

  final TextEditingController? messageController;
  final Function(bool isShowAttachWindow) isShowAttach;
  final MessageEntity messageEntity;
  final VoidCallback scrollToBottom;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool? isShowAttachWindow = false;
  File? _image;
  File? _video;

//   FlutterSoundRecoder?  _soundRecoder;
//  bool isRecording = false;
//  bool isRecordInit = false;


Future<void> pickImage()async{
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  setState(() {
    _image = File(image!.path);
  });
}

Future<void> pickVideo()async{
  try{
    if(_video == null){
  final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

      if(video != null){
        setState(() {
    _video = File(video.path);
  });
      }
    }

  }catch(_){
    if(kDebugMode){
    print('an error is occured while picking the video');
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: senderMessageColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  const Icon(Icons.emoji_emotions),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      onTap: () => setState(() {
                        isShowAttachWindow = false;
                      }),
                      controller: widget.messageController,
                      cursorColor: tabColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowAttachWindow = !isShowAttachWindow!;
                        widget.isShowAttach(isShowAttachWindow!);
                      });
                    },
                    child: Transform.rotate(
                        angle: -.5, child: const Icon(Icons.attach_file)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      
                    },
                    child: const Icon(Icons.camera_alt))
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              _sendTextMessage();
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: tabColor, borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Icon(widget.messageController!.text.isEmpty
                      ? Icons.mic
                      : Icons.send)),
            ),
          )
        ],
      ),
    );
  }

  void _sendTextMessage() {
    _sendNewMessage(
        message: widget.messageController!.text,
        type: MessageTypeConst.textMessage);
  }

  void _sendImageMessage(){
       StorageProviderRemoteDataSource.uploadMessageFile(file: _image!,uid: widget.messageEntity.senderUid,otherUid: widget.messageEntity.recipientUid,type: MessageTypeConst.photoMessage,).then((imageUrl) {
    _sendNewMessage(message: imageUrl, type: MessageTypeConst.photoMessage); 
      },);
  }
  void _sendVideoMessage(){
    StorageProviderRemoteDataSource.uploadMessageFile(file: _video!,uid: widget.messageEntity.senderUid,otherUid: widget.messageEntity.recipientUid,type: MessageTypeConst.videoMessage).then((videoUrl) {
    _sendNewMessage(message: videoUrl, type: MessageTypeConst.videoMessage);
      
    },);
  }
  // void _sendAudioMessage(){
  //   _sendNewMessage(message: _audio, type: MessageTypeConst.audioMessage);
  // }
  // void _sendEmojiMessage(){
  //   _sendNewMessage(message: _emoji, type: MessageTypeConst.emojiMessage);
  // }
  // void _sendFileMessage(){
  //   _sendNewMessage(message: _file, type: MessageTypeConst.fileMessage);
  // }
  // void _sendGifMessage(){
  //   final  gif = pickGIF(context);
  //   if(gif != null){{
  //     const fixedGifUrl ='';
  //     _sendNewMessage(message: fixedGifUrl, type: MessageTypeConst.gifMessage);
  //   }

  //   }
  //   _sendNewMessage(message: _gif, type: MessageTypeConst.gifMessage);
  // }
  

  void _sendNewMessage({
    required String message,
    required type,
    String? replyTo,
    String? replyMessageType,
    String? replyMessage,
  }) {
    widget.scrollToBottom();
    ChatUtils.sendMessages(context,
            message: widget.messageEntity,
            type: type,
            replyTo: replyTo,
            replyMessage: replyMessage,
            replyMessageType: replyMessageType,
            messageController: message)
        .then((value) => widget.messageController!.clear());
        widget.scrollToBottom();
  }
}
