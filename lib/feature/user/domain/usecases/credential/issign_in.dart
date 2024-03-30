

import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class IsSigninUsecase{

  final Repository _repository;
  const IsSigninUsecase(this._repository);

  Future<bool> call(){
    return _repository.isSignIn();
   }
}