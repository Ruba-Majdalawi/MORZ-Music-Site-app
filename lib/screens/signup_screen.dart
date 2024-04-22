// signup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morzmusicsite/routes.dart';
import 'package:morzmusicsite/services/api_service.dart';
import 'package:flutter/cupertino.dart';


class SignUp extends StatefulWidget {
  const SignUp ({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formsatate = GlobalKey<FormState>();

  ApiService apiservice = ApiService();

var data;

  SignUp()async {
    var formData = formsatate.currentState;

    if (formData!.validate()) {
      var data = await apiservice.signup(username.text, password.text, firstName.text, lastName.text, address.text, email.text);

      if (data['result'] == "done") {
        Navigator.pushNamed(context, MyRoutes.HomeScreen);
      }
      else {
        showDialog(context: context, builder: (context) => AlertDialog(content: Text("This username is already exist on our data"),));
        print("not allowed");
      }
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    username.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }


  @override
    Widget build (BuildContext context) {
      return Material(
          color: Colors.white,
          child: SafeArea(
            child: Form(
              key: formsatate,
              child: SingleChildScrollView(
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/signup.jpg',
                    fit: BoxFit.cover,
                    height: 250,
                    width: 450,
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Courier',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Enter Your Username',
                            labelText: 'Username',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        TextFormField(
                          controller: firstName,
                          validator: (val){
                            if(val!.isEmpty){
                              return"Please input valid firstName";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Enter Your First Name',
                            labelText: 'First Name',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        TextFormField(
                          controller: lastName,
                          validator: (val){
                            if(val!.isEmpty){
                              return"Please input valid lastName";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Enter Your Last Name',
                            labelText: 'Last Name',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (val){
                            if(val!.isEmpty){
                              return"Please input valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Enter Your Email',
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
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
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        TextFormField(
                          controller: address,
                          validator: (val){
                            if(val!.isEmpty){
                              return"Please input valid address";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.home),
                            hintText: 'Enter Your Address',
                            labelText: 'Address',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        TextButton.icon(
                          onPressed: (() {
                            print(username.text);
                            print(firstName.text);
                            print(lastName.text);
                            print(email.text);
                            print(password.text);
                            print(address.text);
                            SignUp();

                            username.clear();
                            password.clear();
                            firstName.clear();
                            lastName.clear();
                            email.clear();
                            address.clear();
                          }
                          ),
                          icon: const Icon(Icons.create),
                          label: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: (() {
                                Navigator.pushNamed(context, MyRoutes.loginScreen,);
                              }),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'By signing up you agree to our terms, conditions and privacy Policy.',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
      );
    }
  }