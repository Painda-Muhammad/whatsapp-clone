part of 'credential_cubit.dart';

sealed class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

final class CredentialInitial extends CredentialState {}
final class CredentialLoading extends CredentialState {}
final class CredentialSucess extends CredentialState {}
final class CredentialPhoneAuthSmsCodeRecived extends CredentialState {}
final class CredentialPhoneAuthProfileInfo extends CredentialState  {}
final class CredentialFailure extends CredentialState {}