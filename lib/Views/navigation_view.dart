import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/modules/Trip.dart';
import '../pages.dart';
import 'home_view.dart';
import 'new_trips/location_view.dart';
import '../widgets/provider_widget.dart';
import '../services/auth_service.dart';
import 'search_view.dart';
import 'profile_view.dart';


class Home extends StatefulWidget{
  State<StatefulWidget> createState(){
    return HomeState();

  }
}
class HomeState extends State<Home>{
  int _currentIndex=1;
  final List<Widget>_children=[ExplorePage(),HomeView(),PastTripsPage()];
  @override
  Widget build(BuildContext context) {
    final newtrip = new Trip(null, null, null, null, null);
   return Scaffold(
     appBar: AppBar(
       title: Text("Travel Budget App"),

       actions: [
         IconButton(
           icon: Icon(Icons.add),
           onPressed: (){
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => NewTripLocationView(trip: newtrip))
             );
           },
         ),
         IconButton(
           icon: Icon(Icons.logout),
           onPressed: () async {
             try{
               AuthService auth = Provider.of(context).auth;
               auth.signOut();
             }
             catch (e){
             print(e);
             }
           },
         ),

         IconButton(
           icon: Icon(Icons.account_circle),
           onPressed: (){
            Navigator.of(context).pushNamed("/profileView");
           },
         ),
         
         IconButton(
           icon: Icon(Icons.search),
           onPressed: (){
             Navigator.push(
               context,
               MaterialPageRoute(builder:(context) =>SearchView())
             );
           },
         ),
       ],
     ),

     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex,
       items: [

         BottomNavigationBarItem(
             icon: new Icon(Icons.explore),
             title:new Text("Explore")
         ),
         BottomNavigationBarItem(
             icon: new Icon(Icons.home),
             title:new Text("Home")
         ),
         BottomNavigationBarItem(
             icon: new Icon(Icons.history),
             title:new Text("Past Trips"),

         )
       ],
     ),
   );
  }
  void onTabTapped(int index){
  setState((){
    _currentIndex=index;
  });
  }
}