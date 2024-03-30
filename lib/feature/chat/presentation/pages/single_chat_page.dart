import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/message/cubit/message_cubit.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/attach_window.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/message_layout.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/widgets/new_message.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key, required this.messages});
  final MessageEntity messages;

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  bool isShowAttachWindows = false;
  //   isShowAttach(){
  //     isShowAttachWindow
  // }
  final _messageController = TextEditingController();
 final _scrollController = ScrollController();

//  scroll to the bottom 
  Future<void> _scrollToBottom()async{
    if(_scrollController.hasClients){
      await Future.delayed(const Duration(milliseconds: 100));
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:const Duration(milliseconds: 200), curve:Curves.easeIn);
    }
  }

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<MessageCubit>(context).getMessages(messages: MessageEntity(senderUid: widget.messages.senderUid,recipientUid: widget.messages.recipientUid));
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _scrollToBottom(),);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.messages.recipientName.toString()),
            const Text(
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
      body: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          if(state is MessageLoaded){
            final message = state.messages;  
          return GestureDetector(
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
                      child: ListView.builder(
                        controller: _scrollController,
                          itemCount: message.length,
                          itemBuilder: (context, index) {
                            if(message.isEmpty){
                              return const Center(child: Text('No message yet!'),);
                            }
                            if(message[index].senderUid == widget.messages.senderUid){
                              return  messageLayout(
                            message: message[index].message.toString(),
                            alignment: Alignment.topRight,
                            context: context,
                            createAt: Timestamp.now(),
                            isSeen: true,
                            isShowTick: true,
                            messageColor: tabColor,
                          );
                            }else{
                               return  messageLayout(
                            message: message[index].message,
                            alignment: Alignment.topLeft,
                            context: context,
                            createAt: message[index].createdAt,
                            isSeen: false,
                            isShowTick: false,
                            messageColor: senderMessageColor,
                          );
                            }
                            
                          } 
                         
                        
                      ),
                    ),
                    NewMessage(
                      isShowAttach: (isShowAttachWindow) {
                        setState(() {
                          isShowAttachWindows = isShowAttachWindow;
                        });
                      },
                      messageController: _messageController,
                      messageEntity: widget.messages,
                      scrollToBottom: _scrollToBottom,
                    ),
                  ],
                ),
                if (isShowAttachWindows)
                  Positioned(
                    bottom: 65,
                    top: 340,
                    left: 15,
                    right: 16,
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .20,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 5),
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
                                attachWindowItem(Icons.camera_alt, Colors.pink,
                                    'Camera', () {}),
                                attachWindowItem(Icons.document_scanner_rounded,
                                    Colors.purple, 'Gallery', () {}),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                attachWindowItem(Icons.headphones,
                                    Colors.orange, 'Music', () {}),
                                attachWindowItem(
                                    Icons.location_on, tabColor, 'Map', () {}),
                                attachWindowItem(Icons.person, Colors.blueGrey,
                                    'Contacts', () {}),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                attachWindowItem(Icons.poll_rounded, tabColor,
                                    'Poll', () {}),
                                attachWindowItem(Icons.gif_box_outlined,
                                    Colors.blueAccent, 'Gif', () {}),
                                attachWindowItem(Icons.videocam,
                                    Colors.lightGreen, 'Video', () {}),
                              ],
                            ),
                          ],
                        )),
                  ),
              ],
            ),
          );
          }
          return const Center(child: CircularProgressIndicator(color: tabColor,),);
        },
      ),
    );
  }
}
