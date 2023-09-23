import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping/auth/login.dart';
import 'package:furniture_shopping/ui/components/MainButton.dart';
import 'package:furniture_shopping/ui/home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'database/dao.dart';
import 'database/database.dart';
import 'model/User.dart';
import 'model/cartModel.dart';
import 'theme/color_schemes.g.dart';
import 'util/firebase_options.dart';

import 'dart:developer' as developer;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFireBase();
  runApp(const MyApp());
}

DatabaseDao? globalDatabaseDao;

Future initializeFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final database = await $FloorDataBase.databaseBuilder("database").build();
  globalDatabaseDao = database.databaseDao;
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => UserModel())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home:StreamBuilder<User?>(


          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {  
            if (snapshot.hasData) {
              _setNameAndEmail(context,snapshot.data!);
              return const Home();
            } else {
              return const HomePage();
            }
          },
        ),
      ),
    );
  }

  void _setNameAndEmail(BuildContext context, User data){
    Provider.of<UserModel>(context,listen: false).name =  data.displayName;
    Provider.of<UserModel>(context,listen: false).email = data.email;
  }

}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MAKE YOUR', style: GoogleFonts.gelasio(fontSize: 24,fontWeight: FontWeight.w600,color: onPrimaryContainer)),
                Text('HOME BEAUTIFUL', style: GoogleFonts.gelasio(fontSize: 30,fontWeight: FontWeight.bold,color: onSurface)),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(60, 0, 20, 0),
                child: Text(
                  'The best simple place where you \n discover most wonderful furnitures \n and make your home beautiful',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.normal,color: onSecondary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(100),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: MainButton(
                      text: "Get Started",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      })),
            )
          ],
        ),
      ),
    );
  }
}
