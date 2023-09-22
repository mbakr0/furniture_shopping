
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture_shopping/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:furniture_shopping/service/cities.dart';
import 'package:furniture_shopping/service/countries.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryList extends StatefulWidget {
  final String? country;
   const CountryList({super.key,this.country});

  @override
  State<CountryList> createState() => _CountryListState();


}

class _CountryListState extends State<CountryList> {
   final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
   Future? _date;

  @override
  void initState() {

    if(widget.country != null)
      {

        _date = apiService.getCities(widget.country!);
      }
     else {
       _date = apiService.getCountries();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        body: FutureBuilder(
            future: _date,
            builder: (context,snapshot) {
              if(snapshot.hasData)
              {
                if(widget.country != null)
                  {
                    final cities = snapshot.data as Cities;
                    return Items(data: cities.data!);
                  }
                 else {
                   final countries = snapshot.data as Countries;
                   final data = countries.data?.map((e) => e.country);
                   return Items(data: data!.toList());
                }
              }

              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
              else {
                  return  Center(child: Text(snapshot.error.toString()));
              }

            }
        ) ,
      ),
    );


  }



}

class Items extends StatelessWidget {
  final List<String?> data;
  const Items({
    super.key,required this.data
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index){
          return _listItemView(context,index);
        },
        separatorBuilder: (context,index){
          return const SizedBox(height: 10);
        },
        itemCount:data.length );
  }

  Widget _listItemView(BuildContext context,int index) {
    return ListTile(
      onTap: (){
        Navigator.pop(context,data[index]);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(data[index]!,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 18),),
    );
  }
}

