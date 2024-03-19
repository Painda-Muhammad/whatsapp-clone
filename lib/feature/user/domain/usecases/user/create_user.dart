

import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class CreateUserUsecase{
  CreateUserUsecase(this._repository);
  final Repository _repository;

  Future<void> call(UserEntity user){
    return _repository.createUser(user);
  }
}