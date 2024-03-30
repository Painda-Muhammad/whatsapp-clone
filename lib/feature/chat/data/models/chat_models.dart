import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';

class ChatModels extends ChatEntity {
  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? recentTextMessage;
  final Timestamp? createdAt;
  final String? senderProfile;
  final String? recipientProfile;
  final String? totalUnreadMessage;

  const ChatModels({
    this.senderUid,
    this.recipientUid,
    this.senderName,
    this.recipientName,
    this.recentTextMessage,
    this.createdAt,
    this.senderProfile,
    this.recipientProfile,
    this.totalUnreadMessage,
  }) : super(
          senderUid: senderUid,
          senderName: senderName,
          recipientUid: recipientUid,
          recipientName: recipientName,
          createdAt: createdAt,
          recentTextMessage: recentTextMessage,
          recipientProfile: recipientProfile,
          senderProfile: senderProfile,
          totalUnreadMessage: totalUnreadMessage,
        );

  factory ChatModels.fromJson(DocumentSnapshot json) {
    return ChatModels(
      senderUid: json.get('senderUid'),
      recipientUid: json.get('recipientUid'),
      senderName: json.get("senderName"),
      recipientName: json.get("recipientName"),
      createdAt: json.get('createdAt'),
      recentTextMessage: json.get('recentTextMessage'),
      recipientProfile: json.get('recipientProfile'),
      senderProfile: json.get('senderProfile'),
      totalUnreadMessage: json.get('totalUnreadMessage'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'senderUid': senderUid,
      'recipientUid': recipientUid,
      'senderName': senderName,
      'recipientName': recipientName,
      'createdAt': createdAt,
      'recentTextMessage': recentTextMessage,
      'recipientProfile': recipientProfile,
      'senderProfile': senderProfile,
      'totalUnreadMessage': totalUnreadMessage
    };
  }
}
