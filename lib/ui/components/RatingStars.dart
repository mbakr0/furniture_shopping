


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../theme/color_schemes.g.dart';

class RatingStars extends StatelessWidget {
  final double size;
  final bool ignoreGestures;
  final void Function(double)? onRatingUpdate;
  final double initialRating;
  const RatingStars({super.key,this.size = 24,this.ignoreGestures = true , this.onRatingUpdate, required this.initialRating});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        allowHalfRating: true,
        initialRating: initialRating,
        minRating: 1,
        itemSize: size,
        ignoreGestures: ignoreGestures,
        unratedColor: unFillStartColor,
        itemBuilder: (context,index) => const Icon(Icons.star,color: starColor),
        onRatingUpdate: onRatingUpdate ?? (value){}
    );
  }

}