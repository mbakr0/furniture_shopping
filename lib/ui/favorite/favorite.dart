
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:furniture_shopping/ui/components/PriceTag.dart';
import 'package:furniture_shopping/ui/components/ProductName.dart';
import 'package:provider/provider.dart';
import '../../theme/color_schemes.g.dart';
import '../components/ImageWidget.dart';
import '../components/bagContainer.dart';
class Favorite extends StatefulWidget{
  final ScrollController scrollController;
  final int selectedIndex;

  const Favorite({super.key, required this.scrollController, required this.selectedIndex});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Item> items = [];
  void _getItemList(){
    items = Item.getItems.where((element) => element.favorite == true).toList();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<Item>(
      builder: (context,item,child) {
        _getItemList();
        if(items.isNotEmpty) {
          return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ListSection(scrollController:widget.scrollController,selectedIndex:widget.selectedIndex,itemList:items),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,10),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: MainButton(text: "Add all to my cart", onPressed:(items.isEmpty)?null:(){
                    for (var element in items) {
                      Provider.of<CartModel>(context,listen: false).add(element);
                    }

                  })
                )
              )
            ],
          ),
        );
        } else
          {
            return const Center(child: Text("You Have No Favorites"));
          }

      }
    );
  }


}

class ListSection extends StatefulWidget {
  final ScrollController scrollController;
  final int selectedIndex;
  final List<Item> itemList;
  const ListSection({
    super.key,required this.scrollController, required this.selectedIndex, required this.itemList
  });

  @override
  State<ListSection> createState() => _ListSectionState();

}

class _ListSectionState extends State<ListSection> {
  List<Item> favorites = [];
  @override
  void setState(VoidCallback fn) {
    favorites = Item.getItems.where((element) => element.favorite == true).toList();
    super.setState(fn);
  }

  @override
  void initState() {
    favorites = widget.itemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            controller: (widget.selectedIndex == 1)?widget.scrollController:ScrollController(),
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context , index) {
              return _buildListViewItem(favorites[index], index);
            },
            separatorBuilder: (context,index){
              return const Divider(height:1,thickness: 1,color: secondary,);
            },
            itemCount: favorites.length)
    );
  }

  Widget _buildListViewItem(Item item, int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(path: item.imagePath),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductName(name: item.title),
                PriceTag(price: item.price)

              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  item.favorite = false;
                  setState(() {
                  });
                }, icon: const Icon(FontAwesomeIcons.circleXmark)),
                const BagContainer()
              ],
            ),
          )
        ],
      ),
    );
  }
}

