
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Data {
  String? iso2;
  String? iso3;
  String? country;
  List<String>? cities;
  Data({this.iso2, this.iso3, this.country, this.cities});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson()=> _$DataToJson(this);

}
