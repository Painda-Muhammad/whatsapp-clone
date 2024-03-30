import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {
      super.createdAt,
      super.isSeen,
      super.message,
      super.messageId,
      super.messageType,
      super.recipientName,
      super.recipientProfile,
      super.recipientUid,
      super.repliedMessage,
      super.repliedTo,
      super.repliedType,
      super.senderName,
      super.senderProfile,
      super.senderUid});

//   final String? senderUid;
//   final String? recipientUid;
//   final String? senderName;
//   final String? recipientName;
//   final String? messageType;
//   final String? message;
//   final Timestamp? createdAt;
//   final bool? isSeen;
//   final String? repliedTo;
//   final String? repliedMessage;
//   final String? repliedType;
//   final String? senderProfile;
//   final String? recipientProfile;
//   final String? messageId;

//  const MessageModel(
//       {this.senderUid,
//       this.recipientUid,
//       this.senderName,
//       this.recipientName,
//       this.messageType,
//       this.message,
//       this.createdAt,
//       this.isSeen,
//       this.repliedTo,
//       this.repliedMessage,
//       this.repliedType,
//       this.senderProfile,
//       this.recipientProfile,
//       this.messageId})
//       : super(
//             senderUid: senderUid,
//             recipientUid: recipientUid,
//             senderName: senderName,
//             recipientName: recipientName,
//             message: message,
//             createdAt: createdAt,
//             isSeen: isSeen,
//             messageId: messageId,
//             messageType: messageType,
//             recipientProfile: recipientProfile,
//             repliedMessage: repliedMessage,
//             repliedTo: repliedTo,
//             repliedType: repliedType,
//             senderProfile: senderProfile);

  factory MessageModel.fromJson(DocumentSnapshot json) {
    return MessageModel(
        senderUid: json.get('senderUid'),
        createdAt: json.get('createdAt'),
        isSeen: json.get('isSeen'),
        message: json.get('message'),
        messageId: json.get('messageId'),
        messageType: json.get('messageType'),
        recipientName: json.get('recipientName'),
        recipientProfile: json.get('recipientProfile'),
        recipientUid: json.get('recipientUid'),
        repliedMessage: json.get('repliedMessage'),
        repliedTo: json.get('repliedTo'),
        repliedType: json.get('repliedType'),
        senderName: json.get('senderName'),
        senderProfile: json.get('senderProfile'));
  }

  Map<String, dynamic> toDocument() => {
        'senderUid': senderUid,
        'createdAt': createdAt,
        'isSeen': isSeen,
        'message': message,
        'messageId': messageId,
        'messageType': messageType,
        'recipientName': recipientName,
        'recipientProfile': recipientProfile,
        'recipientUid': recipientUid,
        'repliedMessage': repliedMessage,
        'repliedTo': repliedTo,
        'repliedType': repliedType,
        'senderName': senderName,
        'senderProfile': senderName
      };
}
