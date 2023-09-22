
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/addressModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/CustomDropDown.dart';
import 'package:furniture_shopping/ui/components/CustomTextField.dart';
import 'package:furniture_shopping/ui/profile/addressList/countryList.dart';
import '../../components/CustomAppBar.dart';
import '../../components/MainButton.dart';

class AddNewAddress extends StatefulWidget {

  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final address= AddressModel(country: "",addressLine: "",city: "",district: "",postalCode: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Add shipping address"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30,),
              CustomTextField(label: "Address", keyboardType: TextInputType.streetAddress,onChange: (value){
                if(value != null && value != "")
                  {
                    address.addressLine = value;
                    setState(() {});
                  }

                return null;
              },),
              const SizedBox(height: 30,),
              CustomTextField(label: "Zipcode (Postal Code)", keyboardType: TextInputType.number,onChange: (value){
                if(value != null && value != "")
                  {
                    address.postalCode = int.parse(value);
                    setState(() {});
                  }
                return null;
              },inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],),
              const SizedBox(height: 30),
              CustomDropDown(title: "Country", subTitle: (address.country == null)?"Select Country":address.country!,onPressed: (){
                _navigateAndDisplaySelection(context,true,null);
              },),
              const SizedBox(height: 30),
              CustomDropDown(title: "City", subTitle: (address.city == null)?"Select City":address.city!,onPressed: (){
                _navigateAndDisplaySelection(context,false,address.country);
              },),
              const SizedBox(height: 30),
              CustomTextField(label: "Add District",keyboardType: TextInputType.name,onChange: (value){
                if(value != null && value != "")
                  {
                    address.district = value;
                    setState(() {});
                  }
                return null;
              },),
              const SizedBox(height: 120),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child : MainButton(text: "SAVE ADDRESS",onPressed:_validateAddress)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context,bool isCountry, String? country) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryList(country: country)),
    );
    if (!context.mounted) return;
    if(isCountry)
      {
        address.country = result;
        address.city = "Select City";
      }
    else
      {
        address.city = result;
      }
    setState(() {

    });
  }

  _validateAddress(){
    if(address.addressLine == "" || address.district == ""
        || address.postalCode == 0 || address.country == ""
        || address.city == "" || address.city == "Select City")
      {
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar("Add Address Info",milliseconds: 600));
        return;
      }
    else {
      _addAddressToDatabase();
    }
  }

  Future _addAddressToDatabase() async {

    await globalDatabaseDao?.insertAddress(address);

    navigatorKey.currentState?.pop();
  }
}