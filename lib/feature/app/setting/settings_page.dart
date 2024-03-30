

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/feature/app/constants/page_const.dart';

import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/single_user/cubit/get_single_user_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).singleUser(uid: widget.uid);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
          builder: (context, singleUserState) {
            if(singleUserState is GetSingleUserLoaded){
              return _userInfo(
                userImage: singleUserState.singleUser.profileUrl,
                userName: singleUserState.singleUser.name,
                userStatus: singleUserState.singleUser.status,
                userData: singleUserState.singleUser,
              );
            }
            return _userInfo();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(color: greyColor),
        const SizedBox(
          height: 10,
        ),
        _buildListTileWidget(
            Icons.key, 'Account', 'Security application, change number'),
        _buildListTileWidget(
            Icons.lock, 'Privacy', 'Block contacts, disappearing messages'),
        _buildListTileWidget(
            Icons.message, 'Chats', 'Theme, wallpapers, chat history'),
        _buildListTileWidget(
            ontap: () {
              _conformLogout();
            },
            Icons.exit_to_app, 'Logout', 'Logout from WhatsApp Clone'),
      ]),
    );
  }

  Widget _userInfo({String? userName,String? userImage, String? userStatus,UserEntity? userData}) {
    return ListTile(
            leading: InkWell(
              onTap: (){
                Navigator.pushNamed(context, PageConst.editProfilePage,arguments: userData);
              },
             
              child: SizedBox(
                width: 55,
                height: 55,
                child: profileWidget(imageUrl: userImage ?? ''),
              ),
            ),
            title:  Text(
              userName ?? 'Unknown user',
              style:const TextStyle(
                fontSize: 17,
              ),
            ),
            subtitle:  Text(
              userStatus ?? '',
              style:const TextStyle(
                color: greyColor,
              ),
            ),
            trailing: const Icon(
              Icons.qr_code,
              color: tabColor,
            ),
          );
  }

  Widget _buildListTileWidget(
    IconData icon,
    String title,
    String subtitle,
    { VoidCallback? ontap}
  ) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: greyColor,
          ),
        ),
      ),
    );
  }

  _conformLogout(){
    showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content:const SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('would your like to logout?'),
            ],
          ),
        ),
        actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:const Text('cancel',style: TextStyle(color: tabColor),)),
           GestureDetector(
              onTap: ()async {
                BlocProvider.of<AuthCubit>(context).loggedOut();
                Navigator.pushAndRemoveUntil(context, PageConst.welcomePage as Route<Object?>, (route) => false); 
              },
              child:const Text('logout',style: TextStyle(color: tabColor),)),
        ],
      );
    },
  );
  }
}
