


import 'package:floor/floor.dart';

@Entity()
class OrderNotification{
  @PrimaryKey()
  final int orderNumber;
  final String date;
  final String imagePath;
  final String title;
  OrderNotification({required this.orderNumber, required this.date, required this.imagePath, required this.title});

}