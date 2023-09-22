


import 'package:flutter/material.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/model/User.dart';
import 'package:furniture_shopping/model/addressModel.dart';
import 'package:furniture_shopping/theme/color_schemes.g.dart';
import 'package:furniture_shopping/ui/components/CheckBoxWithText.dart';
import 'package:furniture_shopping/ui/components/CustomAppBar.dart';
import 'package:furniture_shopping/ui/components/FloatingActionButtonAdd.dart';
import 'package:furniture_shopping/ui/profile/addressList/addNewAddress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  int checkedIndex = -1;

  Future? _data;

  @override
  void initState() {
    _data = globalDatabaseDao?.getAllMyAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Shipping address"),
      floatingActionButton: FloatingActionButtonAdd(onPressed: (){
        _navigateToAddNewAddress();
      },),
      body: FutureBuilder(
          future: _data,
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
              return const Center(child: Text("No Addresses"),);
            }
        }
      ),
    );
  }

  ListView _buildListView(List<AddressModel> data) {
    return ListView.separated(
      itemBuilder: (context,index){ return _addressListItem(index,data[index]);},
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 40);
    },
    );
  }

  Widget _addressListItem(int index, AddressModel address) {
    return Column(
      children: [
        CheckBoxWithText(text: "Use as the shipping address",
          onChange: (newValue){
            checkedIndex = index;
            Provider.of<UserModel>(context, listen: false).address = address;
            setState(() {
            });
          }, isChecked: index == checkedIndex,),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          surfaceTintColor: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(40,0,40,0),
            titleAlignment: ListTileTitleAlignment.threeLine,
            trailing: const Icon(Icons.edit_rounded),
            subtitle: Text("${address.addressLine} ${address.district} \n${address.city} , ${address.country} "),
            subtitleTextStyle: GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.normal,color: onSecondary),
          ),
        )
      ],
    );
  }

  Future<void> _navigateToAddNewAddress() async {
    await Navigator.push(context,MaterialPageRoute(builder: (context)=> const AddNewAddress()));
    if (!context.mounted) return;
    setState(() {
      _data = globalDatabaseDao?.getAllMyAddress();
    });
  }
}

















