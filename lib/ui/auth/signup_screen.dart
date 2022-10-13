

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/Round_Button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignUpScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  //dispose all controller
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  //All widget are inside this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Sign up")
      ),
      //Body of the page
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //Input Section
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

                  const SizedBox(height: 10,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      hintText: "Confirm password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty || value!=passwordController.text){
                        return "Confirm password";
                      }
                      else return null;
                    },
                  ),

                ],
              ),

            ),

            SizedBox(height: 45,),

            //SignUp Button
            RoundButton(title: "Signup", loading: loading, onTap: (){
              setState(() {
                loading = true;
              });
              if(_formKey.currentState!.validate()){
                _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value)
                {

                  FirebaseFirestore.instance.collection("users").doc(value.user?.uid).set(
                      {"email":value.user?.email});
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  utils().toastMessage(error.toString());
                });
              }
              else{
                 setState(() {
                   loading = false;
                });
              }


            }),

            //Back to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text("Login")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
