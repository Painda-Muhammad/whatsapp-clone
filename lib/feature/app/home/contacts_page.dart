

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/chat/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/single_user/cubit/get_single_user_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/user/cubit/user_cubit.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key, required this.uid});
  final String uid;
  
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).allUsers();
    BlocProvider.of<GetSingleUserCubit>(context).singleUser(uid: widget.uid);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if(state is GetSingleUserLoaded){
            final currentUser = state.singleUser;
          return BlocBuilder<UserCubit,UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  final contacts = state.users.where((user) => user.uid != widget.uid).toList();
                  if (contacts.isEmpty) {
                    return const Center(
                      child: Text('No Contacts are Available!'),
                    );
                  }
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(PageConst.singleChatPage,arguments: MessageEntity(
                      senderUid: currentUser.uid,
                      senderName: currentUser.name,
                      senderProfile: currentUser.profileUrl,
                      recipientUid: contact.uid,
                      recipientName: contact.name,
                      recipientProfile: contact.profileUrl,
                      uid: widget.uid,
                    ),),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 0),
                          leading: Container(
                            width: 55,
                            height: 55,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: profileWidget(imageUrl: contact.profileUrl),
                            )
                          ),
                          title: Text(
                            '${contact.name}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle:  Text(contact.status!),
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
            );

          }
            return const Center(
                  child: CircularProgressIndicator(
                    color: tabColor,
                  ),
                );
        },
      ),
    );
  }
}

// pick contacts form phone 

// return ListView.builder(
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 return ListTile(
//                   contentPadding: const EdgeInsets.only(left: 0),
//                   leading: Container(
//                     width: 55,
//                     height: 55,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(30)),
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Image.memory(
//                           contact.photo ?? Uint8List(0),
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset('assets/profile_default.png');
//                           },
//                         )),
//                   ),
//                   title: Text(
//                     '${contact.name!} ${contact.name!.last}',
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   subtitle: const Text('Hey! there i am using whatsapp'),
//                 );
//               },
//             );