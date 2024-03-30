import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/get_my_chat_usecase.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.deletChatUsecase, required this.getChatUsecase})
      : super(ChatInitial());

  final DeletChatUsecase deletChatUsecase;
  final GetMyChatUsecase getChatUsecase;

  Future<void> getMyChats(ChatEntity chat) async {
    emit(ChatLoading());
    try {
      final streamRes = getChatUsecase.call(chat: chat);
      streamRes.listen((chatContact) {
        emit(ChatLoaded(chatContacts: chatContact));
      });
    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> deleteChat(ChatEntity chat) async {
    try {
      await deletChatUsecase.call(chat: chat);
    } on SocketException {
      emit(ChatFailure());
    } catch (_) {}
  }
}
