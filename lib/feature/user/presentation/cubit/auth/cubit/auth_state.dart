part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
final class Authenticated extends AuthState{
   
  final String uid;
  const Authenticated({required this.uid});
   @override
  List<Object> get props => [uid];
}
final class UnAuthenticated extends AuthState{

}
