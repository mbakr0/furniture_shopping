


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/CreditCard.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/CustomTextField.dart';

import '../../components/MainButton.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Add payment method"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) { return MainView(boxConstraints:constraints); }
        ),
      ),
    );
  }

}

class MainView extends StatefulWidget {
  final BoxConstraints boxConstraints;
  const MainView({
    super.key,required this.boxConstraints
  });
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final cardInfo = CardInfoModel();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.boxConstraints.maxHeight,
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CreditCard(cardInfoModel: cardInfo),
              const SizedBox(height: 40),
              Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),child: CustomTextField(label: "CardHolder Name", keyboardType: TextInputType.name,
                onChange: (value){
                cardInfo.cardHolderName = value;
                setState(() {
                });
                return null;
                }

                ,)),
              Padding(padding: const EdgeInsets.fromLTRB(20, 30, 0, 20),child: CustomTextField(
                label: "Card Number",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                onChange: (value){
                  if(value != null && value != "") {
                    cardInfo.cardNumber = int.parse(value);
                  }
                  else{
                    cardInfo.cardNumber = null;
                  }
                  setState(() {
                  });
                  return null;
                },
              ),),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  Expanded(child: CustomTextField(label: "CVV", keyboardType: TextInputType.number,inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  onChange: (value){
                    if(value != null && value != "") {
                      cardInfo.cvv = int.parse(value);
                    } else {
                      cardInfo.cvv = null;
                    }
                    return null;
                  },
                  )),
                  const SizedBox(width: 60,),
                  Expanded(child: CustomTextField(label: "Expiration Date", keyboardType: TextInputType.number,inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  onChange: (value){
                    if(value != null && value != "") {
                      cardInfo.expirationDate = int.parse(value);
                    } else {
                      cardInfo.expirationDate = null;
                    }
                    setState(() {

                    });
                    return null;
                  },)),
                  const SizedBox(width: 20,)
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child : MainButton(text: "ADD NEW CARD",onPressed:_validateCard)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  _validateCard(){
    if(cardInfo.cardHolderName == null || cardInfo.cardNumber == null
        || cardInfo.cvv == null || cardInfo.expirationDate == null)
      {
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar("Add card Info",milliseconds: 600));
        return;

      }
    else {
      _addCardToDatabase();
    }
  }
  Future _addCardToDatabase() async {

    await globalDatabaseDao?.insertCardInfo(cardInfo);

    navigatorKey.currentState?.pop();
  }
}