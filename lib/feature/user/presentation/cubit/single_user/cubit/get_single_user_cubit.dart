import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/get_single_user.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  GetSingleUserCubit({required this.singleUserUsecase})
      : super(GetSingleUserInitial());

  final GetSingleUserUsecase singleUserUsecase;

  Future<void> singleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      final streamReponse = singleUserUsecase.call(uid);
      streamReponse.listen(
        (users) {
          emit(GetSingleUserLoaded(singleUser: users.first));
        },
      );
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
