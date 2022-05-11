import 'dart:io';
import 'package:erneuerung/FeedScreen.dart';
import 'package:erneuerung/StorageManager.dart';
import 'package:flutter/material.dart';
import 'parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: const MyHomePage(title: 'Mediathek'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
    final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final streamUrlController = TextEditingController();
  Zergliederung stream = Zergliederung();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              //Textfield for the Input of the Link URL
              child: TextField(
                //controller for the text to receive it later in the code
                controller: streamUrlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              width: 300,
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          //add button for adding a feed
          FloatingActionButton(
            onPressed: () async {
              setState(() {StorageManager.saveData("Zergliederung", stream);});
              var a = await Zergliederung.create("https://cdn.julephosting.de/podcasts/126-gamestar-podcast/feed.rss");
              //hier das create aendern auf den Controller
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedScreen(streamer: a))
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
