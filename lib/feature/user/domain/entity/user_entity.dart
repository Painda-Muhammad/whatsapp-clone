import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final bool? isOnline;
  final String? status;
  final String? profileUrl;

  const UserEntity({
     this.uid,
     this.name,
     this.phoneNumber,
     this.email,
     this.password,
     this.isOnline,
     this.status,
     this.profileUrl,
  });

  @override
  List<Object?> get props =>
      [uid, name, phoneNumber, email, password, isOnline, status, profileUrl];
}
