import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';

import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageConst.singleChatPage);
          },
          child: ListTile(
            leading: SizedBox(height: 50,width: 50,child: ClipRRect(borderRadius: BorderRadius.circular(25),child: profileWidget()),),
            title:const Text('User name',style: TextStyle(
              fontSize: 16,
            ),),
            subtitle:const Text('sent message',overflow:TextOverflow.ellipsis),
            trailing: Text(DateFormat.jm().format(DateTime.now())),
          ),
        );
      },
      ),
    );
  }
}