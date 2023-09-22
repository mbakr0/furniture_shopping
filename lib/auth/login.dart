
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping/auth/formValidation.dart';
import 'package:furniture_shopping/auth/register.dart';
import 'package:furniture_shopping/main.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/color_schemes.g.dart';
import '../ui/components/CustomTextField.dart';
import 'Header.dart';

class Login extends StatefulWidget{
   const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.fromLTRB(20,60,20,60),
        child: SingleChildScrollView(
          child: Column(
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
                        padding: const EdgeInsets.fromLTRB(0,12,0,4),
                        child: Text("Hello !",style: GoogleFonts.merriweather(fontSize: 30,fontWeight: FontWeight.normal,color: tertiary)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,32),
                        child: Text("Welcome Back",style: GoogleFonts.merriweather(fontSize: 24,fontWeight: FontWeight.bold,color: onSurface)),
                      ),
                      CustomTextField(label: "Email",keyboardType: TextInputType.emailAddress,textController: _emailController,validator: (value){
                        if (value == null || value.isEmpty || !value.isValidEmail) {
                          return 'Enter valid email';

                        }
                        return null;
                      }),
                      const Divider(height: 20,thickness: 2,color: Colors.white),
                      CustomTextField(
                          label: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          textController: _passwordController,validator:(value){
                        if (value == null || value.isEmpty) {
                          return 'Enter valid Password';
                        }
                        return null;
                      }),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,20,0,20),
                          child: Text("Forget Password",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: onPrimary)),
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.all(40),
                         child: SizedBox(
                           width: double.infinity,
                             height: 50,
                             child : MainButton(text: "Log In",onPressed: validate)
                         ),
                       ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,20,0,20),
                          child: InkWell(onTap:(){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>const Register())
                            );
                          },child: Text("Sign Up",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: onPrimary))),
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );

  }


  validate (){
    if (_formKey.currentState!.validate()) {
      signIn();
    } else {
      return;
    }
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
        navigatorKey.currentState?.popUntil((route) => route.isFirst);

      } on Exception catch (e){
        navigatorKey.currentState?.pop();
        showSnackBar(e.toString());

      }


  }
  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(text,milliseconds: 1000)
    );
  }

}
