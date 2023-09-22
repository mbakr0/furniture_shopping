


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/util/makeNotification.dart';
import 'package:furniture_shopping/model/User.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/order.dart';
import 'package:furniture_shopping/model/orderNotification.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:furniture_shopping/ui/home/cart/success.dart';
import 'package:furniture_shopping/ui/profile/addressList/addressList.dart';
import 'package:furniture_shopping/ui/profile/paymentsList/paymentList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../theme/color_schemes.g.dart';
class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
   CustomNotification.initializeNotification(flutterLocalNotificationsPlugin);
   CartModel cartModel = Provider.of<CartModel>(context,listen: false);
    return Scaffold(

      appBar: customAppBar("Check out"),
      body: Padding(
        padding:const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: const Text("Shipping Address"),
              titleTextStyle: GoogleFonts.nunitoSans(fontSize:18,fontWeight: FontWeight.w600,color: dateColor),
              trailing: IconButton(onPressed: (){
                _navigateToAddressList();
              },icon: const Icon(Icons.edit_rounded),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Consumer<UserModel>(
                builder: (context,user,child) {
                  return ListTile(
                    title: Text(user.name??""),
                    titleTextStyle: GoogleFonts.nunitoSans(fontSize:18,fontWeight: FontWeight.bold,color: onSurface),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        const Divider(height: 4,thickness: 2,color: secondary,),
                        const SizedBox(height: 4),
                        Text("${_getAddressInfo(user)}",
                          style: GoogleFonts.nunitoSans(fontSize:14,fontWeight: FontWeight.normal,color: onSecondary))
                      ],
                    ),
                  );
                }
              ),
            ),
            const SizedBox(height: 100),
            ListTile(
              title: const Text("Payment"),
              titleTextStyle: GoogleFonts.nunitoSans(fontSize:18,fontWeight: FontWeight.w600,color: dateColor),
              trailing:  IconButton(onPressed: (){
                _navigateToPayment();
              }, icon: const Icon(Icons.edit_rounded)),
            ),
            Card(
              color: Colors.white,
              elevation: 0.5,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.ccVisa,color: Colors.blue,size: 24,),
                    const SizedBox(width: 10,),
                    Consumer<UserModel>(
                      builder: (context,user,child) {
                        return Text(_getCardInfo(user),style: GoogleFonts.nunitoSans(fontSize: 16,fontWeight: FontWeight.w600,color: onPrimary),);
                      }
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0.5,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order: ",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 18,color: onSecondary),),
                          Text("\$ ${double.parse(cartModel.totalPrice)}",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600,fontSize: 18,color: onSurface)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery: ",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 18,color: onSecondary),),
                          Text("\$ 5.00",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600,fontSize: 18,color: onSurface)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 18,color: onSecondary),),
                          Text("\$ ${double.parse(cartModel.totalPrice) + 5 }",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 18,color: onSurface)),
                        ],
                      ),
                      const SizedBox(height: 60,),
                      SizedBox(
                          width: double.infinity,
                          height: 60,
                          child : Consumer<UserModel>(
                            builder: (context,user,child) {
                              return MainButton(text: "SUBMIT ORDER", onPressed: _validate(context,user)?(){
                                final order  = OrderInfo(quantity: cartModel.items.length, totalAmount: double.parse(cartModel.totalPrice));
                                globalDatabaseDao?.insertOrder(order).then((value) =>
                                {
                                  globalDatabaseDao?.insertOrderNotification(OrderNotification(orderNumber: value, date: order.timeCreated, imagePath: cartModel.items.first.imagePath, title:cartModel.items.first.title )),
                                  CustomNotification.showNotification(cartModel.items.first.title,cartModel.items.first.description,flutterLocalNotificationsPlugin)

                                }).then((value) =>
                                {
                                Provider.of<CartModel>(context,listen: false).clearCart()
                                }
                                );

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>const Success())
                                );
                              }:null);
                            }
                          )
                      )

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> _navigateToPayment() async {
    await Navigator.push(context,MaterialPageRoute(builder: (context)=> const PaymentList()));
    if (!context.mounted) return;
    setState(() {
    });
  }

  Future<void> _navigateToAddressList() async {
    await Navigator.push(context,MaterialPageRoute(builder: (context)=> const AddressList()));
    if (!context.mounted) return;
    setState(() {
    });
  }

  _validate(BuildContext context, UserModel user) {
    if(user.cardInfo == null || user.address == null )
      {
        return false;
      } else {
      return true;
    }

  }

  String _getCardInfo(UserModel user) {
     if(user.cardInfo != null)
       {
         if(user.cardInfo?.cardNumber.toString().length == 16)
           {

             return "****  ****  ****  ${user.cardInfo?.cardNumber.toString().substring(12)}";
           }
       }
       return "Edit Card Info";

  }

  _getAddressInfo(UserModel user) {
    if(user.address != null)
      {
        return "${user.address?.addressLine}, ${user.address?.district} \n ${user.address?.city}, ${user.address?.country}";

      }
    else
      {
        return "Edit Address Info";
      }
  }
}