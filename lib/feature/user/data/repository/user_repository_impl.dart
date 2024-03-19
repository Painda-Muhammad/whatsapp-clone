

import 'package:whatsapp_clone_app/feature/user/data/data_source/remote/user_remote_datas_source.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/contact_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements Repository{
  final UserRemoteDataSource _remotDataSource;
  UserRepositoryImpl(this._remotDataSource);

  @override
    Future<void> createUser(UserEntity user) async => _remotDataSource.createUser(user);

  @override
  Future<String> currentUserUID()async => _remotDataSource.currentUserUID();

  @override
  Stream<List<UserEntity>> getAllUser() => _remotDataSource.getAllUser();

  @override
  Future<List<ContactEntity>> getDeviceNumber() async => _remotDataSource.getDeviceNumber();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) => _remotDataSource.getSingleUser(uid);

  @override
  Future<bool> isSignIn()async => _remotDataSource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode)async => _remotDataSource.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut()async => _remotDataSource.signOut();

  @override
  Future<void> updateUser(UserEntity user)async => _remotDataSource.updateUser(user);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async => _remotDataSource.verifyPhoneNumber(phoneNumber);
  
}