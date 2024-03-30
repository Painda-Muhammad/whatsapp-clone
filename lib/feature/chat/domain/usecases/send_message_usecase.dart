
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class SendMessageUsecase{

  ChatRepository repository;
  SendMessageUsecase({required this.repository});

  Future<void> call(ChatEntity chat, MessageEntity message){
    return repository.sendMessage(chat, message);
  }
}