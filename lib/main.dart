import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone_app/feature/app/home/home_page.dart';
import 'package:whatsapp_clone_app/feature/app/splash/splash_screen.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/chat/cubit/chat_cubit.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/message/cubit/message_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/get_device_number/cubit/get_device_number_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/single_user/cubit/get_single_user_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone_app/firebase_options.dart';

import 'package:whatsapp_clone_app/routes/on_generate_route.dart';

import 'package:whatsapp_clone_app/feature/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<GetDeviceNumberCubit>(
          create: (context) => di.sl<GetDeviceNumberCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider<ChatCubit>(create: (context) => di.sl<ChatCubit>(),),
        BlocProvider<MessageCubit>(create: (context) => di.sl<MessageCubit>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            dialogBackgroundColor: appBarColor,
            appBarTheme: const AppBarTheme(
              color: appBarColor,
            )),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoutes.route,
        routes: {
          '/': (context) => BlocBuilder<AuthCubit,AuthState>(builder: (context, authState) {
              if(authState is Authenticated){
                return HomePage(uid: authState.uid);
              }else{
                return const SplashScreen();
              }

          },),
        },
      ),
    );
  }
}
