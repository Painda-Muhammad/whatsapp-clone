

import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class GetSingleUserUsecase{

  final Repository _repository;
  const GetSingleUserUsecase(this._repository);

  Stream<List<UserEntity>> call(String uid){
   return _repository.getSingleUser(uid);
  }
}