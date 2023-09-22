
import 'package:flutter/material.dart';
import 'package:furniture_shopping/model/User.dart';
import 'package:furniture_shopping/ui/profile/myOrders/myOrders.dart';
import 'package:furniture_shopping/ui/profile/myReview/myReview.dart';
import 'package:furniture_shopping/ui/profile/paymentsList/paymentList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../theme/color_schemes.g.dart';
import 'addressList/addressList.dart';

class Profile extends StatelessWidget {
   Profile({super.key});
  final titleStyle = GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.bold,color: onSurface);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Row(
              children: [
                CircleAvatar(
                  radius: 52,
                  child: CircleAvatar(
                   radius: 50,backgroundColor: tertiaryContainer,
                    child: Text((user.name == null)?"N":user.name![0].toUpperCase(),style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w900,fontSize: 50),),
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name??"My Name",style: GoogleFonts.nunitoSans(fontSize: 20,fontWeight: FontWeight.bold,color: onSurface),),
                    Text(user.email??"My Email",style:GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.normal,color: onSecondary))
                  ],
                )
              ],
            ),
            const SizedBox(height: 80,),
            ListTile(
              onTap: (){
                Navigator.push(context,
                    PageTransition(type:PageTransitionType.rightToLeftWithFade,child:const MyOrders())
                );
              },
              title: Text("My orders",style: titleStyle,),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
             ListTile(
               onTap: (){
                 Navigator.push(context,
                     PageTransition(type:PageTransitionType.rightToLeftWithFade,child:const AddressList())
                 );
               },
              title: Text("Shipping Addresses",style: titleStyle),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
             ListTile(
               onTap: (){
                 Navigator.push(context,
                     PageTransition(type:PageTransitionType.rightToLeftWithFade,child:const PaymentList())
                 );
               },
              title: Text("Payment Method",style: titleStyle),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
             ListTile(
               onTap: (){
                 Navigator.push(context,
                     PageTransition(type:PageTransitionType.rightToLeftWithFade,child:const MyReviews())
                 );
               },
              title: Text("My reviews",style: titleStyle),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

}