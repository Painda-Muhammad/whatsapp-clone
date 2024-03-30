

import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class VerifyPhoneNumberUsecase{

  final Repository _repository;
  const VerifyPhoneNumberUsecase(this._repository);

 Future<void> call(String phoneNumber){
    return _repository.verifyPhoneNumber(phoneNumber);
  }
}