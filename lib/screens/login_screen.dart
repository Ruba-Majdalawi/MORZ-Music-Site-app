// login_screen.dart

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:morzmusicsite/routes.dart';
import 'package:morzmusicsite/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

String? customerId;
// Separate widget for login form
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();

  GlobalKey<FormState> formsatate = GlobalKey<FormState>();

  ApiService apiservice = ApiService();

  var data;
  var admin;

  Login() async {
    var formData = formsatate.currentState;
    if (formData!.validate()) {

      var data = await apiservice.login(username.text, password.text);

      if (data["result"] == "not here") {

        showDialog(context: context, builder: (context) => AlertDialog(content: Text("This username or password are not on our data"),));
      }
      else if (data["result"] == "admin") {
        // Navigate to admin page
        Navigator.pushNamed(context, MyRoutes.adminScreen);
      }
      else{ // Assume the response contains 'customer_id'

        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(username: data['result'][0]['username'], password: data['result'][0]['password'])));
        print("login");

      }
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    username.dispose();
    password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Form(
          key: formsatate,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                height: 250,
                width: 250,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText ('Welcome!',
                      textStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w500,
                      ),
                      speed: const Duration(
                        milliseconds: 550,
                      )),
                ],
                isRepeatingAnimation: true,
                totalRepeatCount: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: username,
                      validator: (val){
                        if(val!.isEmpty){
                          return"Please input valid username";
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter Your Username',
                        labelText: 'Username',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      controller: password,
                      validator: (val){
                        if(val!.isEmpty){
                          return"Please input valid password";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.forgetPassword);
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                    TextButton.icon(
                      onPressed: (() async {

                         print(username.text);
                         print(password.text);
                         Login();
                         username.clear();
                         password.clear();
                      }
                      ),
                      icon: const Icon(Icons.login),
                      label: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),

                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: (() {
                            Navigator.pushNamed(context, MyRoutes.signUp,);
                          }),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
