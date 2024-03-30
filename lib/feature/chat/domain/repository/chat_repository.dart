import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(ChatEntity chat, MessageEntity message);

  Stream<List<ChatEntity>> getMyChat(ChatEntity chat);
  Stream<List<MessageEntity>> getMessages(MessageEntity messages);

  Future<void> deleteMessage(MessageEntity message);
  Future<void> deleteChat(ChatEntity chat);
}
