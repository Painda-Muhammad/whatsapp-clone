import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/getAll_user.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/update_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.allUserUsecase,
    required this.updateUserUsecase,
  }) : super(UserInitial());
  final GetAllUserUsecase allUserUsecase;
  final UpdateUserUsecase updateUserUsecase;

  Future<void> allUsers() async {
    emit(UserLoading());
    try {
      final streamResponse = allUserUsecase.call();
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user})async{
    emit(UserLoading());
    try{
     await updateUserUsecase.call(user);
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_){
      emit(UserFailure());
    }
  }
}
