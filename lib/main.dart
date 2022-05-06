import 'dart:developer';
import 'dart:ffi';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';

import 'package:erneuerung/FeedScreen.dart';
import 'package:erneuerung/StorageManager.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/services.dart';
import 'parser.dart';
import 'package:xml/xml.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
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
  String imageUrl = 'https://media.giphy.com/media/l3diT8stVH9qImalO/giphy.gif';
  final streamUrlController = TextEditingController();
  Zergliederung stream = Zergliederung();



  void _addFeed() async{

    //z = await Zergliederung.create('https://cdn.julephosting.de/podcasts/126-gamestar-podcast/feed.rss');
    stream = await Zergliederung.create('https://cdn.julephosting.de/podcasts/126-gamestar-podcast/feed.rss');
    imageUrl = stream.channelImageUrl;
    AudioPlayer audioPlayer = AudioPlayer();
    //audioPlayer.setUrl('https://www.smurado.de/KK/KKX6.mp3');
    //audioPlayer.setUrl('https://www.smurado.de/Song.mp3');
    //audioPlayer.setVolume(1);
    audioPlayer.setUrl(stream.itemList[3].itemUrl);

    audioPlayer.resume();
    sleep(Duration(seconds: 15));
    audioPlayer.stop();

  }

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

              child: TextField(
                controller: streamUrlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),

              ),

              width: 300,
            ),
            //Text("https://cdn.julephosting.de/podcasts/126-gamestar-podcast/feed.rss"),

            //Image.network('https://media.giphy.com/media/l3diT8stVH9qImalO/giphy.gif')
            //Image.network('$imageUrl')

          ],
        ),
      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,

        children: [
          FloatingActionButton(
            //onPressed: _addFeed,
            onPressed: () async {
              //String q = streamUrlController.text;
              setState(() {
                //StorageManager.saveData("url", streamUrlController.text);
                StorageManager.saveData("Zergliederung", stream);
              });
              var a = await Zergliederung.create("https://cdn.julephosting.de/podcasts/126-gamestar-podcast/feed.rss");
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedScreen(streamer: a,))
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
