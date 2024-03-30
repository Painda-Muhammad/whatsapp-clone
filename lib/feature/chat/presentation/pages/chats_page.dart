import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';

import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/chat/presentation/bloc/chat/cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.uid});
  final String uid;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMyChats(ChatEntity(
      senderUid: widget.uid,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          final chatContacts = state.chatContacts;
          if (chatContacts.isEmpty) {
            return const Center(
              child: Text("You haven't chat with any one yet!"),
            );
          }
          return ListView.builder(
            itemCount: chatContacts.length,
            itemBuilder: (context, index) {
              final chatContact = chatContacts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PageConst.singleChatPage,
                    arguments: MessageEntity(
                        senderUid: chatContact.senderUid,
                        senderName: chatContact.senderName,
                        senderProfile: chatContact.senderProfile,
                        recipientUid: chatContact.recipientUid,
                        recipientName: chatContact.recipientName,
                        recipientProfile: chatContact.recipientProfile,
                        uid: widget.uid),
                  );
                },
                child: ListTile(
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: profileWidget()),
                  ),
                  title: Text(
                    chatContact.recipientName.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(chatContact.recentTextMessage.toString(),
                      overflow: TextOverflow.ellipsis),
                  trailing: Text(
                      DateFormat.jm().format(chatContact.createdAt!.toDate())),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: tabColor,
          ),
        );
      },
    ));
  }
}
