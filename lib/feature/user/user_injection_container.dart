


import 'package:whatsapp_clone_app/feature/injection_container.dart';
import 'package:whatsapp_clone_app/feature/user/data/data_source/remote/user_remote_data_source_impl.dart';
import 'package:whatsapp_clone_app/feature/user/data/data_source/remote/user_remote_datas_source.dart';
import 'package:whatsapp_clone_app/feature/user/data/repository/user_repository_impl.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/current_user_uid.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/issign_in.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/signin_with_phone_number.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/signout.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/credential/verify_phone_number.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/create_user.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/getAll_user.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/get_device_number.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/get_single_user.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/update_user.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/get_device_number/cubit/get_device_number_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/single_user/cubit/get_single_user_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/user/cubit/user_cubit.dart';

Future<void> userInjectionContainer()async{

  // Bloc or Cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(isSigninUsecase: sl.call(), signOutUsecase: sl.call(), currentUserUidUsecase: sl.call())) ;
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(signInWithPhoneNumber: sl.call(), verifyPhoneNumberUsecase: sl.call(), createUserUsecase: sl.call()));
  sl.registerFactory<GetDeviceNumberCubit>(() => GetDeviceNumberCubit(getDeviceNumberUsecase: sl.call()));
  sl.registerFactory<GetSingleUserCubit>(() => GetSingleUserCubit(singleUserUsecase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(allUserUsecase: sl.call(), updateUserUsecase: sl.call()));



  // usecase
  sl.registerLazySingleton<CurrentUserUidUsecase>(() => CurrentUserUidUsecase(sl.call()));
  sl.registerLazySingleton<IsSigninUsecase>(() => IsSigninUsecase(sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumber>(() => SignInWithPhoneNumber(sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUsecase>(() => VerifyPhoneNumberUsecase(sl.call()));

  sl.registerLazySingleton<CreateUserUsecase>(() => CreateUserUsecase(sl.call()));
  sl.registerLazySingleton<GetDeviceNumberUsecase>(() => GetDeviceNumberUsecase(sl.call()));
  sl.registerLazySingleton<GetSingleUserUsecase>(() => GetSingleUserUsecase(sl.call()));
  sl.registerLazySingleton<GetAllUserUsecase>(() => GetAllUserUsecase(sl.call()));
  sl.registerLazySingleton<UpdateUserUsecase>(() => UpdateUserUsecase(sl.call()));

  // data source
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(auth: sl.call(),firestore: sl.call()));

  // repository
  sl.registerLazySingleton<Repository>(() =>UserRepositoryImpl(sl.call()) );
}