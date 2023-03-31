import 'package:flutter/material.dart';
import 'package:projectcarwash/page_view/home.dart';
import 'package:projectcarwash/page_view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    check();
  }

  bool isLogin = false;

  check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SplashScreenView(
          navigateRoute: isLogin ? Home() : Login(),
          pageRouteTransition: PageRouteTransition.Normal,
          duration: 3000,
          imageSrc: "img/bb.png",
          imageSize: 150,
          backgroundColor: const Color(0xff8d8efc),
        ),
      ),
    );
  }
}
