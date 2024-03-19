part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}
final class UserLoaded extends UserState {
 final List<UserEntity> users;
  const UserLoaded({required this.users});
}
final class UserFailure extends UserState {}
