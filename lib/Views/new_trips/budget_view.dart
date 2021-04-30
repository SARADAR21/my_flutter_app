import 'package:flutter/material.dart';
import 'package:my_flutter_app/modules/Trip.dart';
import'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/widgets/provider_widget.dart';
import 'package:my_flutter_app/services/auth_service.dart';

class NewTripBudgetView extends StatelessWidget{
  final Trip trip;
  final db =FirebaseFirestore.instance ;
  NewTripBudgetView({Key key,@required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create a New Trip"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("location : ${trip.title}"),
              Text("StartDate : ${trip.startTime}"),
              Text("EndDate : ${trip.endTime}"),

              Text("Finished :"),

              RaisedButton(
                child: Text("Continue"),
                onPressed: () async{
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  await db.collection("userData").doc(uid).collection("trips").add(trip.toJson());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}