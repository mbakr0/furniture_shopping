


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/orderNotification.dart';
import 'package:furniture_shopping/ui/components/ImageWidget.dart';
import 'package:furniture_shopping/util/util.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/color_schemes.g.dart';

class NotificationPage extends StatelessWidget {
  final ScrollController scrollController;
  final int selectedIndex;
  const NotificationPage({super.key, required this.scrollController, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: globalDatabaseDao?.getAllNotification(),
      builder: (context,snapshot) {
        if(snapshot.hasData && snapshot.data!.isNotEmpty)
        {
          return _buildScaffold(snapshot.data!);
        }
        else if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const CircularProgressIndicator();
          }
        else {
          return const Center(child: Text("You Have No Notification"),);
        }
      }
    );
  }

  Scaffold _buildScaffold(List<OrderNotification> list) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: ListView.separated(
            controller: (selectedIndex == 2) ? scrollController : ScrollController(),
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context , index) {
              return NotificationListItem(item:list[index]);
            },
            separatorBuilder: (context,index){
              return const Divider(height:1,thickness: 1,color: secondary,);
            } ,
            itemCount: list.length),
      );
  }

}

class NotificationListItem extends StatelessWidget{
  final OrderNotification item;
  const NotificationListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ImageWidget(path: item.imagePath),
           const SizedBox(width: 20),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Your order #${item.orderNumber} has been confirmed",style: GoogleFonts.nunitoSans(fontSize: 12,fontWeight: FontWeight.bold,color: onPrimary),),
                 const SizedBox(height: 5,),
                 Text("${item.title}  Ordered on  ${getFormattedDate(item.date)} ", style:
                 GoogleFonts.nunitoSans(fontSize: 10,fontWeight: FontWeight.normal,color: onSecondary),overflow: TextOverflow.ellipsis,maxLines: 10, textAlign: TextAlign.justify)
               ],
             ),
           )
         ],
       ),
     );
  }
}