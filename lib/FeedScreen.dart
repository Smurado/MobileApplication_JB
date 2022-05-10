import 'package:flutter/material.dart';
import 'parser.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen( {Key? key, required this.streamer}) : super(key: key);

  Zergliederung streamer;
  String currentTitle = "";
  //AudioPlayer audioPlayer = AudioPlayer();


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
  AudioPlayer audioPlayer = AudioPlayer();
  bool isplaying = false;

  void audio(String URL) {
    audioPlayer.stop();
    audioPlayer.setUrl(URL);
    audioPlayer.resume();
  }

  IconButton audioButton(){
    if(!isplaying){
      return IconButton(icon: Icon(Icons.play_arrow), onPressed: () {
        audioPlayer.resume();
        setState((){isplaying = !isplaying;});
        },
      );
    }
    else {
      return IconButton(icon: Icon(Icons.pause), onPressed: () {
        audioPlayer.pause();
        setState(() {isplaying = !isplaying;});
      },
      );
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
                        widget.currentTitle = widget.streamer!.itemList![index].itemTitle;
                        setState(() {isplaying = true;});
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
                Expanded(child:
                Container(
                  padding: EdgeInsets.only(right: 13.0),
                  child: Text(
                  widget.currentTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  ),
                ),
                ),
            Spacer(),
            audioButton(),
          ],
        ),
      ),
    );
  }
}
