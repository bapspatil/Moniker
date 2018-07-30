import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Moniker',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(
    fontSize: 18.0,
    color: Color(0xFF212121),
    fontWeight: FontWeight.bold,
  );

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return Row(children: [
      Expanded(
          child: Text(
        pair.asPascalCase,
        style: _biggerFont,
      )),
      CupertinoButton(
          child: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : Colors.blueGrey,
          ),
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          }),
    ]);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      final tiles = _saved.map(
        (pair) {
          return Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ))
            ],
          );
        },
      );

      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Saved Names'),
          ),
          child: ListView(children: divided),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text('Moniker'),
          trailing: CupertinoButton(
            child: Icon(
              CupertinoIcons.collections,
              color: CupertinoColors.activeBlue,
              semanticLabel: 'Saved Names',
            ),
            onPressed: _pushSaved,
          )),
      child: _buildSuggestions(),
    ));
  }
}
