

import 'package:firebase/ui/auth/signup_screen.dart';
import 'package:firebase/widgets/Round_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Login")
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                      decoration: const InputDecoration(

                        hintText: "e-mail",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter E-mail";
                      }
                      else return null;
                    },
                  ),

                  const SizedBox(height: 10,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter password";
                      }
                      else return null;
                    },
                  ),

                ],
              ),

            ),

            SizedBox(height: 45,),

            RoundButton(title: "Login", onTap: (){
              if(_formKey.currentState!.validate()){
                if(_auth.currentUser != null)
                  {
                    print("Log in successfull");
                  }
              }
            }),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                }, child: Text("Sign up")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
