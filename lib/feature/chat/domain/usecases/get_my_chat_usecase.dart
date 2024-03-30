import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class GetMyChatUsecase {
  final ChatRepository repository;
  GetMyChatUsecase( {required this.repository});

  Stream<List<ChatEntity>> call({required ChatEntity chat}){
    return repository.getMyChat(chat);
  }
}