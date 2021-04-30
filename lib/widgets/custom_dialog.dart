import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class CustomDialog extends StatelessWidget {
  final String title,
      description,
      primaryButtonText,
      secondaryButtonText,
      primaryButtonRoute,
      secondaryButtonRoute;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.primaryButtonText,
    @required this.primaryButtonRoute,
    this.secondaryButtonText,
    this.secondaryButtonRoute
  });
  static const double padding = 20.0;
  final primaryColor = Colors.blue;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),

      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                  offset: const Offset(0.0,10.0)
              )
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24.0),

                AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 24.0),

                AutoSizeText(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 24.0),

                RaisedButton(
                  color:primaryColor ,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: AutoSizeText(
                    primaryButtonText,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(primaryButtonRoute);
                  },
                ),
                SizedBox(height: 24.0),

                ShowSecondaryButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

   ShowSecondaryButton(BuildContext context) {
    if(secondaryButtonText!=null && secondaryButtonRoute!=null)
    return FlatButton(
                child: AutoSizeText(
                  secondaryButtonText,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: primaryColor,
                    fontWeight: FontWeight.w400
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
                },
              );
    else
      return SizedBox(height: 24.0);
  }
}
