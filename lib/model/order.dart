

import 'package:floor/floor.dart';

@Entity()
class OrderInfo{

  @PrimaryKey(autoGenerate: true)
  int? orderNumber;
  String timeCreated = DateTime.now().toString();
  double totalAmount;
  int quantity;


  OrderInfo({
    this.orderNumber,
    required this.quantity,
    required this.totalAmount,
  });

}