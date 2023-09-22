

import 'package:floor/floor.dart';

@Entity()
class CardInfoModel {
  String? cardHolderName;
  @PrimaryKey()
  int? cardNumber;
  int? cvv;
  int? expirationDate;
  CardInfoModel({
    this.cardHolderName,
    this.cardNumber,
    this.cvv,
    this.expirationDate,
  });

}