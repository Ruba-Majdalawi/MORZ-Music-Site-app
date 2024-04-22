import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  final username;
  final password;
  const HomeScreen({this.username, this.password});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
                                      totalRepeatCount: 1,  // Show text twice
                                      // After animation finishes, text disappears
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/song_list');
                                },
                                icon: const Icon(Icons.audiotrack),
                                label: const Text('Browse Songs'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/artist_list');
                                },
                                icon: const Icon(Icons.person),
                                label: const Text('Browse Artists'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/order');
                                },
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text('Browse Orders'),
                              ),
                            ]
                        )
                    )
                )
            )
        )
    );

  }
}