import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import 'package:my_flutter_app/temp/user_controller.dart';
import 'package:my_flutter_app/temp/storage_repo.dart';

final  locater = GetIt.instance;

void setupServices(){
  locater.registerSingleton<AuthService>(AuthService());
  locater.registerSingleton<StorageRepo>(StorageRepo());
  locater.registerSingleton<UserController>(UserController());

}