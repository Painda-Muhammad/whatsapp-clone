

import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class DeletChatUsecase {
  final ChatRepository repository;
  DeletChatUsecase({required this.repository});

  Future<void> call({required ChatEntity chat}){
    return repository.deleteChat(chat);
  }
}