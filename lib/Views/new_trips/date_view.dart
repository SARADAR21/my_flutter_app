import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Views/new_trips/budget_view.dart';
import 'package:my_flutter_app/modules/Trip.dart';
import'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';




class NewTripDateView extends StatefulWidget{
  final Trip trip;
  NewTripDateView({Key key,@required this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  DateTime _startDate = DateTime.now() ;
  DateTime _endDate = DateTime.now().add(Duration(days:7)) ;

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year-50),
        lastDate: new DateTime(DateTime.now().year+50)
    );
    if(picked != null && picked.length == 2){
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }
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
              Text("location ${widget.trip.title}"),
              RaisedButton(
                  onPressed: () async { await displayDateRangePicker(context);},
                  child: Text("Pick Date"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Text(" Trip's StartDate ${DateFormat("dd/MM/yyyy").format(_startDate).toString()} :"),
                  Text(" Trip's EndDate ${DateFormat("dd/MM/yyyy").format(_endDate).toString()}:"),
                ],
              ),
              RaisedButton(
                child: Text("Continue"),
                onPressed: (){
                  widget.trip.startTime = _startDate;
                  widget.trip.endTime = _endDate;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewTripBudgetView(trip: widget.trip))
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