import 'package:flutter/material.dart';
import 'package:morzmusicsite/screens/home_screen.dart';
import 'package:morzmusicsite/screens/login_screen.dart';
import 'package:morzmusicsite/screens/signup_screen.dart';
import 'package:morzmusicsite/screens/forget.dart';
import 'package:morzmusicsite/screens/admin_Screen.dart';
import 'package:morzmusicsite/routes.dart';
import 'package:morzmusicsite/screens/add_artist_screen.dart';
import 'package:morzmusicsite/screens/add_song_screen.dart';
import 'package:morzmusicsite/screens/all_songs_screen.dart';
import 'package:morzmusicsite/screens/all_artists_screen.dart';
import 'package:morzmusicsite/screens/buy_song_screen.dart';
import 'package:morzmusicsite/screens/order_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MORZ Music Site',
        initialRoute: '/',
        routes: {
          MyRoutes.loginScreen: (context) => const LoginScreen(),
          MyRoutes.signUp: (context) => const SignUp(),
          MyRoutes.forgetPassword: (context) => const ForgotPassword(),
          MyRoutes.HomeScreen: (context) => const HomeScreen(),
          MyRoutes.AddArtistScreen: (context) => const AddArtistScreen(),
          MyRoutes.AddSongScreen: (context) => const AddSongScreen(),
          MyRoutes.BuySongScreen: (context) => BuySongScreen(songDetials: null,),
          MyRoutes.ALLSongsScreen: (context) => const AllSongsScreen(),
          MyRoutes.ALLArtistsScreen: (context) => const AllArtistsScreen(),
          MyRoutes.adminScreen: (context) => const adminScreen(),
          MyRoutes.orderscreen: (context) => const orderScreen(),
        }
    );
  }
}
