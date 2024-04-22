import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class adminScreen extends StatefulWidget {
  const adminScreen({super.key});

  @override
  State<adminScreen> createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.red,
              centerTitle: true,
              title: const Text(
                'MORZ Music Site',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times',
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/welcome.jpg',
                              fit: BoxFit.cover,
                              height: 200,
                              width: 450,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  FadeAnimatedText(
                                    'Welcome to music app ❤️',
                                    textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Times New Roman',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                totalRepeatCount: 2,  // Show text twice
                                // After animation finishes, text disappears
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_artist');
                          },
                          child: const Text('Add New Artist'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_song');
                          },
                          child: const Text('Add New Song'),
                        ),

                      ]
                  )
              ),
            ),
          )
      ),
    );
  }
}