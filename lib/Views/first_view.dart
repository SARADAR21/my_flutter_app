import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_flutter_app/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final primaryColor = Colors.blue;

    return Scaffold(
      body: Container(
        color: primaryColor,
        width: _width,
        height: _height,
          child: Column(
          children: [
            SizedBox(height: _height*0.1),
            Text(
                "Welcome",
              style: TextStyle(fontSize: 44 , color: Colors.white),
            ),
            SizedBox(height: _height*0.15),
            AutoSizeText(
                "Lets make ur life easier ...",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            SizedBox(height: _height*0.1),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child:Padding(
                padding: const EdgeInsets.only(top:15,bottom: 15,left: 30,right: 30),
                child: Text("Get Started",style: TextStyle(color:primaryColor,fontSize: 20),),
              ),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                  title:"Would you like to create a free account ?" ,
                    description:"pla pla pla" ,
                    primaryButtonText: "Create an account ",
                    primaryButtonRoute: "/signUp",
                    secondaryButtonText: "Maybe Later",
                    secondaryButtonRoute: "/anonymousSignIn",
                  )
                );
              },
            ),
            SizedBox(height: _height*0.1),
            FlatButton(
              child: Text("Sign in", style: TextStyle(color: Colors.white,fontSize: 20),),
              onPressed: (){
                Navigator.of(context).pushNamed('/signIn');
              },

            )
          ],
      ),
      ),
    );
  }
  
}