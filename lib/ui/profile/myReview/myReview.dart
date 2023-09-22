


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/ImageWidget.dart';
import 'package:furniture_shopping/ui/components/PriceTag.dart';
import 'package:furniture_shopping/ui/components/ProductName.dart';
import 'package:furniture_shopping/ui/components/RatingStars.dart';
import 'package:furniture_shopping/util/util.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/color_schemes.g.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  List<Item> items = [];
  void _getItemList(){
    items = Item.getItems;
  }

  @override
  Widget build(BuildContext context) {
       _getItemList();
      return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: customAppBar("My reviews"),
        body: FutureBuilder(
            future: globalDatabaseDao?.getAllMyReview(),
            builder: (context,snapshot) {
              if(snapshot.hasData && snapshot.data!.isNotEmpty)
              {
                return _buildListView(snapshot.data!);
              }
              else if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              else
              {
                return const Center(child: Text("No Review"),);
              }

          }
        ),
      );
  }

  ListView _buildListView(List<RatingAndReviewModel> ratingReviewList) {
    return ListView.separated(
            itemBuilder: (context,index) {
              final Item item = items.firstWhere((element) =>
               element.title == ratingReviewList[index].itemTitle
              );
              return MyReviewListItem(singleReview:ratingReviewList[index],item:item);},
            itemCount: ratingReviewList.length,
            separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 20,child: Divider(height: 2,thickness: 2,color: outline,indent: 20,endIndent: 20,),); },
          );
  }
}

class MyReviewListItem extends StatelessWidget{
  final RatingAndReviewModel singleReview;
  final Item item;
  const MyReviewListItem({super.key, required this.singleReview, required this.item});

  @override
  Widget build(BuildContext context) {
    String formattedDate = getFormattedDate(singleReview.date);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(path: item.imagePath),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ProductName(name: item.title),
                  const SizedBox(height: 5),
                  PriceTag(price: item.price),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingStars(initialRating: singleReview.rating ),
              Text(formattedDate,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 12,color: onSecondary))
            ],
          ),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(singleReview.review,
                style: GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.normal,color: onPrimary),overflow: TextOverflow.ellipsis,maxLines: 10, textAlign: TextAlign.justify),
          )
        ],
      ),
    );
  }
}