import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import 'package:my_flutter_app/temp/locater.dart';
class StorageRepo{
  FirebaseStorage storage =FirebaseStorage.instanceFor(bucket: "gs://travel-budget-21.appspot.com") ;

  AuthService _authService = locater.get<AuthService>();

  Future<String> uploadFile(File file ) async {
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("user/profile/${userId}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String>getUserProfileImageDownloadUrl(String uid) async{
    var storageRef = storage.ref().child('user/profile/$uid');
    return await storageRef.getDownloadURL();
  }

}