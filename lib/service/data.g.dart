// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      iso2: json['iso2'] as String?,
      iso3: json['iso3'] as String?,
      country: json['country'] as String?,
      cities:
          (json['cities'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'iso2': instance.iso2,
      'iso3': instance.iso3,
      'country': instance.country,
      'cities': instance.cities,
    };
