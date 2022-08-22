import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';
import 'package:states/network/cache_helper.dart';
import 'package:states/views/Signup.dart';

class AddLand extends StatefulWidget {
  AddLand({Key? key}) : super(key: key);

  @override
  State<AddLand> createState() => _AddLandState();
}

class _AddLandState extends State<AddLand> {
  TextEditingController aboutCont = TextEditingController();

  TextEditingController spaceCont = TextEditingController();

  TextEditingController priceCont = TextEditingController();

  TextEditingController placeCont = TextEditingController();

  TextEditingController titleCont = TextEditingController();

  TextEditingController nameCont = TextEditingController();

  TextEditingController phoneCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  XFile? photo;

  @override
  Widget build(BuildContext context) {
    var userData = StateCubit.get(context).userData;
    nameCont.text = userData!["name"] ?? "";
    phoneCont.text = userData["phone"] ?? CacheHelper.getDataString(key: "phone")??"";
    return BlocConsumer<StateCubit, StatesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Add Land"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is AddLandLoadingState)
                      const LinearProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.red,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (StateCubit.get(context).LandImagesPath.isNotEmpty)
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                StateCubit.get(context).LandImagesPath.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 300,
                                width: 200,
                                child: Image.file(
                                  File(
                                      "${StateCubit.get(context).LandImagesPath[index]}"),
                                  fit: BoxFit.contain,
                                ),
                              );
                            }),
                      ),
                    TextButton(
                      onPressed: () async {
                        StateCubit.get(context).getLandImageImage();
                      },
                      child: const Text(
                        "Add Images",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Title must not be Empty";
                        }
                        if (value.length < 15) {
                          return "Title must not be less than 15";
                        }
                      },
                      controller: titleCont,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: StateCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "Title",
                          prefixIcon: Icon(
                            Icons.title,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
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
                          return "name must not be Empty";
                        }
                        if (value.length < 5) {
                          return "name must not be less than 5";
                        }
                      },
                      controller: nameCont,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: StateCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
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
                          return "phone must not be Empty";
                        }
                        if (value.length != 10) {
                          return "phone must not be less than 10";
                        }
                      },
                      controller: phoneCont,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: StateCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "phone",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
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
                          return "Price must not be Empty";
                        }
                        if (value.length < 2) {
                          return "Price must not be less than 2";
                        }
                      },
                      controller: priceCont,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "Price",
                          prefixIcon: Icon(
                            Icons.price_change,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
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
                          return "Space must not be Empty";
                        }
                        if (value.length < 2) {
                          return "Space must not be less than 2";
                        }
                      },
                      controller: spaceCont,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "space",
                          prefixIcon: Icon(
                            Icons.space_bar,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
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
                          return "place must not be Empty";
                        }
                        if (value.length < 3) {
                          return "place must not be less than 3";
                        }
                      },
                      controller: placeCont,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          filled: true,
                          hintText: "place",
                          prefixIcon: Icon(
                            Icons.place,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "about must not be Empty";
                        }
                        if (value.length < 8) {
                          return "about must not be less than 8";
                        }
                      },
                      controller: aboutCont,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      style: TextStyle(
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      enableIMEPersonalizedLearning: true,
                      obscureText: false,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: StateCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1)),
                          prefixIconColor: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          filled: true,
                          hintText: "about",
                          hintStyle: TextStyle(
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.article,
                            color: StateCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          if (StateCubit.get(context).LandImagesPath.length >
                              0) {
                            StateCubit.get(context).uploadImages(
                              title: titleCont.text,
                              space: spaceCont.text,
                              price: priceCont.text,
                              about: aboutCont.text,
                              place: placeCont.text,
                              name: nameCont.text,
                              phone: phoneCont.text,
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "please add any image",
                                backgroundColor: Colors.yellow);
                          }
                        }
                      },
                      child: state is AddLandLoadingState
                          ? CircularProgressIndicator()
                          : Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: HexColor("#CC016B"),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              child: const Center(
                                  child: Text(
                                "Add Land",
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
