import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class UpdateUserUsecase{

  final Repository _repository;
  const UpdateUserUsecase(this._repository);

  Future<void> call(UserEntity user){
   return _repository.updateUser(user);
  }
}