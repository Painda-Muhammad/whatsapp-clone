import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final bool? isOnline;
  final String? status;
  final String? profileUrl;

  const UserModel(
      {this.uid,
      this.name,
      this.phoneNumber,
      this.email,
      this.isOnline,
      this.status,
      this.profileUrl})
      : super(
          uid: uid,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          isOnline: isOnline,
          status: status,
          profileUrl: profileUrl,
        );

  factory UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    // final snap = snapshot.data()  as Map<String,dynamic>;
    return UserModel(
        uid: snapshot.get('uid'),
        name: snapshot.get('name'),
        phoneNumber: snapshot.get('phoneNumber'),
        email: snapshot.get('email'),
        isOnline: snapshot.get('isOnline'),
        status: snapshot.get('status'),
        profileUrl: snapshot.get('profileUrl'));
  }

 Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'isOnline': isOnline,
      'status': status,
      'profileUrl': profileUrl,
    };
  }
}
