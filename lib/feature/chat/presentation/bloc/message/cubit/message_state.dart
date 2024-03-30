part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}
final class MessageLoading extends MessageState {}
final class MessageLoaded extends MessageState {
  const MessageLoaded({required this.messages});
  final List<MessageEntity> messages;

  @override
  List<Object> get props => [messages];
}
final class MessageFailure extends MessageState {}
