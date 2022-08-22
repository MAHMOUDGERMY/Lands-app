
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/views/Login.dart';
import 'package:states/views/terms.dart';

import '../SM/states.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCubit, StatesStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          StateCubit.get(context).getUserData();
          Fluttertoast.showToast(
              msg: "Register Success", backgroundColor: Colors.green);
          Navigator.of(context).pushReplacementNamed('home');
        }
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(
              msg: state.error.toString(), backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: Lottie.asset("assets/images/signup.zip")),
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Email must not be Empty";
                        }
                        if (value.length < 8) {
                          return "Email must not be less than 8";
                        }
                      },
                      controller: emailCont,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "EMAIL",
                          hintStyle: TextStyle(
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          prefixIcon: Icon(Icons.email,
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Name must not be Empty";
                        }
                        if (value.length < 5) {
                          return "Name must not be less than 5";
                        }
                      },
                      controller: nameCont,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "NAME",
                          hintStyle: TextStyle(
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          prefixIcon: Icon(Icons.person,
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone must not be Empty";
                        }

                        if (value.length < 10) {
                          return "Phone must not be less than 10";
                        }
                      },
                      controller: phoneCont,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "PHONE",
                          hintStyle: TextStyle(
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          prefixIcon: Icon(Icons.phone,
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Password must not be Empty";
                        }
                        if (value.length < 8) {
                          return "Password must not be less than 8";
                        }
                      },
                      controller: passwordCont,
                      obscureText: StateCubit.get(context).isVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                StateCubit.get(context).Visible();
                              },
                              icon: StateCubit.get(context).isVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: StateCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: StateCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                          filled: true,
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          prefixIcon: Icon(Icons.lock,
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: StateCubit.get(context).isChecked,
                          onChanged: (bool? value) {
                            StateCubit.get(context).changeCheck();
                          },
                        ),
                        TextButton(
                          child: const Text("terms and conditions"),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>const Terms(),));
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Do not have account ?",
                          style: TextStyle(
                              color: StateCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Login())));
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: HexColor("#CC016B")),
                          ),
                        )
                      ],
                    ),
                    state is RegisterLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              color: HexColor("#CC016B"),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                if (StateCubit.get(context).isChecked) {
                                  StateCubit.get(context).userRegister(
                                      email: emailCont.text,
                                      password: passwordCont.text,
                                      name: nameCont.text,
                                      phone: phoneCont.text);
                                } else {
                                  Fluttertoast.showToast(
                                      webPosition: "center",
                                      msg: "Please accept terms and conditions",
                                      backgroundColor: Colors.amber);
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: HexColor("#CC016B"),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              child: const Center(
                                  child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 50,
                            onPressed: () {
                              if (StateCubit.get(context).isChecked) {
                              StateCubit.get(context).signInWithGoogle();
                              }else{
                                Fluttertoast.showToast(
                                      webPosition: "center",
                                      msg: "Please accept terms and conditions",
                                      backgroundColor: Colors.amber);
                              }
                            },
                            icon: SvgPicture.asset("assets/images/goicon.svg"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
