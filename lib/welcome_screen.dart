import 'package:flutter/material.dart';
import 'package:harmony/const/colors.dart';
import 'package:harmony/home_screen.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gradient;

import 'page_task.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentDateTime = 0;
  String greeting = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    currentDateTime = DateTime.now().hour;
    if (currentDateTime >= 0 && currentDateTime < 12) {
      greeting = 'Good Morning';
    } else if (currentDateTime >= 12 && currentDateTime < 16) {
      greeting = 'Good Afternoon';
    } else if (currentDateTime >= 16 && currentDateTime < 20) {
      greeting = 'Good Evening';
    } else if (currentDateTime >= 20 && currentDateTime < 24) {
      greeting = 'Good Night';
    }
    print(currentDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: gradient.LinearGradient(
                colors: [pColor, sColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: aColor,
                  blurRadius: 50.0,
                  spreadRadius: 10.0,
                ),
              ],
            ),
            child: const Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 100.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Welcome to Harmony',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Poppins",
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          const RiveAnimation.asset(
            'assets/sw.riv',
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 10,
            child: SizedBox(
              width: 200.0,
              height: 75.0,
              child: FloatingActionButton(
                backgroundColor: sColor,
                shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  0.0,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TaskPage();
                  }));
                  // Add your functionality here
                  print('Good morning button pressed');
                },
                child: Text(
                  greeting,
                  style: TextStyle(
                    color: aColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
