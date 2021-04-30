import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/services/auth_service.dart';
class Provider extends InheritedWidget{
  final AuthService auth ;
  Provider({Key key , Widget child , this.auth}) : super(key: key , child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
  static Provider of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);

}
