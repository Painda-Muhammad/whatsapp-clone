import 'package:whatsapp_clone_app/feature/chat/data/data%20source/chat_remot_data_source.dart';
import 'package:whatsapp_clone_app/feature/chat/data/data%20source/chat_remote_data_source_impl.dart';
import 'package:whatsapp_clone_app/feature/chat/data/repository/repository_impl.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/repository/chat_repository.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/delete_message_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/get_messages_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/get_my_chat_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/chat/cubit/chat_cubit.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/message/cubit/message_cubit.dart';
import 'package:whatsapp_clone_app/feature/injection_container.dart';

Future<void> chatInjectionContainer() async {
  // cubits
  sl.registerFactory<ChatCubit>(
      () => ChatCubit(deletChatUsecase: sl.call(), getChatUsecase: sl.call()));
  sl.registerFactory<MessageCubit>(
      () => MessageCubit(sl.call(), sl.call(), sl.call()));
  // usecases
  sl.registerLazySingleton<SendMessageUsecase>(
      () => SendMessageUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetMyChatUsecase>(
      () => GetMyChatUsecase(repository: sl.call()));
  sl.registerLazySingleton<DeletChatUsecase>(
      () => DeletChatUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUsecase>(
      () => GetMessageUsecase(repository: sl.call()));
  sl.registerLazySingleton<DeletMessageUsecase>(
      () => DeletMessageUsecase(repository: sl.call()));
  // data source
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(firestore: sl.call()));

  // repository
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl.call()));
}
