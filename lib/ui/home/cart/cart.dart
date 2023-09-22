
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/ui/components/CountController.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/ImageWidget.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:furniture_shopping/ui/home/cart/checkout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/PriceTag.dart';
import 'package:furniture_shopping/ui/components/ProductName.dart' show ProductName;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
        builder: (context,cart,child) {
          final String totalPrice = cart.totalPrice;

          final Set<Item> items = cart.items.toSet();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("My cart"),
          body: Column(
            children: [
              Expanded(child: ListView.separated(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context , index) {
                    return _cartListViewItem(items.elementAt(index),cart);
                  },
                  separatorBuilder:  (context,index){
                    return const Divider(height:1,thickness: 1,color: secondary,);
                  },
                  itemCount: items.length)),
              Padding(padding: const EdgeInsets.only(left: 60, right: 60,bottom: 30),child: _total(totalPrice),),
              Padding(
                  padding: const EdgeInsets.fromLTRB(50,0,50,10),
                  child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: MainButton(text: "Check out", onPressed: (){
                        if(double.parse(totalPrice) != 0){

                          final pageRoute = MaterialPageRoute(builder: (context)=> CheckOut());

                          Navigator.push(context, pageRoute);
                        }
                      })
                  )
              )
            ]
            ,
          ),
        );
      }
    );
  }

  _cartListViewItem( Item item, CartModel cartModel){
    final itemCount = cartModel.items.where((element) => item.title == element.title ).length;
    final countController = CountController(itemCount: itemCount,item: item);
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
                  PriceTag(price: item.price),
                  const SizedBox(height: 30),
                  countController,
                ],
              )
          ),
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  cartModel.removeAll(item);
                  setState(() {
                  });
                }, icon: const Icon(FontAwesomeIcons.circleXmark))
              ],
            ),
          )
        ],
      ),
    );
  }

  _total(String totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total:",style: GoogleFonts.nunitoSans(fontSize: 20,fontWeight: FontWeight.bold,color: onSecondary)),
        Text("\$ $totalPrice",style: GoogleFonts.nunitoSans(fontSize: 20,fontWeight: FontWeight.bold,color: onSurface))
      ],
    );
  }
}
