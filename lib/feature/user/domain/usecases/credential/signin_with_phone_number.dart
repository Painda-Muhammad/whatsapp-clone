

import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class SignInWithPhoneNumber {
  final Repository _repository;
  SignInWithPhoneNumber(this._repository);

    Future<void>  call(String smsPinCode){
        return _repository.signInWithPhoneNumber(smsPinCode);
      }
}