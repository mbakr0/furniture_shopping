

import 'package:flutter/material.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/color_schemes.g.dart';

class CreditCard extends StatelessWidget {
  final CardInfoModel cardInfoModel;
  const CreditCard({super.key,required this.cardInfoModel});

  @override
  Widget build(BuildContext context) {
    final creditCardNumber = cardInfoModel.cardNumber.toString();
    var numberBuffer = StringBuffer();
    if(cardInfoModel.cardNumber != null){
      for(int i = 0; i < creditCardNumber.length; i++){
        if(i > 11){
          numberBuffer.write(creditCardNumber[i]);
        }
        else {
          numberBuffer.write("*");
        }

        var nonZeroIndex = i + 1;
        if (nonZeroIndex % 4 == 0 && nonZeroIndex != creditCardNumber.length) {
          numberBuffer.write('   ');
        }
      }
    }
    
    final expirationDate = cardInfoModel.expirationDate.toString();
    var dateBuffer = StringBuffer();
    
    if(cardInfoModel.expirationDate != null){
      for(int i = 0; i < expirationDate.length; i++){
        dateBuffer.write(expirationDate[i]);
        if(i == 1) {
          dateBuffer.write(" / ");
        }
      }
    }
    return Stack(
      children: [
        Image.asset("assets/images/CreditCard.png",fit: BoxFit.fill,),
        Positioned( top:100,left: 60,child: Text(numberBuffer.toString(),style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 26,color: secondary),)),
        Positioned( top:140,left: 60,child: Text("Card Holder Name",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 10,color: secondary),)),
        Positioned( top:160,left: 60,child: Text( cardInfoModel.cardHolderName ?? "",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 14,color: secondary),)),
        Positioned( top:140,right: 80,child: Text("Expiry Date",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 10,color: secondary),)),
        Positioned( top:160,right: 80,child: Text(dateBuffer.toString(),style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 14,color: secondary),)),
      ],
    );
  }

}