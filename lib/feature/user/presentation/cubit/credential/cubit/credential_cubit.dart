import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/signin_with_phone_number.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/verify_phone_number.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/create_user.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit({
    required this.signInWithPhoneNumber,
    required this.verifyPhoneNumberUsecase,
    required this.createUserUsecase,
  }) : super(CredentialInitial());

  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifyPhoneNumberUsecase verifyPhoneNumberUsecase;
  final CreateUserUsecase createUserUsecase;

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    emit(CredentialLoading());
    try {
      await verifyPhoneNumberUsecase.call(phoneNumber);
      emit(CredentialPhoneAuthSmsCodeRecived());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSmsCode({required String smsPinCode}) async {
    try {
      await signInWithPhoneNumber.call(smsPinCode);
      emit(CredentialPhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitProfileInfo({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await createUserUsecase.call(user);
      emit(CredentialSucess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
