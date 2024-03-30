import 'package:whatsapp_clone_app/feature/chat/data/data%20source/chat_remot_data_source.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository{
  ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl(this.remoteDataSource);


  @override
  Future<void> deleteChat(ChatEntity chat)async {
    await remoteDataSource.deleteChat(chat);
  }

  @override
  Future<void> deleteMessage(MessageEntity message)async => await remoteDataSource.deleteMessage(message);

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity messages) => remoteDataSource.getMessages(messages);

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) => remoteDataSource.getMyChat(chat);

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message)async => await remoteDataSource.sendMessage(chat, message);
  
}