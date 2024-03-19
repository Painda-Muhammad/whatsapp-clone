import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/attach_window.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/message_layout.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/new_message.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {

  bool isShowAttachWindows = false;
  //   isShowAttach(){
  //     isShowAttachWindow 
  // }
  final _messageController = TextEditingController();

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Nasir'),
            Text(
              ' online',
              style: TextStyle(
                fontSize: 11,
              ),
            )
          ],
        ),
        actions: const [
          Icon(Icons.videocam),
          SizedBox(
            width: 25,
          ),
          Icon(Icons.call),
          SizedBox(
            width: 25,
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: GestureDetector(
        onTap: () => setState(() {
          isShowAttachWindows = false;
        }),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: 0,
                child: Image.asset('assets/whatsapp_bg_image.png',
                    fit: BoxFit.fill)),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                        messageLayout(
                          message: 'hello',
                          alignment: Alignment.topRight,
                          context: context,
                          createAt: Timestamp.now(),
                          isSeen: true,
                          isShowTick: true,
                          messageColor: tabColor,
                           
                        ),
                       
                       messageLayout(
                          message: 'hello i am using the whats for create writing the code',
                          alignment: Alignment.topRight,
                          context: context,
                          createAt: Timestamp.now(),
                          isSeen: true,
                          isShowTick: true,
                          messageColor: tabColor, 
                        ),

                         messageLayout(
                          message: 'this use is not me',
                          alignment: Alignment.topLeft,
                          context: context,
                          createAt: Timestamp.now(),
                          isSeen: false,
                          isShowTick: false,
                          messageColor: senderMessageColor,
                           
                        )

                    ],
                  ),
                ),
                NewMessage(
                  isShowAttach: (isShowAttachWindow) {
                    setState(() {
                    isShowAttachWindows = isShowAttachWindow; 

                    });
                  },
                  messageController: _messageController,
                ),
              ],
            ),
            if(isShowAttachWindows)
            Positioned(
              bottom: 65,
              top: 340,
              left: 15,
              right: 16,
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .20,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: bottomAttachContainerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          attachWindowItem(Icons.document_scanner_rounded,
                              Colors.deepPurple, 'Documents', () {}),
                          attachWindowItem(
                              Icons.camera_alt, Colors.pink, 'Camera', () {}),
                          attachWindowItem(Icons.document_scanner_rounded,
                              Colors.purple, 'Gallery', () {}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          attachWindowItem(
                              Icons.headphones, Colors.orange, 'Music', () {}),
                          attachWindowItem(
                              Icons.location_on, tabColor, 'Map', () {}),
                          attachWindowItem(
                              Icons.person, Colors.blueGrey, 'Contacts', () {}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          attachWindowItem(
                              Icons.poll_rounded, tabColor, 'Poll', () {}),
                          attachWindowItem(Icons.gif_box_outlined,
                              Colors.blueAccent, 'Gif', () {}),
                          attachWindowItem(Icons.videocam, Colors.lightGreen,
                              'Video', () {}),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }




  // Widget newMessage({
  //   TextEditingController? messageController,
  //   bool? isShowAttachWindow,
  // }
  // ) {
  //   return Container(
  //               margin:
  //                   const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10),
  //                       height: 50,
  //                       alignment: Alignment.centerLeft,
  //                       decoration: BoxDecoration(
  //                           color: senderMessageColor,
  //                           borderRadius: BorderRadius.circular(25)),
  //                       child: Row(
  //                         children: [
  //                           const Icon(Icons.emoji_emotions),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           Expanded(
  //                             child: TextField(
  //                               onTap: () => setState(() {
  //                                 isShowAttachWindow = false;
  //                               }),
  //                               controller: _messageController,
  //                               cursorColor: tabColor,
  //                               decoration: const InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: 'Message',
  //                               ),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               setState(() {
  //                                 isShowAttachWindow = !isShowAttachWindow!;
  //                               });
  //                             },
  //                             child: Transform.rotate(
  //                                 angle: -.5,
  //                                 child: const Icon(Icons.attach_file)),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           const Icon(Icons.camera_alt)
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 5,
  //                   ),
  //                   Container(
  //                     width: 55,
  //                     height: 55,
  //                     decoration: BoxDecoration(
  //                         color: tabColor,
  //                         borderRadius: BorderRadius.circular(30)),
  //                     child: Center(
  //                         child: Icon(messageController!.text.isEmpty
  //                             ? Icons.mic
  //                             : Icons.send)),
  //                   )
  //                 ],
  //               ),
  //             );
  // }


  
}
