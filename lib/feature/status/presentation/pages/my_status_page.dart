import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

class MyStatusPage extends StatelessWidget {
  const MyStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('My Status'),
      ),
      body: Column(
        children: [
          Container(
            margin:const EdgeInsets.all(10),
            child: Row(
              children: [
                  SizedBox(
                width: 55,
                height: 55,
                child: ClipRRect(borderRadius: BorderRadius.circular(30),
                child: profileWidget(),
                ),
              ),
              const SizedBox(width: 10,),
              Text(GetTimeAgo.parse(DateTime.now()),style: const TextStyle(
                fontSize: 17
              ),),
              const Spacer(),
          
              PopupMenuButton(
                color: appBarColor,
                icon: const Icon(Icons.more_vert,color: greyColor,),
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text('Delete'))
              ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}