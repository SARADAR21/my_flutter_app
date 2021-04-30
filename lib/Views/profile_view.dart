import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/modules/User.dart';
import 'package:my_flutter_app/temp/user_controller.dart';
import 'package:my_flutter_app/widgets/divider_with_text.dart';
import '../widgets/provider_widget.dart';
import '../services/auth_service.dart';
import'package:auto_size_text/auto_size_text.dart';
import 'package:my_flutter_app/modules/User.dart';
import 'package:my_flutter_app/widgets/avatar.dart';
import 'package:my_flutter_app/temp/locater.dart';
import 'package:my_flutter_app/temp/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModule currentUser = locater
      .get<UserController>()
      .currentUser;

  PickedFile image  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          DividerWithText(tag: "ProfilePhoto"),
          Avatar(
            avatarURL: currentUser ?.avatarURl ,
            onTap: () async {
               image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

              await locater.get<UserController>().uploadProfilePicture(File(image.path));
            },
          ),
          DividerWithText(tag: "UserName"),
          AutoSizeText(
            "${currentUser.userName ?? "NICE TO SEE U "}",
            maxLines: 1,
            style: TextStyle(fontSize: 18),
          ),




        ],
      ),
    );
  }

 
}


