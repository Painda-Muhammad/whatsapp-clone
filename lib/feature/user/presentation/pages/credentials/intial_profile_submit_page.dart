

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_app/feature/app/constants/app_const.dart';

import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone_app/storage/storage_provider.dart';

class IntialProfileSubmitPage extends StatefulWidget {
  const IntialProfileSubmitPage({super.key , required this.phoneNumber});

  final String phoneNumber;

  @override
  State<IntialProfileSubmitPage> createState() => _IntialProfileSubmitPageState();
}

class _IntialProfileSubmitPageState extends State<IntialProfileSubmitPage> {

final TextEditingController  _nameController = TextEditingController();
 File? _image;
 bool _isProfileUploading = false;

   Future<void> _selectImage()async{
    try{
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if(pickedFile != null){
            _image = File(pickedFile.path);
        }else{
          if(kDebugMode){
          print('no image hase been selected');

          }
        }
      });

    }catch(e){
      toast('some error occured while picking image $e');
    }
  }
  

  

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: Column(
          children: [
            const Text("Profile Info",style: TextStyle(
              fontSize: 20,
              color: tabColor,fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 10,),
            const Text('Please provide your name and optional profile phote',textAlign: TextAlign.center,style: TextStyle(
              fontSize: 16
            ),), 
            const SizedBox(height: 30,),
           
            GestureDetector(
              onTap: _selectImage,
              child: SizedBox(
                width: 50,
                height: 50,
              child:ClipRRect(borderRadius: BorderRadius.circular(25),
              child: profileWidget(image: _image),
              ),
              ),
            ),
            const SizedBox(height: 10,),

            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: tabColor,width: 1.5))
              ),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none
                ),
              ),
            ),
            const SizedBox(height: 20,),

            
              GestureDetector(
                onTap: submitProfileInfo,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:  Center(
                    child: _isProfileUploading ? const CircularProgressIndicator(): const Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

  }

  void submitProfileInfo(){
    if(_image != null){
      StorageProviderRemoteDataSource.uploadProfileImage(
        file: _image!,
        onComplete: (isUploading){
          setState(() {
            _isProfileUploading = isUploading;
          });
        },
        ).then((profileUrl){
          _profileInfo(
            profileImageUrl: profileUrl,
          );
        } );
    }else{
      _profileInfo(profileImageUrl: '');
    }
  }

  void _profileInfo({required String profileImageUrl}){
    if(_nameController.text.isNotEmpty){
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(user: UserEntity(
      email: '',
      name: _nameController.text,
      isOnline: false,
      profileUrl: profileImageUrl,
      phoneNumber: widget.phoneNumber,
      status: 'Hey! there i am using whatsApp clone'
    ));
    }
  }
}