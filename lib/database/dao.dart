
import 'package:floor/floor.dart';
import 'package:furniture_shopping/model/addressModel.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';
import 'package:furniture_shopping/model/orderNotification.dart';
import 'package:furniture_shopping/model/order.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';

@dao
abstract class DatabaseDao{

  @insert
  Future<void> insertAddress(AddressModel address);
  @insert
  Future<void> insertCardInfo(CardInfoModel cardInfo);
  @insert
  Future<void> insertRatingAndReview(RatingAndReviewModel ratingAndReview);
  @insert
  Future<void> insertOrderNotification(OrderNotification orderNotification);
  @insert
  Future<int> insertOrder(OrderInfo order);

  @Query('SELECT * FROM OrderInfo')
  Stream<List<OrderInfo>> getAllMyOrders();
  @Query('SELECT * FROM OrderNotification')
  Future<List<OrderNotification>> getAllNotification();
  @Query('SELECT * FROM AddressModel')
  Future<List<AddressModel>> getAllMyAddress();
  @Query('SELECT * FROM CardInfoModel')
  Future<List<CardInfoModel>> getAllMyCards();
  @Query('SELECT * FROM RatingAndReviewModel')
  Future<List<RatingAndReviewModel>> getAllMyReview();



  @Query('SELECT * FROM RatingAndReviewModel WHERE itemTitle = :itemTitle')
  Future<List<RatingAndReviewModel>> getAllItemReview(String itemTitle);



}