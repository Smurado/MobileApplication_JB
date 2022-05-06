import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
//import 'package:xml/xml.dart';
import 'package:webfeed/webfeed.dart';



class Zergliederung {
  late String URL;
  late String channelTitle;
  late String channelLink;
  late String channelDescription;
  late String channelImageUrl;

  List<Item> itemList = [];

  //Zergliederung._create(){}

  static Future<Zergliederung> create(String call) async{

    var component = Zergliederung(); //create object with default constructor
    component.URL = call;

    late RssFeed rss=RssFeed();
    var url = call;
    final response = await http.get(Uri.parse(url));
    final channel = RssFeed.parse(response.body);

    component.channelTitle = channel.title.toString();
    component.channelLink = channel.link.toString();
    component.channelDescription = channel.description.toString();
    component.channelImageUrl = channel.image!.url.toString();

    //List<Item>copy = [];

    for(int i = 0; i < channel.items!.length; i++){
      Item trans = Item();
      trans.itemUrl = channel.items![i].enclosure!.url.toString();
      trans.itemDescription = channel.items![i].description.toString();
      trans.itemLink = channel.items![i].link.toString();
      trans.itemTitle = channel.items![i].title.toString();
      trans.itemPubDate = channel.items![i].pubDate.toString();

      component.itemList.add(trans);
    }
    //component.itemList = copy;

    log(component.itemList[3].itemUrl.toString());
    log(component.itemList[3].itemPubDate.toString());
    return component;
  }
  /*
  /Zergliederung(
    this.channelTitle,
    this.channelLink,
    this.channelDescription,
    this.channelImageUrl) {

    itemlist = getItem();
  }


    Future <List<Item>> getItem() async{

    late RssFeed rss=RssFeed();
    const url = 'https://smurado.de/feed.xml';
    final response = await http.get(Uri.parse(url));
    final channel = RssFeed.parse(response.body);

    log(channel.items![0].enclosure!.url.toString());
    Future List<Item> parsing =[];


      return parsing;




    //RssFeed.parse(response.body);


  }*/
}

class Item {
  late String itemTitle;
  late String itemLink;
  late String itemDescription;
  late String itemUrl;
  late String itemPubDate;

  Item();
  }




