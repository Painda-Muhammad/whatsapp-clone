
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:flutter_contacts/properties/event.dart';
import 'package:flutter_contacts/properties/group.dart';
import 'package:flutter_contacts/properties/name.dart';
import 'package:flutter_contacts/properties/note.dart';
import 'package:flutter_contacts/properties/organization.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:flutter_contacts/properties/social_media.dart';
import 'package:flutter_contacts/properties/website.dart';

class ContactEntity extends Equatable {
    String? id;
    String? displayName;
    Uint8List? photo;
    Uint8List? thumbnail;
    Name? name;
    List<Phone>? phones;
    List<Email>? emails;
    List<Address>? addresses;
    List<Organization>? organizations;
    List<Website>? websites;
    List<SocialMedia>? socialMedias;
    List<Event>? events;
    List<Note>? notes;
    List<Group>? groups;


  ContactEntity({
       this.id,
       this.displayName,
       this.phones,
       this.photo,
       this.thumbnail,
       this.name,
       this.emails,
       this.addresses,
       this.organizations,
       this.websites,
       this.socialMedias,
       this.events,
       this.groups,
       this.notes
  });
  
  @override
  
  List<Object?> get props => [
id,
 displayName,
 phones,
 photo,
 thumbnail,
 name,
 emails,
 addresses,
 organizations,
 websites,
 socialMedias,
 events,
 groups,
  ];

  }