
import 'package:whatsapp_clone_app/feature/user/domain/entity/contact_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/user_entity.dart';

abstract class UserRemoteDataSource {
Future<void> verifyPhoneNumber(String phoneNumber);
Future<void> signInWithPhoneNumber(String smsPinCode);

Future<bool> isSignIn();
Future<void> signOut();
Future<String> currentUserUID();
Future<void> createUser(UserEntity user);
Future<void> updateUser(UserEntity user);

Stream<List<UserEntity>> getAllUser();
Stream<List<UserEntity>> getSingleUser(String uid);
Future<List<ContactEntity>> getDeviceNumber();
}