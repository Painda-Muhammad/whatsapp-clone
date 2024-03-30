
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone_app/feature/chat/chat_injecton_container.dart';
import 'package:whatsapp_clone_app/feature/user/user_injection_container.dart';

final sl =GetIt.instance;
Future<void> init()async{
    
    
    // Externals
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    sl.registerLazySingleton(() => auth);
    sl.registerLazySingleton(() => firestore);

  await userInjectionContainer();
  await chatInjectionContainer();

}