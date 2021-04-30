import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modules/Trip.dart';
import '../trip_info_widget.dart';
import 'package:my_flutter_app/widgets/provider_widget.dart';
import 'package:snapshot/snapshot.dart';
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
 /* static final  List<Trip> tripsList = [
    Trip("Dams", DateTime.now(), DateTime.now(), 7000, "Bus"),
    Trip("Damascus", DateTime.now(), DateTime.now(), 7000, "Bus"),
    Trip("Damascus", DateTime.now(), DateTime.now(), 7000, "Bus")
  ];*/


  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
          stream:getUerTripsStreamSnapshots(context) ,
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return const Text('Loading..');
            else
            return new ListView.builder(
                itemCount:  snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.docs[index]));
          }
        )
    );
  }

  Stream<QuerySnapshot>getUerTripsStreamSnapshots(BuildContext context)async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('trips').snapshots();
    
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(trip['title'], style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['starttime'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endtime'].toDate()).toString()}"),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("\$${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




