


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/User.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';
import 'package:furniture_shopping/ui/components/CheckBoxWithText.dart';
import 'package:furniture_shopping/ui/components/CreditCard.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/FloatingActionButtonAdd.dart';
import 'package:furniture_shopping/ui/profile/paymentsList/addNewPayment.dart';
import 'package:provider/provider.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  int? checkedIndex;

  Future<List<CardInfoModel>>? _data;
  @override
  void initState() {
    checkedIndex = -1;
    _data = globalDatabaseDao?.getAllMyCards();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Payment method"),
      floatingActionButton: FloatingActionButtonAdd(onPressed: (){
        _navigateToAddPaymentMethod();
      }),
      body: FutureBuilder(
        future:_data,
        builder: (context,snapshot) {
          if(snapshot.hasData && snapshot.data!.isNotEmpty)
          {
            return _buildListView(snapshot.data!);
          }
          else if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else
          {
            return const Center(child: Text("No Payments"),);
          }
        }
      ),
    );
  }

  ListView _buildListView(List<CardInfoModel> list) {
    return ListView.builder(
      itemBuilder: (context,index){return _paymentListItem(index,list[index]);},
      itemCount: list.length,
    );
  }

  Widget _paymentListItem(int index, CardInfoModel cardInfo) {
    return Column(
      children: [
        CreditCard(cardInfoModel: cardInfo,),
        CheckBoxWithText(text: "Use as default payment method",onChange: (newValue){
            checkedIndex = index;
            Provider.of<UserModel>(context,listen: false).cardInfo = cardInfo;
            setState(() {

            });
        }, isChecked: index == checkedIndex,),
        const SizedBox(height: 30,)
      ],
    );
  }

  Future<void> _navigateToAddPaymentMethod() async {
    await Navigator.push(context,MaterialPageRoute(builder: (context)=> const AddPaymentMethod()));
    if (!context.mounted) return;
    setState(() {
      _data = globalDatabaseDao?.getAllMyCards();
    });
  }
}
