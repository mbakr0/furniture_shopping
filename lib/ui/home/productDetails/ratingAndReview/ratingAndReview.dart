


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/User.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/ImageWidget.dart';
import 'package:furniture_shopping/ui/components/ProductName.dart';
import 'package:furniture_shopping/ui/home/productDetails/ratingAndReview/writingReview.dart';
import 'package:furniture_shopping/util/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../components/MainButton.dart';
import '../../../components/RatingStars.dart';

class RatingReview extends StatefulWidget {
  final Item item;
  const RatingReview({super.key, required this.item});

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {

  Future? _data;
  @override
  void initState() {
    _data = globalDatabaseDao?.getAllItemReview(widget.item.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Rating & Review"),
      body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder(
        future: _data,
        builder: (context,snapshot) {
          if(!snapshot.hasData)
          {
            return const Center(child: Text("NO Rating Nor Review"),);
          }
          final List<RatingAndReviewModel> list = snapshot.data;
          var rating = 0.0;
          for (var element in list) {
            rating += element.rating;
          }
          final ratingRatio = rating/list.length;
          var stringRatingRatio = double.parse(ratingRatio.toString()).toStringAsFixed(1);
          if(list.isEmpty)
          {
            stringRatingRatio = "Not Ratted Yet";
          }


          return Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  ImageWidget(path:widget.item.imagePath),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductName(name: widget.item.title),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star,color: starColor),
                          const SizedBox(width: 10),
                          Text(stringRatingRatio,style: GoogleFonts.nunitoSans(fontSize: 24,fontWeight: FontWeight.bold,color: onSurface))
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text("${list.length}",style: GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.w600,color: onSurface))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 2,thickness: 1,color: secondary),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context,index){return ReviewListItem(singleReview:snapshot.data[index]);},
                    itemCount: snapshot.data?.length),
              )
              ,
              Padding(
                  padding: const EdgeInsets.fromLTRB(50,0,50,10),
                  child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: MainButton(text: "Write a review", onPressed: (){
                        _navigateToWritingReview(widget.item);
                      })
                  )
              )
            ],
          );
        }
      ),
    ),
  );
  }

  Future<void> _navigateToWritingReview(Item item) async {

    await Navigator.push(context,PageTransition(type:PageTransitionType.fade,child: WritingReview(item:item)));
    if (!context.mounted) return;
    setState(() {
      _data = globalDatabaseDao?.getAllItemReview(item.title);
    });
  }
}

class ReviewListItem extends StatelessWidget{
  final RatingAndReviewModel singleReview;
  const ReviewListItem({super.key, required this.singleReview});

  @override
  Widget build(BuildContext context) {
    String formattedDate = getFormattedDate(singleReview.date);
    UserModel user = Provider.of<UserModel>(context,listen: false);
    return Card(
      margin: const EdgeInsets.fromLTRB(2,30,2,2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      semanticContainer:true,
        color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment:Alignment.center,child: CircleAvatar( backgroundColor: tertiaryContainer,radius: 25,child: Text(user.name![0].toUpperCase()))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.name??"can't get name",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600,fontSize: 14,color: onPrimary)),
                  Text(formattedDate,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 12,color: onSecondary))
                ],
              ),
              RatingStars(initialRating: singleReview.rating),
              const SizedBox(height: 10,),
              Text(singleReview.review,
                  style: GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.normal,color: onPrimary),overflow: TextOverflow.ellipsis,maxLines: 10, textAlign: TextAlign.justify)
            ],
          ),
        ),
    );
  }
}
