import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

void main() => runApp(const MaterialApp(home: SplashScreenDemo()));

class SplashScreenDemo extends StatefulWidget {
  const SplashScreenDemo({super.key});

  @override
  State<SplashScreenDemo> createState() => _SplashScreenDemoState();
}

class _SplashScreenDemoState extends State<SplashScreenDemo> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // if you want increase time
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePageDemo())); // replace with your home screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(29, 67, 138, 2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text("Helipagos",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 191, 178, 2), fontSize: 50)),
              Spacer(),
              SafeArea(
                  bottom: true,
                  child: Text(
                    "Helipagos",
                    style: TextStyle(
                        fontSize: 22, color: Color.fromRGBO(0, 191, 178, 2)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
