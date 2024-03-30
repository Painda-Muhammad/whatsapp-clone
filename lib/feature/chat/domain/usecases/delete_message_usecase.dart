
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class DeletMessageUsecase {
  final ChatRepository repository;
  DeletMessageUsecase({ required this.repository});

  Future<void> call({required MessageEntity message}){
    return repository.deleteMessage(message);
  }
}