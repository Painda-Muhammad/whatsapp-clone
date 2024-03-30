

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_clone_app/feature/app/constants/app_const.dart';
import 'package:whatsapp_clone_app/feature/app/constants/firebase_collection.dart';
import 'package:whatsapp_clone_app/feature/user/data/data_source/remote/user_remote_datas_source.dart';
import 'package:whatsapp_clone_app/feature/user/data/model/user_model.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/contact_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required this.firestore, required this.auth});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  String _verificationId = '';

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollection.users);
    final uid = await currentUserUID();
    final newUser = UserModel(
      uid: uid,
      name: user.name,
      email: user.email,
      isOnline: user.isOnline,
      phoneNumber: user.phoneNumber,
      status: user.status,
      profileUrl: user.profileUrl,
    ).toDocument();

    try {
      await userCollection.doc(uid).get().then((user) async {
        if (user.exists) {
          //  await userCollection.doc(uid).update(newUser);

          return;
        } else {
          await userCollection.doc(uid).set(newUser);
        }
      });
    } catch (e) {
      throw Exception('Error occured while creating the user');
    }
  }

  @override
  Future<String> currentUserUID() async {
    return auth.currentUser!.uid;
  }

  @override
  Stream<List<UserEntity>> getAllUser() {
    final allUsers = firestore.collection(FirebaseCollection.users);
    // final uid = currentUserUID();
    return allUsers.snapshots().map(
        (querySnapshot) =>
            querySnapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final singleUserCollection = firestore.collection(FirebaseCollection.users);

    return singleUserCollection
        .limit(1)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async {
    return auth.currentUser?.uid != null;
  }

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsPinCode);
      await auth.signInWithCredential(credential);
      
    } on FirebaseException catch (e) {
      // toast('Firebase Exception error = $e');
      if (e.code == 'invalid-verification-code') {
        toast('invalid verification code');
      } else if (e.code == 'quota-exceeded') {
        toast('sma quota-exceeded');
      }
    } catch (e) {
      toast('unknown source, please try again');
    }
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollection.users);

    Map<String, dynamic> userInfo = {};

    if (user.name != null || user.name!.isNotEmpty || user.name != '') {
      userInfo['name'] = user.name;
    }
    // if (user.phoneNumber!.isNotEmpty || user.phoneNumber != '') {
    //   userInfo['phoneNumber'] = user.phoneNumber;
    // }
    if (user.profileUrl!.isNotEmpty || user.profileUrl != null) {
      userInfo['profileUrl'] = user.profileUrl;
    }
    if (user.isOnline != null) userInfo['isOnline'] = user.isOnline;
    if (user.status!.isNotEmpty || user.status != null) {
      userInfo['status'] = user.status;
    }

     userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    verificationCompleted(AuthCredential authCredential) {
      if (kDebugMode) {
        print(
          'phone verified ${authCredential.token}  and ${authCredential.signInMethod}');
      }
    }

    verificationFailed(FirebaseException firebaseException) {
      if (kDebugMode) {
        print(
          'phone failed ${firebaseException.message} and ${firebaseException.code}');
      }
    }

    codeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      if (kDebugMode) {
        print('timeout is $_verificationId');
      }
    }

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60));
  }

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    List<ContactEntity> contactsList = [];


    if(await FlutterContacts.requestPermission()){
     List<Contact> contacts = await FlutterContacts.getContacts(
        withPhoto: true,
        withProperties: true,
      );

      for(var contact in contacts){
        contactsList.add(ContactEntity(
          name: contact.name,
          phones: contact.phones,
          photo: contact.photo,
        ));
      }
    }

    return contactsList;
  }
}
