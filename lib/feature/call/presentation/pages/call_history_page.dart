import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/global/date/date_formats.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            const Text('Recent',style: TextStyle(
              color: greyColor,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 15,),
      
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder:(context, index) {
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
                    // fontWeight: FontWeight.w600
                  ),),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.call_made,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text(formatDateTime(DateTime.now()))
                    ],
                  ),
                  trailing: const Icon(Icons.call,color: tabColor,),
                );
              }, ),
            )
          ],
        ),
      ),
    );
  }
}