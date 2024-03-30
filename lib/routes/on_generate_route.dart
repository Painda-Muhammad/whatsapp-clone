import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';
import 'package:whatsapp_clone_app/feature/app/home/contacts_page.dart';
import 'package:whatsapp_clone_app/feature/app/home/home_page.dart';
import 'package:whatsapp_clone_app/feature/app/setting/settings_page.dart';
import 'package:whatsapp_clone_app/feature/app/welcom/welcome_page.dart';
import 'package:whatsapp_clone_app/feature/call/presentation/pages/call_contacts_page.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/pages/single_chat_page.dart';
import 'package:whatsapp_clone_app/feature/status/presentation/pages/my_status_page.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/edit_profile_page.dart';

import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/intial_profile_submit_page.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/login_page.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/opt_page.dart';

class OnGenerateRoutes{

  static Route<dynamic> route(RouteSettings setting){
      final args= setting.arguments;
      final name = setting.name;

      switch(name){
        case PageConst.welcomePage: return _materialPageBuilder(const WelcomePage());
        case PageConst.otpPage: return _materialPageBuilder(const OtpPage());
        case PageConst.loginPage: return _materialPageBuilder(const LoginPage());
        case PageConst.initialProfileSubmitPage:{
          if(args is String ){
             return _materialPageBuilder( IntialProfileSubmitPage(phoneNumber: args,));
          }else{
            return _materialPageBuilder(const ErrorPage());
          }
        }
        case PageConst.homePage: {
          if(args is String){
            return _materialPageBuilder( HomePage(uid: args,));
          }else{
           return _materialPageBuilder(const ErrorPage());
          }

        }
        case PageConst.editProfilePage:{
          if(args is UserEntity){
            return _materialPageBuilder(EditProfilePage(currentUser: args,));
          }else{
            return _materialPageBuilder(const ErrorPage());
          }
        }
        case PageConst.contactUsersPage: {
          if(args is String){
            return _materialPageBuilder(ContactsPage(uid: args,));
          }else{
           return _materialPageBuilder(const ErrorPage());
          }
        }
        case PageConst.settingsPage: {
          if(args is String){
            return _materialPageBuilder( SettingsPage(uid: args,));
          }else{
           return  _materialPageBuilder(const ErrorPage());
          }
        }
        case PageConst.singleChatPage: {
          if(args is MessageEntity){
            return _materialPageBuilder( SingleChatPage(messages: args,));
          }else{
            return _materialPageBuilder(const ErrorPage());
          }
        }
        case PageConst.myStatusPage: return _materialPageBuilder(const MyStatusPage());
        case PageConst.callContactsPage: return _materialPageBuilder(const CallContactsPage());
        default: return _materialPageBuilder(const ErrorPage());
      }
  }

  static MaterialPageRoute<dynamic> _materialPageBuilder(Widget widget) {
    return MaterialPageRoute(builder:(context) {
        return widget;
      },
       );
  }

  

  
}
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Error Page'),),);
  }
}