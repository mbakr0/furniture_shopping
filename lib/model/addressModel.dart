

import 'package:floor/floor.dart';

@Entity()
class AddressModel{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? addressLine;
  int? postalCode;
  String? country;
  String? city;
  String? district;
  AddressModel({
    this.addressLine,
    this.postalCode,
    this.country,
    this.city,
    this.district,
  });
}