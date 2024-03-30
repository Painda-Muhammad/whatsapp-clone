import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class GetMessageUsecase {
  final ChatRepository repository;
  GetMessageUsecase({required this.repository});

  Stream<List<MessageEntity>> call({required MessageEntity messages}){
    return repository.getMessages(messages);
  }
}