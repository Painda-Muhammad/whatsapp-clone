import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? messageType;
  final String? message;
  final Timestamp? createdAt;
  final bool? isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedType;
  final String? senderProfile;
  final String? recipientProfile;
  final String? messageId;
  final String? uid;

 const MessageEntity({
    this.senderUid,
    this.recipientUid,
    this.senderName,
    this.recipientName,
    this.messageType,
    this.message,
    this.createdAt,
    this.isSeen,
    this.repliedTo,
    this.repliedMessage,
    this.repliedType,
    this.senderProfile,
    this.recipientProfile,
    this.messageId,
    this.uid
  });

  @override
  List<Object?> get props => [
        uid,
        senderUid,
        recipientUid,
        senderName,
        recipientName,
        messageType,
        message,
        createdAt,
        isSeen,
        repliedTo,
        repliedMessage,
        repliedType,
        senderProfile,
        recipientProfile,
        messageId,
      ];
}
