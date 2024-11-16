import 'package:evente_mobile_admin_app/Screen/Home_Screen.dart';
import 'package:evente_mobile_admin_app/widget/Rounded_Button.dart';
import 'package:flutter/material.dart';

import '../base/color_data.dart';
import '../base/widget_utils.dart';
import '../widget/snacbar copy.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  bool rememberMe = true;
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 late String message = '';

  void backClick() {
    Navigator.of(context).pop();
  }

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  bool signInStart = false;
  late String email;
  late String pass;
  // Icon lockIcon = LockIcon().lock;
  bool offsecureText = true;
  Widget _title() {
    return const Text(
      "Welcome There!",
      style: TextStyle(
        fontFamily: "Sofia",
        fontSize: 33,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _subtitle() {
    return const Text(
      "Sign in to your admin account",
      style: TextStyle(
        fontFamily: "Sofia",
        wordSpacing: -0.5,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }

  final _btnController = RoundedLoadingButtonController();
  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        // lockIcon = LockIcon().open;
      });
    } else {
      setState(() {
        offsecureText = true;
        // lockIcon = LockIcon().lock;
      });
    }
  }

  Widget _textField(controller, title, bool isPassword) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            obscureText: isPassword,
            keyboardType: TextInputType.emailAddress,
            controller: controller,
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Enter your $title",
              border: InputBorder.none,
              fillColor: const Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }




  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          color: const Color(0xFF8E9873)),
      child: const Text(
        'Sign In ',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _signupTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: "Not an account yet? ",
          style: TextStyle(
            fontFamily: "Sofia",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff00234B),
          ),
          children: [
            TextSpan(
              text: "Sign Up",
              style: TextStyle(color: Color(0xFF8E9873), fontSize: 16),
            ),
          ]),
    );
  }

  

void login() {
    if (formKey.currentState!.validate()) {
      String id = idController.text;
      String password = passwordController.text;

      if (id == 'admin' && password == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
              _btnController.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    'Please input and password correctly',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            
        setState(() {
              openSnacbar(_scaffoldKey, "Please input and password correctly");
        });
      }
    }else {
      _btnController.reset();  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    'Please input and password correctly',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            
        setState(() {
              openSnacbar(_scaffoldKey, "Please input and password correctly");
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
              
     
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      _title(),
                      const SizedBox(
                        height: 5,
                      ),
                      _subtitle(),
                      const SizedBox(
                        height: 65,
                      ),
                          getCustomFont("ID Admin", 16, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                           const SizedBox(
                        height: 15,
                      ),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: "Sofia"),
                            decoration: InputDecoration(
                                hintText: 'ID Admin',
                                labelText: 'Admin',
                                // helperText: "Admin",
                                counter: Container(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: borderColor, width: 1 )),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: borderColor, width: 1 )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: accentColor, width: 1 )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: errorColor, width: 1 )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: errorColor, width: 1 )),
                                errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 ,
                                    fontFamily: "Sofia"),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(22 ),
                                    borderSide: BorderSide(
                                        color: borderColor, width: 1 )),
                                suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 24 ,
                                ),
                                hintStyle: TextStyle(
                                    color: greyColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: "Sofia")),
                            controller: idController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "ID can't be empty";
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                     
                          const SizedBox(
                            height: 20,
                          ),
                          getCustomFont("Password", 16, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: "Sofia"),
                            decoration: InputDecoration(
                              counter: Container(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 1 )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 1 )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: accentColor, width: 1 )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: errorColor, width: 1 )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: errorColor, width: 1 )),
                              errorStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 ,
                                  fontFamily: "Sofia"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22 ),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 1 )),
                              suffixIconConstraints: const BoxConstraints(
                                maxHeight: 24 ,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    lockPressed();
                                  },
                                  child: getPaddingWidget(
                                    const EdgeInsets.only(right: 18 ),
                                    getSvgImage("show.svg".toString(),
                                        width: 24 , height: 24 ),
                                  )),
                              prefixIconConstraints: const BoxConstraints(
                                maxHeight: 12 ,
                              ),
                              hintText: "Admin",
                            ),
                            obscureText: offsecureText,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              setState(() {
                                pass = value;
                              });
                            },
                          ),
                        const SizedBox(height: 50.0,),
                          RoundedLoadingButton(
                            animateOnTap: true,
                            successColor: accentColor,
                            controller: _btnController,
                            onPressed: login,
                            width: MediaQuery.of(context).size.width * 1.0,
                            color: accentColor.withOpacity(0.9),
                            elevation: 0,
                            child: const Wrap(
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          
                          
              
                    ],
                  ),
                ),
              
              ],
            ),
          )),
        )
        );
  
  }
}
