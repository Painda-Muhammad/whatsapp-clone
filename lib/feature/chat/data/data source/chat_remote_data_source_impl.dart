import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_app/feature/app/constants/firebase_collection.dart';
import 'package:whatsapp_clone_app/feature/app/constants/message_type_const.dart';
import 'package:whatsapp_clone_app/feature/chat/data/data%20source/chat_remot_data_source.dart';
import 'package:whatsapp_clone_app/feature/chat/data/models/chat_models.dart';
import 'package:whatsapp_clone_app/feature/chat/data/models/message_models.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required this.firestore});
  final FirebaseFirestore firestore;

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async {
    await sendMessageBasedOnType(message);

    String recentTextMessage = '';

    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = 'Photo';
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = 'Video';
        break;

      case MessageTypeConst.audioMessage:
        recentTextMessage = 'Audio';
        break;

      case MessageTypeConst.fileMessage:
        recentTextMessage = 'File';
        break;

      case MessageTypeConst.gifMessage:
        recentTextMessage = 'Gif';
        break;

      case MessageTypeConst.emojiMessage:
        recentTextMessage = 'Emoji';
        break;

      default:
        recentTextMessage = message.message!;
    }

    await addToChat(ChatEntity(
      senderUid: chat.senderUid,
      recipientUid: chat.recipientUid,
      createdAt: chat.createdAt,
      recentTextMessage: recentTextMessage,
      recipientName: chat.recipientName,
      recipientProfile: chat.recipientProfile,
      senderName: chat.senderName,
      senderProfile: chat.senderProfile,
      totalUnreadMessage: chat.totalUnreadMessage,
    ));
  }

  Future<void> addToChat(ChatEntity chat) async {
    final myChatRef = firestore
        .collection(FirebaseCollection.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollection.myChat);
    final otherChatRef = firestore
        .collection(FirebaseCollection.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollection.myChat);

    // user --> uid >> myChat >> uid >> messages >> messageId

    final myNewChat = ChatModels(
      senderUid: chat.senderUid,
      recipientUid: chat.recipientUid,
      createdAt: chat.createdAt,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.recipientName,
      recipientProfile: chat.recipientProfile,
      senderName: chat.senderName,
      senderProfile: chat.senderProfile,
      totalUnreadMessage: chat.totalUnreadMessage,
    ).toDocument();

    final othersNewChat = ChatModels(
      senderUid: chat.recipientUid,
      senderName: chat.recipientName,
      senderProfile: chat.recipientProfile,
      createdAt: chat.createdAt,
      recentTextMessage: chat.recentTextMessage,
      recipientUid: chat.senderUid,
      recipientName: chat.senderName,
      recipientProfile: chat.senderProfile,
      totalUnreadMessage: chat.totalUnreadMessage,
    ).toDocument();

    try {
      myChatRef.doc(chat.recipientUid).get().then((myChatDoc) async {
        if (!myChatDoc.exists) {
          await myChatRef.doc(chat.recipientUid).set(myNewChat);
          await otherChatRef.doc(chat.senderUid).set(othersNewChat);
          return;
        } else {
          await myChatRef.doc(chat.recipientUid).update(myNewChat);
          await otherChatRef.doc(chat.senderUid).update(othersNewChat);
          return;
        }
      });
    } catch (_) {
      if (kDebugMode) {
        print('an error occured while adding to chat');
      }
    }
  }

  Future<void> sendMessageBasedOnType(MessageEntity message) async {
    final myMessageRef = firestore
        .collection(FirebaseCollection.users)
        .doc(message.senderUid)
        .collection(FirebaseCollection.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollection.message);

    final othersMessageRef = firestore
        .collection(FirebaseCollection.users)
        .doc(message.recipientUid)
        .collection(FirebaseCollection.myChat)
        .doc(message.senderUid)
        .collection(FirebaseCollection.message);

    String messageId = const Uuid().v4();

    final newMessage = MessageModel(
      createdAt: message.createdAt,
      isSeen: message.isSeen,
      message: message.message,
      messageId: messageId,
      messageType: message.messageType,
      recipientName: message.recipientName,
      recipientProfile: message.recipientProfile,
      recipientUid: message.recipientUid,
      repliedMessage: message.repliedMessage,
      repliedTo: message.repliedTo,
      repliedType: message.repliedType,
      senderName: message.senderName,
      senderProfile: message.senderProfile,
      senderUid: message.senderUid,
    ).toDocument();

    try {
      await myMessageRef.doc(messageId).get().then((messageDoc) async {
        if (!messageDoc.exists) {
          await myMessageRef.doc(messageId).set(newMessage);
          await othersMessageRef.doc(messageId).set(newMessage);
        }
      });
    } catch (_) {
      if (kDebugMode) {
        print('an error occured while messaging');
      }
    }
  }

  @override
  Future<void> deleteChat(ChatEntity chat) async {
    final chatRef = firestore
        .collection(FirebaseCollection.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollection.myChat)
        .doc(chat.recipientUid);

    try {
      await chatRef.delete();
    } catch (e) {
      print('an error occured while deleting');
    }
  }

  @override
  Future<void> deleteMessage(MessageEntity message) async {
    final messageRef = firestore
        .collection(FirebaseCollection.users)
        .doc(message.senderUid)
        .collection(FirebaseCollection.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollection.message)
        .doc(message.messageId);
    try {
      await messageRef.delete();
    } catch (e) {
      print('an error occured while deleting');
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity messages) {
    final messageRef = firestore
        .collection(FirebaseCollection.users)
        .doc(messages.senderUid)
        .collection(FirebaseCollection.myChat)
        .doc(messages.recipientUid)
        .collection(FirebaseCollection.message)
        .orderBy('createdAt', descending: false);

    return messageRef.snapshots().map((querySnapShot) =>
        querySnapShot.docs.map((e) => MessageModel.fromJson(e)).toList());
    
  }

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) {
    final chatRef = firestore
        .collection(FirebaseCollection.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollection.myChat)
        .orderBy('createdAt', descending: true);
    return chatRef.snapshots().map((querySnapShot) =>
        querySnapShot.docs.map((e) => ChatModels.fromJson(e)).toList());
  }
}
