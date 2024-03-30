

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/message/cubit/message_cubit.dart';

class ChatUtils{

 static Future<void> sendMessages(
    BuildContext context,
   { 
    required MessageEntity message,
    String?  messageController,
    String?  type,
    String?  replyTo,
    String?  replyMessageType,
    String?  replyMessage,}

    )async{


      
    BlocProvider.of<MessageCubit>(context).sendMessage(chat: ChatEntity(
      senderUid: message.senderUid,
      senderName: message.senderName,
      senderProfile: message.senderProfile,
      recipientUid: message.recipientUid,
      recipientName: message.recipientName,
      recipientProfile: message.recipientProfile,
      recentTextMessage: message.message,
      createdAt: Timestamp.now(),
      totalUnreadMessage: '0',
    ), 
    message: MessageEntity(
      senderUid: message.senderUid,
      senderName: message.senderName,
      recipientUid: message.recipientUid,
      recipientName: message.recipientName,
      createdAt: Timestamp.now(),
      isSeen: false,
      messageType: type,
      repliedTo: replyTo ??'',
      repliedType: replyMessageType ?? '',
      repliedMessage: replyMessage ?? '',
      message: messageController,
    ));
  }
}