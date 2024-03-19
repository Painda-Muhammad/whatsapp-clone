import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

class CallContactsPage extends StatelessWidget {
  const CallContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
      
      ),
      body:  ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
        return  ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(30),child: profileWidget()),
                  ),
                  title: const Text('User name', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  subtitle: const Text('Hey! there i am using whatsapp'),
                  trailing:const Wrap(children: [
                    Icon(Icons.call,color: tabColor,),
                    SizedBox(width: 10,),
                    Icon(Icons.videocam,color: tabColor,),
                  
                  ],),
                );
      },),
    );
  }
}