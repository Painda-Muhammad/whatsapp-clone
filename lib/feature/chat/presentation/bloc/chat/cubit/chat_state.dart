part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
} 

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  const ChatLoaded({required this.chatContacts});

  final List<ChatEntity> chatContacts;

  @override
  List<Object> get props => [chatContacts];
}

final class ChatFailure extends ChatState {}
