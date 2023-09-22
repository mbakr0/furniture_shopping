
import 'package:furniture_shopping/service/countries.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'cities.dart';
part 'api_service.g.dart';



@RestApi(
  baseUrl:"https://countriesnow.space/api/v0.1/countries/",
)
abstract class ApiService {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("")
  Future<Countries> getCountries();


  @GET("cities/q")
  Future<Cities> getCities(@Query("country") String country);


}