import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';
import 'package:states/views/Signup.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCont = TextEditingController();

  TextEditingController passwordCont = TextEditingController();

  TextEditingController emailContrest = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCubit, StatesStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          StateCubit.get(context).getUserData();
          Fluttertoast.showToast(
              webPosition: "center",
              msg: "Login Successfully",
              backgroundColor: Colors.green);
          Navigator.of(context).pushReplacementNamed("home");
        } else if (state is LoginErrorState) {
          Fluttertoast.showToast(
              msg: state.error.toString(), backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Lottie.asset("assets/images/login.zip")),
                    Text(
                      "LOGIN",
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
                          return "Password must not be Empty";
                        }
                        if (value.length < 8) {
                          return "Password must not be less than 8";
                        }
                      },
                      controller: passwordCont,
                      obscureText: true,
                      decoration: InputDecoration(
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
                        Text(
                          "Have Account ?",
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
                                    builder: ((context) => SignUp())));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: HexColor("#CC016B")),
                          ),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextFormField(
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Email must not be Empty";
                                            }
                                            if (value.length < 8) {
                                              return "Email must not be less than 8";
                                            }
                                          },
                                          controller: emailContrest,
                                          decoration: const InputDecoration(
                                              filled: true,
                                              hintText:
                                                  "Enter your Email to reset password",
                                              prefixIcon: Icon(Icons.person)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (emailContrest.text.isNotEmpty) {
                                              StateCubit.get(context)
                                                  .resetPassword(
                                                      email:
                                                          emailContrest.text);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: HexColor("#CC016B"),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: const Center(
                                                child: Text(
                                              "Send Email",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Forget Password",
                        )),
                    InkWell(
                      onTap: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          StateCubit.get(context).login(
                              email: emailCont.text,
                              password: passwordCont.text);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: HexColor("#CC016B"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: const Center(
                            child: Text(
                          "LOGIN",
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
                              StateCubit.get(context).signInWithGoogle();
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
