import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/current_user_uid.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/issign_in.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/signout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.isSigninUsecase,
    required this.signOutUsecase,
    required this.currentUserUidUsecase,
  }) : super(AuthInitial());

  final IsSigninUsecase isSigninUsecase;
  final SignOutUsecase signOutUsecase;
  final CurrentUserUidUsecase currentUserUidUsecase;

  Future<void> appStarted() async {
    try {
      final uid = await currentUserUidUsecase.call();
      await isSigninUsecase.call().then((value) => emit(Authenticated(uid: uid)));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await currentUserUidUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
