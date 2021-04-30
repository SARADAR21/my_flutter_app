import'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final tag;
  const DividerWithText({
    Key key,@required this.tag
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(tag==null)
      return Divider();
    else
      return Row(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child:  Divider(),
          )),
          Text(
            tag,
            style: TextStyle(fontSize: 15),
          ),
          Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Divider()
          ))
        ],
      );
  }
}