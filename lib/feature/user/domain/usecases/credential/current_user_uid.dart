

import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class CurrentUserUidUsecase{
  final Repository _repository;

  CurrentUserUidUsecase(this._repository);

  Future<String> call(){
   return _repository.currentUserUID();
  }
}