import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/call/presentation/pages/call_history_page.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/pages/chats_page.dart';
import 'package:whatsapp_clone_app/feature/status/presentation/pages/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.uid});
  final String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

 TabController? tabController;
  int _currentTabIndex = 0;


  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {
      setState(() {
        _currentTabIndex= tabController!.index;
      });
     });
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('WhatsApp',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: greyColor
        ),),
        actions:  [
          Row(children: [
            const Icon(Icons.camera_alt_outlined, size: 20,color: greyColor,),
            const SizedBox(width: 25,),
            const Icon(Icons.search, size: 20,color: greyColor,),
            const SizedBox(width: 25,),
            
            PopupMenuButton( 
              
              icon: const Icon(Icons.more_vert,color:greyColor,size: 28 ,),
              color:appBarColor,
              iconSize: 28,
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: (){
                    Navigator.pushNamed(context, PageConst.settingsPage,arguments: widget.uid);
                  },
                  value: 'Settings',
                  child:const Text('Settings'))
              ];
                
              
            },)
            
          ],)
          
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: tabColor,
          unselectedLabelColor: greyColor,
          labelColor: tabColor,
          

          tabs: const [
            
          Tab(child: Text('Chats',style: TextStyle(
            // color: greyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),),),

          Tab(child: Text('Status',style: TextStyle(
            // color: greyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),),),
          Tab(child: Text('Calls',style: TextStyle(
            // color: greyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),),)
        ]) 
        ,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
        ChatPage(uid: widget.uid,),
       const StatusPage(),
       const CallHistoryPage()
      ]),

      floatingActionButton: swatchFloatingActionButtonOnTabIndex(_currentTabIndex),
    );
  }

   swatchFloatingActionButtonOnTabIndex(int index){
    switch(index){
      case 0: 
        return FloatingActionButton(backgroundColor: tabColor,onPressed: (){
          Navigator.pushNamed(context, PageConst.contactUsersPage,arguments: widget.uid);
        },child:const Icon(Icons.message,color: whiteColor,size: 30,),);
      case 1 :return FloatingActionButton(backgroundColor: tabColor,onPressed: (){},child:const Icon(Icons.camera_alt,color: whiteColor,size: 30,),);
      case 2: return FloatingActionButton(backgroundColor: tabColor,onPressed: (){
        Navigator.pushNamed(context, PageConst.callContactsPage,);
      },child:const Icon(Icons.add_ic_call_rounded,color: whiteColor,size: 30,),);
      default: return const Icon(Icons.error,color: tabColor,size: 30,);
    }
  }
}