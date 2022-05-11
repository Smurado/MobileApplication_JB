import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Zergliederung {
  late String URL;
  late String channelTitle;
  late String channelLink;
  late String channelDescription;
  late String channelImageUrl;

  List<Item> itemList = [];

  static Future<Zergliederung> create(String call) async{

    //create object with default constructor
    var component = Zergliederung();
    component.URL = call;

    //parsing des RSS Feeds auf das Objekt channel.
    late RssFeed rss=RssFeed();
    var url = call;
    final response = await http.get(Uri.parse(url));
    final channel = RssFeed.parse(response.body);

    //befuellen des components mit dem geparsten RSS Feed
    component.channelTitle = channel.title.toString();
    component.channelLink = channel.link.toString();
    component.channelDescription = channel.description.toString();
    component.channelImageUrl = channel.image!.url.toString();

    //befuellen der Item list mit dem geparsten Elementen aus dem RSS Feed
    for(int i = 0; i < channel.items!.length; i++){
      Item trans = Item();
      trans.itemUrl = channel.items![i].enclosure!.url.toString();
      trans.itemDescription = channel.items![i].description.toString();
      trans.itemLink = channel.items![i].link.toString();
      trans.itemTitle = channel.items![i].title.toString();
      trans.itemPubDate = channel.items![i].pubDate.toString();

      component.itemList.add(trans);
    }
    return component;
  }
}

class Item {
  late String itemTitle;
  late String itemLink;
  late String itemDescription;
  late String itemUrl;
  late String itemPubDate;

  Item();
  }




