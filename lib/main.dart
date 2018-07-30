import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moniker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Moniker'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
