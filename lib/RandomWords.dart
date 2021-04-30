import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';




class RandomWordsState extends State<RandomWords>{
  final List<WordPair>_suggestions= <WordPair>[];
  final Set<WordPair>_saved=Set<WordPair>();



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: _buildSuggestions(),
    );
  }

  @override
  Widget _buildSuggestions()
  { return ListView.builder(
      itemBuilder: (BuildContext _context,int i){
        if(i.isOdd)
          return Divider();
        final index=i~/2;
        if(index>=_suggestions.length)
          _suggestions.addAll(generateWordPairs().take(10));


        return _buildrow(_suggestions[index]);
      }

  );

  }
  Widget _buildrow(WordPair wordPair){
    final bool alreadySaved=_saved.contains(wordPair);
    return ListTile(
      title: Text(
          wordPair.asPascalCase
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite: Icons.favorite_border,
        color: alreadySaved ? Colors.red :null,

      ),
      onTap: (){
        if(alreadySaved)
          _saved.remove(wordPair);


        else
          _saved.add(wordPair);

      },
    );
  }






}

class RandomWords extends StatefulWidget{

  RandomWordsState createState() =>RandomWordsState();

}