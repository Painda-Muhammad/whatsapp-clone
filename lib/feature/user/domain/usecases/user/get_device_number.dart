

import 'package:whatsapp_clone_app/feature/user/domain/entity/contact_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class GetDeviceNumberUsecase{
  final Repository _repository;
  const GetDeviceNumberUsecase(this._repository);

  Future<List<ContactEntity>> call(){
    return _repository.getDeviceNumber();
  }
}