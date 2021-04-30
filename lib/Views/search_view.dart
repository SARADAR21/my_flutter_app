import 'package:flutter/material.dart';
import 'package:my_flutter_app/widgets/divider_with_text.dart';

class SearchView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for A trip"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: DividerWithText(tag: "Suggestions",),
            ),
         Expanded(
          child: ListView.builder(
             itemCount: 1,
             itemBuilder: (BuildContext context, int index) =>
                 buildPlaceCard(context, index),
           ),
         )
          ],
        ),
      ),
    );
  }
}



Widget buildPlaceCard(BuildContext context,int index){
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 8 ,right: 8),
      child: Card(
        child: InkWell(
          child: Row(
            children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text(
                           "Loctaion",
                           style: TextStyle(fontSize: 20),
                         ),
                       ],
                     ),
                     Row(
                       children: [
                         Text(
                           'budget',
                           style: TextStyle(fontSize: 20),

                         ),
                       ],
                     )
                   ],
                 ),
               ),
             ),
              Column(
                children: [
                  Placeholder(
                    fallbackHeight: 10,
                    fallbackWidth: 10,
                  ),
                ],
              ),

            ],
          ),
          onTap: (){

          },
        ),
      ),
    ),
  );
}
