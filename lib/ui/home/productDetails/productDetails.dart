import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/CountController.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:furniture_shopping/ui/home/productDetails/ratingAndReview/ratingAndReview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Item item;

  const ProductDetail({super.key, required this.item});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CountController? _countController;
  List<bool> isSelected = [true, false];
  ModelViewer? modelViewerWidget;
  ClipRRect? imageWidget;

  Future? _data;

  @override
  void initState() {
    _data = globalDatabaseDao?.getAllItemReview(widget.item.title);
    _countController = CountController();
    modelViewerWidget = ModelViewer(
      src: widget.item.modelPath,
      cameraControls: true,
      ar: true,
      disableZoom: true,
    );
    imageWidget = ClipRRect(
        borderRadius:
            const BorderRadius.only(bottomLeft: Radius.elliptical(100, 100)),
        child: Image.asset(
          widget.item.imagePath,
          fit: BoxFit.contain,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildScaffold(context, widget.item, snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Scaffold buildScaffold(
      BuildContext context, Item item, List<RatingAndReviewModel> list) {
    var rating = 0.0;
    for (var element in list) {
      rating += element.rating;
    }
    final ratingRatio = rating / list.length;
    var stringRatingRatio =
        double.parse(ratingRatio.toString()).toStringAsFixed(1);
    if (list.isEmpty) {
      stringRatingRatio = "Not Ratted Yet";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Visibility(visible: isSelected[0],maintainSize: false,maintainState: true, child: SizedBox(height:450,child: imageWidget!)),
                  Visibility(visible: isSelected[1],maintainSize: false,maintainState: true, child: SizedBox(height:450,child: modelViewerWidget!))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.gelasio(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: onPrimary),
                ),
                SizedBox(
                  height: 40,
                  child: ToggleButtons(
                      isSelected: isSelected,
                      selectedColor: Colors.white,
                      color: Colors.blue,
                      fillColor: Colors.lightBlue.shade900,
                      splashColor: Colors.white38,
                      highlightColor: Colors.orange,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      borderRadius: BorderRadius.circular(10),
                      children: const [
                        Text('Image', style: TextStyle(fontSize: 14)),
                        Text('3D', style: TextStyle(fontSize: 16)),
                      ],
                      onPressed: (newIndex) {
                        setState(() {
                          for (int index = 0;
                              index < isSelected.length;
                              index++) {
                            if (index == newIndex) {
                              isSelected[index] = true;
                            } else {
                              isSelected[index] = false;
                            }
                          }
                        });
                      }),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ ${item.price}",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: onPrimary),
                ),
                _countController!
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.star, color: starColor),
                const SizedBox(width: 15),
                Text(stringRatingRatio,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: onSurface)),
                const SizedBox(width: 15),
                InkWell(
                    onTap: () {
                      _navigateToRatingReview(item);
                    },
                    child: Text(
                      "(${list.length} reviews)",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: onSecondary,
                          fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: onPrimaryContainer),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Ink(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                          onTap: () {
                            item.favorite = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar("Added To Favorite",
                                    color: Colors.lightGreen,
                                    fontColor: onPrimary));
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: const Icon(
                            Icons.bookmark_border,
                            size: 24,
                          ))),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: SizedBox(
                          height: 60,
                          child: Consumer<CartModel>(
                              builder: (cartContext, cart, child) {
                            return MainButton(
                                text: "Add to cart",
                                onPressed: () {
                                  int counter = _countController?.getCounter();
                                  for (var i = 0; i < counter; i++) {
                                    cart.add(item);
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      getSnackBar(
                                          "$counter  ${item.title} Added To Cart",
                                          color: Colors.lightGreen,
                                          fontColor: onPrimary));
                                });
                          })))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToRatingReview(Item item) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RatingReview(item: item)));
    if (!context.mounted) return;
    setState(() {
      _data = globalDatabaseDao?.getAllItemReview(item.title);
    });
  }
}
