

import 'package:floor/floor.dart';

@Entity()
class RatingAndReviewModel{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String itemTitle;
  String date = DateTime.now().toString();
  String review;
  double rating;

  RatingAndReviewModel({
    required this.itemTitle,
    required this.review,
    required this.rating,
  });
}