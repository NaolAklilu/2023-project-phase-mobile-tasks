import 'package:flutter/material.dart';
import 'package:todo_app/routing.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Stack(
          children: [
            Image.asset("assets/images/stick-man-painting.png"),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.list);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(250, 40),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text("Create Task"))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
