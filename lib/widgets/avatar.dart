import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarURL;
  final Function onTap;

  const Avatar({this.avatarURL , this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarURL == null ? CircleAvatar(
          radius: 50.0,
          child: Icon(Icons.photo_camera)
        ) : CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(avatarURL),
        )
        ,
      ),
    );
  }

}
