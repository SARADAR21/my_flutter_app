import 'package:flutter/material.dart';
import 'package:my_flutter_app/Views/new_trips/date_view.dart';
import 'package:my_flutter_app/modules/Trip.dart';


class NewTripLocationView extends StatelessWidget{
  final Trip trip;
  NewTripLocationView({Key key,@required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController= TextEditingController();
    _titleController.text = trip.title;
   return Scaffold(
     appBar: AppBar(
       title: Text("Create a New Trip"),
     ),
     body: Container(
       child: Center(
         child: Column(

           children: <Widget>[
             Text("Enter Your Trip's Destination:"),
             Padding(
               padding: const EdgeInsets.all(30.0),
               child: TextField(
                 controller: _titleController ,
                 autofocus: true,
               ),
             ),

             RaisedButton(
               child: Text("Continue"),
               onPressed: (){
                  trip.title = _titleController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTripDateView(trip: trip))
                  );
               },
             )
           ],
         ),
       ),
     ),
   );
  }

}