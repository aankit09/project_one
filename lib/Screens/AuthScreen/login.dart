import 'package:flutter/material.dart';

import '../../Services/apiservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                    child: Image.asset('assets/images/logooo.png'),
                  )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Enter Vaild Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintText: 'Enter Your Email Id',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                    child: TextFormField(
                      validator: (PassCurrentValue) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        var passNonNullValue = PassCurrentValue ?? "";
                        if (passNonNullValue.isEmpty) {
                          return ("Password is required");
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintText: 'Enter Your Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            // Set border color
                            width: 3.0), // Set border width
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                      ),
                      child: InkWell(
                        onTap: () {
                          ApiServices().logIn(emailController.text.toString(),
                              passwordController.text.toString());
                        },
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
