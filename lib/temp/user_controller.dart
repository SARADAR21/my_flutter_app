import 'package:flutter/material.dart';
import 'package:my_flutter_app/modules/User.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import 'package:my_flutter_app/temp/locater.dart';
import 'package:my_flutter_app/temp/storage_repo.dart';
import 'dart:io';

class UserController{
  UserModule _currentUser;
  AuthService _authService =  locater.get<AuthService>();
  Future init;
  StorageRepo _storageRepo = locater.get<StorageRepo>();

  UserController(){
    init = initUser();
  }
 Future<UserModule> initUser() async {
    _currentUser = await _authService.getUser();
    return _currentUser;
  }
  UserModule get currentUser =>_currentUser;

  Future<void> uploadProfilePicture(File image) async{
    _currentUser.avatarURl = await _storageRepo.uploadFile(image);
  }

  Future<String>getDownloadUrl() async{
    await _storageRepo .getUserProfileImageDownloadUrl(_currentUser.uid);
  }

   Future<void>signInWithEmailAndPassword (String email ,String password) async{
    _currentUser =await _authService.signInWithEmailAndPassword(email, password);
    _currentUser.avatarURl = await getDownloadUrl();
  }
}