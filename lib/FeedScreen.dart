//import 'dart:html';

import 'dart:developer';

import 'package:erneuerung/StorageManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'parser.dart';
import 'dart:io';
import 'package:erneuerung/FeedScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen( {Key? key, required this.streamer}) : super(key: key);

  Zergliederung streamer;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class _FeedScreenState extends State<FeedScreen> {

  String imageUrl = 'https://media.giphy.com/media/l3diT8stVH9qImalO/giphy.gif';


  void audio(String URL) {
    widget.audioPlayer.pause();
    widget.audioPlayer.setUrl(URL);
    widget.audioPlayer.resume();
    //widget.audioPlayer.stop();
  }

  void audiobutton(){
    if(widget.audioPlayer.state.toString() == "PlayerState.STOPPED"){

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            flexibleSpace:
            SingleChildScrollView(padding: EdgeInsets.all(32),
              child : Column(
                children: <Widget>[
                  Image.network(widget.streamer.channelImageUrl)
                ],
            ),
           ),
            expandedHeight: 350,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                      onTap: () {
                        audio(widget.streamer!.itemList![index].itemUrl);
                        },
                      title: Text(widget.streamer!.itemList![index].itemTitle)),

                childCount: widget.streamer.itemList.length,
              ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            Text("",textAlign: TextAlign.center),
            Spacer(),
            IconButton(icon: Icon(Icons.play_arrow), onPressed: () {log(widget.audioPlayer.state.toString());}),
          ],
        ),
      ),
    );
  }
}
