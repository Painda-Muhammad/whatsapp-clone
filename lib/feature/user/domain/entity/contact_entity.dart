import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? uid;
  final String? label;
  final String? phoneNumber;
  final String? status;
  final Uint8List? profileUrl;

 const ContactEntity({
    this.uid,
    this.label,
    this.phoneNumber,
    this.status,
    this.profileUrl,
  });

  @override
  List<Object?> get props => [];
}
