import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/order.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/util/util.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/color_schemes.g.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("My order"),
      body: StreamBuilder<List<OrderInfo>>(
        stream: globalDatabaseDao?.getAllMyOrders(),
        builder: (context,snapshot){

          if(snapshot.hasData && snapshot.data!.isNotEmpty)
            {
              return _buildListView(snapshot.data!);
            }
          else if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else {
            return const Center(child: Text("No Orders"),);
          }

        }
      ),
    );
  }

  ListView _buildListView(List<OrderInfo> list) {
    return ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _orderListHeader(list);
          }
          return _orderListItem(index - 1,list[index - 1]);
        },
        itemCount: list.length + 1,
      );
  }
}

_orderListHeader(List<OrderInfo> list) {
  var totalPrice = 0.0;
  var totalQuantity = 0;
  for (var element in list) {
    totalPrice+=element.totalAmount;
    totalQuantity+=element.quantity;
  }
  return FractionallySizedBox(
    widthFactor: 0.9,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        RichText(
            text: TextSpan(
                text: "Number Of Order: ",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: onSecondary),
                children: <TextSpan>[
              TextSpan(
                  text: (list.length > 9) ? list.length.toString():"0${list.length}",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: onSurface))
            ])),
        RichText(
            text: TextSpan(
                text: "Total Price: ",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: onSecondary),
                children: <TextSpan>[
              TextSpan(
                  text: (totalPrice > 9) ? totalPrice.toString():"0$totalPrice",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: onSurface))
            ])),
        RichText(
            text: TextSpan(
                text: "Total Quantity: ",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: onSecondary),
                children: <TextSpan>[
              TextSpan(
                  text: (totalQuantity > 9) ? totalQuantity.toString():"0$totalQuantity",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: onSurface))
            ]))
      ],
    ),
  );
}

_orderListItem(int index,OrderInfo order) {
  final date = getFormattedDate(order.timeCreated);
  return Card(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 2),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(width: .5, color: onPrimaryContainerAlpha40)),
    elevation: 1,
    semanticContainer: true,
    color: Colors.white,
    surfaceTintColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order No ${order.orderNumber}",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: onPrimary),
              ),
              Text(
                date,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: dateColor),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(height: 5, thickness: 2, color: secondary),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Quantity: ",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: onSecondary),
                      children: <TextSpan>[
                    TextSpan(
                        text: (order.quantity > 9) ? order.quantity.toString():"0${order.quantity}",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: onSurface))
                  ])),
              RichText(
                  text: TextSpan(
                      text: "Total Amount: ",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: onSecondary),
                      children: <TextSpan>[
                    TextSpan(
                        text: "\$${order.totalAmount}",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: onSurface))
                  ]))
            ],
          )
        ],
      ),
    ),
  );
}
