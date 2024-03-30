import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/delete_message_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/get_messages_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/send_message_usecase.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.deletMessageUsecase,this.getMessageUsecase,this.sendMessageUsecase) : super(MessageInitial());

  final SendMessageUsecase sendMessageUsecase;
  final GetMessageUsecase getMessageUsecase;
  final DeletMessageUsecase deletMessageUsecase;

  Future<void> sendMessage({required ChatEntity chat, required MessageEntity message})async{
    try{
     await sendMessageUsecase.call(chat, message);
    }on SocketException{
      emit(MessageFailure());
    }catch(_){
      emit(MessageFailure());
    }
  }

  Future<void> deleteMessage({required MessageEntity message})async{
    try{
     await deletMessageUsecase.call(message: message);
    }on SocketException{
      emit(MessageFailure());
    }catch(_){
      emit(MessageFailure());
    }
  }

  Future<void> getMessages({required MessageEntity messages})async{
    try{
      final stream = getMessageUsecase.call(messages: messages);
      stream.listen((message) { emit(MessageLoaded(messages: message));});
    }on SocketException{
      emit(MessageFailure());
    }catch(_){
      emit(MessageFailure());
    }
  }
}
