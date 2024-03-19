


import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class SignOutUsecase{
  final Repository _repository;
  const SignOutUsecase(this._repository);

 Future<void> call(){
    return _repository.signOut();
  }
}