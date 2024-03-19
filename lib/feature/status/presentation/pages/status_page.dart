import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';
import 'package:whatsapp_clone_app/feature/app/global/date/date_formats.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';



class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 15, top: 15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Status',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(height: 10,),
            Row(
              children: [
              Stack(
                clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(borderRadius: BorderRadius.circular(25),child: profileWidget(),),
                    ),

                     Positioned(
                      bottom: -3,
                      right: -3,
                      child: Container(height:25,width: 25,decoration: BoxDecoration(
                        color:tabColor,
                        border: Border.all(
                          color: backgroundColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),child:const Icon(Icons.add,)))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My Status",style: TextStyle(
                          fontSize: 16,
                      ),),
                      SizedBox(height: 10,),
                      Text("Tap to add status to updated",style: TextStyle(
                        color: greyColor,
                        fontSize: 15
                      ),),
                    ],
                  ),
                ),
                const Spacer(),

                PopupMenuButton(
                  color: appBarColor,
                  icon:const Icon(Icons.more_horiz, color: greyColor,),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: (){
                        Navigator.pushNamed(context, PageConst.myStatusPage);
                      },
                      value: 'Status',
                      child: const Text('My status'))
                  ],)

              ],
            ),
            const SizedBox(height: 10,),
            const Text('Recent updates',style: TextStyle(
              color: greyColor,
              fontWeight: FontWeight.w400
            ),),
           const SizedBox(height: 10,),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                return ListTile(
                        contentPadding:const  EdgeInsets.all(0),
                      leading: Container(height: 55,width: 55,margin: const EdgeInsets.all(3),child: ClipRRect(borderRadius: BorderRadius.circular(30),child: profileWidget()),),
                      title:const Text('User name',style: TextStyle(
              fontSize: 16,
                      ),),
                      subtitle: Text(formatDateTime(DateTime.now())),
                    );
              },),
            )
          ],
        ),
      ),
    );
  }
}