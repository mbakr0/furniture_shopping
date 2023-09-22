

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shopping/auth/Header.dart';
import 'package:furniture_shopping/auth/formValidation.dart';
import 'package:furniture_shopping/auth/login.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/ui/components/CustomTextField.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/color_schemes.g.dart';
import '../ui/components/MainButton.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String? password;


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60 ,20,60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,32),
                        child: Text("Welcome",style: GoogleFonts.merriweather(fontSize: 24,fontWeight: FontWeight.bold,color: onSurface))
                      ),
                      CustomTextField(label:"Name", keyboardType: TextInputType.name,textController: _nameController,inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ],validator: (value){
                        if (value == null || value.isEmpty || !value.isValidName) {
                          return 'Enter valid Name';
                        }
                        return null;
                      },),
                      const RowDivider(),
                      CustomTextField(label:"Email", keyboardType: TextInputType.emailAddress,textController:_emailController,validator: (value){
                        if (value == null || value.isEmpty || !value.isValidEmail) {
                          return 'Enter valid Email';
                        }
                        return null;
                      },),
                      const RowDivider(),
                      CustomTextField(
                        label:"Password",
                        keyboardType: TextInputType.visiblePassword,
                        textController: _passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onChange:(value){
                        setState(() {
                          password = value;
                        });
                        return null;
                      },validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Enter valid Password';
                        }
                        return null;
                      },),
                      const RowDivider(),
                      CustomTextField(
                        label:"Confirm Password",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Enter valid Password';
                        }
                        else if (value != password) {
                          return 'The password you entered is different';
                        }
                        return null;
                      },),
                      const RowDivider(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child : MainButton(text: "Sign Up",onPressed: _validate)
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0,5,2,5),
                              child: Text("Already have account? ",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: tertiary,fontSize: 12))),
                          InkWell(onTap:(){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>const Login())
                            );
                          },child: Text("Sign In",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: onPrimary ,fontSize: 12)))
                        ],
                      )
                    ],
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }

  _validate (){
    if (_formKey.currentState!.validate()) {
      _signUp();
    } else {
      return;
    }
  }

  Future _signUp() async {
    _showDialog();
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      ).then((value) => {
        value.user?.updateDisplayName(_nameController.text.trim()).then((value) => {

        }).whenComplete(() => navigatorKey.currentState?.popUntil((route) => route.isFirst)),
      }
      );


    } on Exception catch (e){
      navigatorKey.currentState?.pop();
      _showSnackBar(e.toString());
    }

  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(text,milliseconds: 600)
    );
  }
  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );
  }

}



class RowDivider extends StatelessWidget{
  const RowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 20,color: Colors.transparent);
  }
}