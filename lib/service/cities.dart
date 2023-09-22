

import 'package:json_annotation/json_annotation.dart';
part 'cities.g.dart';

@JsonSerializable()
class Cities {
  bool? error;
  String? msg;
  List<String>? data;

  Cities({this.error, this.msg, this.data});

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
  Map<String, dynamic> toJson()=> _$CitiesToJson(this);

}