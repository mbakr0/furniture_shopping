


import 'package:flutter/material.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/color_schemes.g.dart';

class CountController extends StatefulWidget {
  final int itemCount;
  final Item? item;
  CountController({super.key,this.itemCount = 1,this.item});

   final _countController = _CountControllerState();

  @override
  State<CountController> createState() => _countController;

  getCounter(){
    return _countController.counter;
  }
}

class _CountControllerState extends State<CountController> {

  int counter = 0;


  @override
  void initState() {
    counter = widget.itemCount;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context,cart,child) {
        return Row(
          children: [
            _CounterContainer(icon: Icons.add,onTap:(){
              if(widget.item != null) {
                cart.add(widget.item!);
              }
              counter++;
              setState(() {

              });
            }),
            const SizedBox(width: 15,),
            Text((counter > 9)?counter.toString():"0$counter",style: GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.w600),),
            const SizedBox(width: 15,),
            _CounterContainer(icon: Icons.remove,onTap: (){
              if(counter > 1) {
                if(widget.item != null){
                  cart.remove(widget.item!);
                }
                counter--;
                setState(() {

                });
              }
            })
          ],
        );
      }
    );
  }
}

class _CounterContainer extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const _CounterContainer({
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color:secondary,
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
          onTap:onTap,
          borderRadius: BorderRadius.circular(10),
          child: Icon(icon,size: 18))
    );
  }
}