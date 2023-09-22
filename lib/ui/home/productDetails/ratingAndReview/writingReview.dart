


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/RatingStars.dart';

class WritingReview extends StatefulWidget {
  final Item item;
  const WritingReview({super.key, required this.item});

  @override
  State<WritingReview> createState() => _WritingReviewState();
}

class _WritingReviewState extends State<WritingReview> {
  double rating = 0;
  String review = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            RatingStars(size: 50,ignoreGestures: false,initialRating: 1,onRatingUpdate: (value){rating = value;},),
            const SizedBox(height: 50,),
            TextFormField(
              autofocus: true,
              obscureText: false,
              onChanged: (value){
                review = value;
              },
              decoration: InputDecoration(
                labelText: 'Write a review',
                labelStyle: GoogleFonts.nunitoSans(fontSize: 12,color: onSecondary,fontWeight: FontWeight.normal),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,

              ),
              maxLines: 5,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                  child:Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child : MainButton(text: "Add a review",onPressed:(){
                          if(rating == 0 || review == "")
                            {
                              ScaffoldMessenger.of(context).showSnackBar(getSnackBar("add rating and review",milliseconds: 600));
                            } else {
                            globalDatabaseDao?.insertRatingAndReview(
                              RatingAndReviewModel(itemTitle: widget.item.title, review: review, rating: rating)
                            );
                            Navigator.pop(context);
                          }
                        })
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}