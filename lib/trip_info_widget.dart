import 'package:flutter/material.dart';
import 'modules/Trip.dart';

class TripView extends StatelessWidget {
  Trip currentTrip;
  TripView(this.currentTrip);

  createAlertDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {

        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("All The Info"),
      content: Column(
        children: [
          Row(children: <Widget>[
            Text(currentTrip.title),
            Spacer(),
          ]),
        ],
      ),
    );
  }
}
