import 'package:Memo/database/noteModel.dart';
import 'package:flutter/material.dart';
import 'package:Memo/providers/accountProvider.dart';
import 'package:Memo/providers/deleteAccountProvider.dart';
import 'package:Memo/providers/navbarProvider.dart';
import 'package:Memo/providers/notesProvider.dart';
import 'package:Memo/providers/titleProvider.dart';
import 'package:Memo/screens/deleteAccountPage.dart';
import 'package:Memo/screens/forgotPasswordPage.dart';
import 'package:Memo/screens/forgotPasswordSentPage.dart';
import 'package:Memo/screens/homePage.dart';
import 'package:Memo/screens/loginPage.dart';
import 'package:Memo/screens/notesDetailsPage.dart';
import 'package:Memo/screens/profilePage.dart';
import 'package:Memo/screens/showDetailsPage.dart';
import 'package:Memo/screens/signUp_Page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Titleprovider()),
        ChangeNotifierProvider(create: (context) => NavbarProvider()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => DeleteAccountProvider()),
        ChangeNotifierProvider(
          create: (context) => AccountProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AccountProvider>(
          builder: (context, accountProvider, child) {
            if (accountProvider.isLoggedIn) {
              return const Homepage();
            }
            return const LoginPage();
          },
        ),
        routes: {
          "home": (context) => const Homepage(),
          "loginPage": (context) => const LoginPage(),
          "signupPage": (context) => const SignupPage(),
          "notesdetailspage": (context) => Notesdetailspage(),
          "showdetailspage": (context) => Showdetailspage(
            note: ModalRoute.of(context)!.settings.arguments as Notemodel,
          ),
          "profilepage": (context) => const Profilepage(),
          "deleteaccountpage": (context) => const Deleteaccountpage(),
          "forgotpasswordpage": (context) => const Forgotpasswordpage(),
          "forgotpasswordsentpage": (context) => const Forgotpasswordsentpage(),
        },
      ),
    );
  }
}
