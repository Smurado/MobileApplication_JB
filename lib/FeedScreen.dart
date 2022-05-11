import 'package:flutter/material.dart';
import 'parser.dart';
import 'package:audioplayers/audioplayers.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen( {Key? key, required this.streamer}) : super(key: key);

  Zergliederung streamer;
  String currentTitle = "";

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isplaying = false;

  //function for the initial press in the list of Streamitems
  void audio(String URL) {
    audioPlayer.stop();
    audioPlayer.setUrl(URL);
    audioPlayer.resume();
  }

  //function for the Button in the lower AppBar
  IconButton audioButton(){
    //check if the player is playing and resum if it is not
    if(!isplaying){
      return IconButton(icon: Icon(Icons.play_arrow), onPressed: () {
        //resume audioplayer
        audioPlayer.resume();
        //setstate to refresh the new icon
        setState((){isplaying = !isplaying;});
        },
      );
    }
    else {
      return IconButton(icon: Icon(Icons.pause), onPressed: () {
        //pause audioplayer
        audioPlayer.pause();
        //setstate to refresh the new icon
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
            expandedHeight: 350, //height for the image background of the streamimage
          ),
          SliverList( //list for the itemlist
              delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                      onTap: () {
                        //call audio if pressing on a list item
                        audio(widget.streamer.itemList[index].itemUrl);
                        widget.currentTitle = widget.streamer.itemList[index].itemTitle;
                        //setState and turn isplaying true
                        setState(() {isplaying = true;});
                        },
                      title: Text(widget.streamer.itemList[index].itemTitle)),

                childCount: widget.streamer.itemList.length,
              ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar( //bottom bar with pause and unpause
        child: Row(
          children: [
            Spacer(),
                Expanded(child: //text for the
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
            audioButton(), //button based on streame type
          ],
        ),
      ),
    );
  }
}
