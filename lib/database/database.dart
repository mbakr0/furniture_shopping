
import 'package:floor/floor.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';
import 'package:furniture_shopping/model/addressModel.dart';
import 'package:furniture_shopping/model/orderNotification.dart';
import 'package:furniture_shopping/model/order.dart';
import 'package:furniture_shopping/model/ratingAndReviewModel.dart';
import 'dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'database.g.dart';

@Database(version: 1, entities: [AddressModel,CardInfoModel,RatingAndReviewModel,OrderInfo,OrderNotification])
abstract class DataBase extends FloorDatabase{
  DatabaseDao get databaseDao;
}