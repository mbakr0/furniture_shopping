import 'package:json_annotation/json_annotation.dart';
import 'data.dart';
part 'countries.g.dart';

@JsonSerializable()
class Countries {
  bool? error;
  String? msg;
  List<Data>? data;

  Countries({ this.error, this.msg, this.data});

  factory Countries.fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);


}