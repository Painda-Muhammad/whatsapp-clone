
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_app/feature/app/constants/app_const.dart';
import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/user/cubit/user_cubit.dart';

import 'package:whatsapp_clone_app/storage/storage_provider.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  File? _image;
  bool _isProfileUpdating = false;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          if(kDebugMode){
          print("no image has been selected");

          }
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  void initState() {
    _usernameController = TextEditingController(text: widget.currentUser.name);
    _aboutController = TextEditingController(text: widget.currentUser.status);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: profileWidget(imageUrl: widget.currentUser.profileUrl, image: _image),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: blackColor,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _profileItem(
                  controller: _usernameController,
                  title: "Name",
                  description: "Enter username",
                  icon: Icons.person,
                  onTap: () {}),
              _profileItem(
                  controller: _aboutController,
                  title: "About",
                  description: "Hey there I'm using WhatsApp",
                  icon: Icons.info_outline,
                  onTap: () {}),
              _settingsItemWidget(
                  title: "Phone", description: "${widget.currentUser.phoneNumber}", icon: Icons.phone, onTap: () {}),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: submitProfileInfo,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _isProfileUpdating == true
                      ? const Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }

  _profileItem(
      {String? title, String? description, IconData? icon, VoidCallback? onTap, TextEditingController? controller}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                icon,
                color: greyColor,
                size: 25,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: description!,
                        suffixIcon: const Icon(
                          Icons.edit_rounded,
                          color: tabColor,
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _settingsItemWidget({String? title, String? description, IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                icon,
                color: greyColor,
                size: 25,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$description",
                  style: const TextStyle(fontSize: 17),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void submitProfileInfo() {
    if (_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
          file: _image!,
          onComplete: (onProfileUpdateComplete) {
            setState(() {
              _isProfileUpdating = onProfileUpdateComplete;
            });
          }).then((profileImageUrl) {
        _profileInfo(profileUrl: profileImageUrl);
      });
    } else {
      _profileInfo(profileUrl: widget.currentUser.profileUrl);
    }
  }

  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context)
          .updateUser(
              user: UserEntity(
        uid: widget.currentUser.uid,
        email: "",
        
        name: _usernameController.text,
        phoneNumber: widget.currentUser.phoneNumber,
        status: _aboutController.text,
        isOnline: false,
        profileUrl: profileUrl,
      ))
          .then((value) {
        toast("Profile updated");
      });
    }
  }
}



















// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:whatsapp_clone_app/feature/app/global/widgets/profile_widget.dart';
// import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
// import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
// import 'package:whatsapp_clone_app/feature/user/presentation/cubit/user/cubit/user_cubit.dart';
// import 'package:whatsapp_clone_app/storage/storage_provider.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key, required this.userInfo});
//   final UserEntity userInfo;

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _aboutController = TextEditingController();
//   File? image;
//   bool isLoading = false;

//   @override
//   void initState() {
//     _nameController = TextEditingController(text: widget.userInfo.name);
//     _aboutController = TextEditingController(text: widget.userInfo.status);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _aboutController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }

//   void _editInfo(
//       {required BuildContext context,
//       required String title,
//       required TextEditingController description}) {
//     _bottonSheet(context, title: title, description: description);
//   }

//   Future<dynamic> _bottonSheet(BuildContext context,
//       {String? title, TextEditingController? description}) {
//     return showModalBottomSheet(
//         context: context,
//         // constraints:  const BoxConstraints(maxHeight: 147),
//         builder: (context) {
//           return Container(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title!),
//                 TextField(
//                   controller: description,
//                   decoration: InputDecoration(
                    
//                     hintText: description!.text),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           'Cancel',
//                           style: TextStyle(color: tabColor),
//                         )),
//                     TextButton(
//                         onPressed: () {
//                           _updateUserInfo(
//                             _nameController.text,
//                             _aboutController.text,
//                           );
//                         },
//                         child: isLoading
//                             ? const Expanded(child: CircularProgressIndicator())
//                             : const Text('Save',
//                                 style: TextStyle(color: tabColor)))
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: const EdgeInsets.all(10),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 SizedBox(
//                   width: 100,
//                   height: 100,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: InkWell(
//                         onTap: () {
//                           _pickImage();
//                         },
//                         child: profileWidget(image: image)),
//                   ),
//                 ),
//                 Positioned(
//                     bottom: -3,
//                     right: -3,
//                     child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: tabColor,
//                           border: Border.all(
//                             color: backgroundColor,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: backgroundColor,
//                         )))
//               ],
//             ),
//           ),
//           _editSingleUserInfo(
//               ontap: () {
//                 _editInfo(
//                     context: context,
//                     title: 'Enter your name',
//                     description: _nameController);
//               },
//               icon: Icons.person,
//               nameTile: 'Name',
//               name: widget.userInfo.name.toString()),
//           _editSingleUserInfo(
//               ontap: () {
//                 _editInfo(
//                     context: context,
//                     title: 'About',
//                     description: _aboutController);
//               },
//               icon: Icons.import_export,
//               nameTile: 'About',
//               name: widget.userInfo.status.toString()),
//           _editSingleUserInfo(
//               icon: Icons.call,
//               nameTile: 'Phone',
//               name: widget.userInfo.phoneNumber.toString(),
//               editIcons: false)
//         ],
//       ),
//     );
//   }

//   Widget _editSingleUserInfo(
//       {required IconData icon,
//       required String nameTile,
//       required String name,
//       Function()? ontap,
//       bool? editIcons = true}) {
//     return InkWell(
//       onTap: ontap,
//       child: Container(
//         height: 60,
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Icon(icon),
//             const SizedBox(
//               width: 20,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   nameTile,
//                   style: const TextStyle(color: greyColor),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Expanded(child: Text(name)),
//               ],
//             ),
//             const Spacer(),
//             editIcons!
//                 ? const Icon(
//                     Icons.edit,
//                     color: tabColor,
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }

//   Future _updateUserInfo(
//     String? name,
//     String? info,
//   ) async {
//       print(name);
//       print(info);
//     // setState(() {
//     //   isLoading = true;
//     // });
    
//     if(image != null)
//         {
//          await StorageProviderRemoteDataSource.uploadProfileImage(file: image!,onComplete: (isUploading) {
//           setState(() {
//           isLoading = isUploading; 
//           });
//         },)
//             .then((imageUrl) => BlocProvider.of<UserCubit>(context).updateUser(
//                 user: UserEntity(
//                     uid: widget.userInfo.uid,
//                     name: name!,
//                     status: info!,
//                     profileUrl: imageUrl)));
//          }else{
//           await  BlocProvider.of<UserCubit>(context).updateUser(
//             user: UserEntity(
//             uid: widget.userInfo.uid,
//             name: name!,
//             status: info!,
//           ));
//          } 
//     // setState(() {
//     //   isLoading = false;
//     // });
//       print('not loading');
//   }

//   Future _pickImage() async {
//     final img = await ImagePicker().pickImage(source: ImageSource.camera);
//     setState(() {
//       image = File(img!.path);
//     });
//   }
// }
