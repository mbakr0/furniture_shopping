


import 'package:flutter/cupertino.dart';

class Item extends ChangeNotifier{
  final String title;
  final String description;
  final String imagePath;
  final String modelPath;
  final double price;
  final String category;
  bool _favorite = false;
  static final Map<String,bool?> _categories = {
    "bed":null,
    "chair":null,
    "lamp":null,
    "sofa":null,
    "table":null
  };

  Item.forProvider({this.title = "", this.description = "", this.imagePath = "",this.modelPath = "", this.price = 0, this.category = ""});


  Item({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.modelPath,
    required this.price,
    required this.category,
});



   static List<Item> getItems = [
      // add Beds
      Item(title: "Black Bed", description:"furniture that is used as a place to sleep, rest, and relax" , imagePath: "assets/images/bed/bed_1.png",modelPath: "assets/3d_models/bed/bed_1.glb", price: 12 , category:"bed" ),
      Item(title: "Size 2 Bed", description:"furniture that is used as a place to sleep, rest, and relax" , imagePath: "assets/images/bed/bed_2.png",modelPath: "assets/3d_models/bed/bed_2.glb", price: 14 , category:"bed" ),
      Item(title: "King Size Bed", description:"furniture that is used as a place to sleep, rest, and relax" , imagePath: "assets/images/bed/bed_3.png",modelPath: "assets/3d_models/bed/bed_3.glb", price: 16 , category:"bed" ),
      //Add Chairs
      Item(title: "King Chair", description:"a seat, having four legs for support and a rests for the back the arms" , imagePath: "assets/images/chair/chair_1.png",modelPath: "assets/3d_models/chair/chair_1.glb", price: 20 , category:"chair" ),
      Item(title: "Blue Chair", description:"a seat, having four legs for support and a rests for the back the arms" , imagePath: "assets/images/chair/chair_2.png",modelPath: "assets/3d_models/chair/chair_2.glb", price: 18 , category:"chair" ),
      Item(title: "Wooden Chair", description:"a seat, having four legs for support and a rests for the back the arms" , imagePath: "assets/images/chair/chair_3.png",modelPath: "assets/3d_models/chair/chair_3.glb", price: 22 , category:"chair" ),
      Item(title: "Blue Game Chair", description:"a seat, having four legs for support and a rests for the back the arms" , imagePath: "assets/images/chair/chair_4.png",modelPath: "assets/3d_models/chair/chair_4.glb", price: 16 , category:"chair" ),
      Item(title: "Red Game Chair", description:"a seat, having four legs for support and a rests for the back the arms" , imagePath: "assets/images/chair/chair_5.png",modelPath: "assets/3d_models/chair/chair_5.glb", price: 23.5 , category:"chair" ),
      //Add Lamps
      Item(title: "Bed lamp", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/lamp/lamp_1.png",modelPath: "assets/3d_models/lamp/lamp_1.glb", price: 5.5 , category:"lamp" ),
      Item(title: "Desk lamp", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/lamp/lamp_2.png",modelPath: "assets/3d_models/lamp/lamp_2.glb", price: 8.5 , category:"lamp" ),
      Item(title: "Roof lamp", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/lamp/lamp_3.png",modelPath: "assets/3d_models/lamp/lamp_3.glb", price: 8 , category:"lamp" ),
      Item(title: "Wooden Bed lamp", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/lamp/lamp_4.png",modelPath: "assets/3d_models/lamp/lamp_4.glb", price: 4.4 , category:"lamp" ),
      //Add Sofas
      Item(title: "Size 2 White Sofa", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/sofa/sofa_1.png",modelPath: "assets/3d_models/sofa/sofa_1.glb", price: 8.6 , category:"sofa" ),
      Item(title: "Size 3 White Sofa", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/sofa/sofa_2.png",modelPath: "assets/3d_models/sofa/sofa_2.glb", price: 6 , category:"sofa" ),
      Item(title: "Size 2 Brown Sofa", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/sofa/sofa_3.png",modelPath: "assets/3d_models/sofa/sofa_3.glb", price: 7 , category:"sofa" ),
      Item(title: "Size 3 Brown Sofa", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/sofa/sofa_4.png",modelPath: "assets/3d_models/sofa/sofa_4.glb", price: 10  , category:"sofa" ),
      Item(title: "Size 3 Colorful Sofa", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/sofa/sofa_5.png",modelPath: "assets/3d_models/sofa/sofa_5.glb", price: 12.6 , category:"sofa" ),
      //Add Tables
      Item(title: "Small Rectangle Wooden Table", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_1.png",modelPath: "assets/3d_models/table/table_1.glb", price: 22 , category:"table" ),
      Item(title: "Small Round Wooden Table", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_2.png",modelPath: "assets/3d_models/table/table_2.glb", price: 23.5 , category:"table" ),
      Item(title: "Round Table with Metal Leg", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_3.png",modelPath: "assets/3d_models/table/table_3.glb", price: 18.5 , category:"table" ),
      Item(title: "Wooden Table with Wheels", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_4.png",modelPath: "assets/3d_models/table/table_4.glb", price: 26 , category:"table" ),
      Item(title: "Desk Table with Drawers", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_5.png",modelPath: "assets/3d_models/table/table_5.glb", price: 27 , category:"table" ),
      Item(title: "Wooden Table With Chairs", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_6.png",modelPath: "assets/3d_models/table/table_6.glb", price: 32.6 , category:"table" ),
      Item(title: "Medium Round Wooden Table", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_7.png",modelPath: "assets/3d_models/table/table_7.glb", price: 33.9 , category:"table" ),
      Item(title: "Antique table", description:"a device for giving light, one consisting of an electric bulb" , imagePath: "assets/images/table/table_8.png",modelPath: "assets/3d_models/table/table_8.glb", price: 48.0 , category:"table" ),
    ];


  setCategory(String category, bool isActive){

     if (_categories.containsKey(category)){
       _categories[category] = isActive;
       notifyListeners();
     }
  }

  getAllItems(){
    List<Item> items = [];
    List<Item> allItems = getItems;
     _categories.forEach((key, value) {
       if(value == true)
         {
           items.addAll(
             allItems.where((element) => element.category == key)
           );
         }
     });
     return ( items.isEmpty) ? allItems :items;
  }

  set favorite(bool value){
    _favorite = value;
    notifyListeners();
  }
  bool get favorite => _favorite;


}