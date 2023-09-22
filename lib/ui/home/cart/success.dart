



import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/color_schemes.g.dart';

class Success extends StatelessWidget {
  const Success({super.key});



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 20),
        child: Column(
          children: [
            Text("SUCCESS!",style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 36,color: onSurface),),
            Image.asset("assets/images/success.png"),
            Lottie.network("https://lottie.host/86f0b7a2-852c-4ed4-b767-ac4119806f94/qotX020NlX.json",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              frameRate: FrameRate(24),
              animate: true,
            ),
            Text("Your order will be delivered soon.\nThank you for choosing our app!",style: GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.normal,color: onPrimaryContainer)),
            Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child : MainButton(text: "BACK TO HOME",onPressed:(){
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        })
                    ),
                  ),
                )

            )
          ],
        ),

      ),
    );
  }

}