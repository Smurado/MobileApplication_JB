class Zergliederung {
  late String channelTitle;
  late String channelLink;
  late String channelDescription;
  late String channelImageUrl;

  List<Item> itemlist = [];

  Zergliederung({
    required this.channelTitle,
    required this.channelLink,
    required this.channelDescription,
    required this.channelImageUrl});

}



class Item{
  late String itemTitle;
  late String itemLink;
  late String itemDescription;
  late String itemUrl;
  late String itemPubDate;
}


