import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class GetAllUserUsecase{

  final Repository _repository;
  const GetAllUserUsecase(this._repository);

  Stream<List<UserEntity>> call(){
   return _repository.getAllUser();
  }
}