import 'dart:ffi';
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'parser.dart';
//import 'package:xml/xml.dart';

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
  BigInt _counter = BigInt.from(1);
  BigInt _input = BigInt.from(0);

  void _incrementCounter() {
    AudioPlayer audioPlayer = AudioPlayer();
    //audioPlayer.setUrl('https://www.smurado.de/KK/KKX6.mp3');
    audioPlayer.setUrl('https://www.smurado.de/Song.mp3');
    audioPlayer.resume();
    sleep(Duration(seconds: 3));
    audioPlayer.stop();

    Zergliederung test = Zergliederung(channelDescription: "sdf", channelImageUrl: "test", channelLink: "test", channelTitle: "test");
    Item neu = Item();
    test.itemlist.add(neu);


    setState(() {
      _counter += _input;
    });
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
            const Text(
              'Hallo Welt, bringt mich zu eurem Anführer',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_counter',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text)
                  {
                    _input = BigInt.parse(text);
                  },
                ),
              ],
            ),
            Image.network('https://tenor.com/view/guess-whos-back-shrug-gif-11192287.gif')


          ],
        ),
      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,

        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
