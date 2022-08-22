import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';
import 'package:states/network/cache_helper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController emailCont = TextEditingController();

  TextEditingController passwordCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = StateCubit.get(context).userData;
    emailCont.text = data!["email"];
    nameCont.text = data["name"];
    phoneCont.text = data["phone"] ?? CacheHelper.getDataString(key: "phone")??'';

    return BlocConsumer<StateCubit, StatesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
                child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            return "name must not be Empty";
                          }
                          if (value.length < 3) {
                            return "name must not be less than 3";
                          }
                        },
                        controller: nameCont,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "name",
                            prefixIcon: Icon(Icons.lock,
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
                            return "phone must not be Empty";
                          }
                          if (value.length < 8) {
                            return "phone must not be less than 8";
                          }
                        },
                        controller: phoneCont,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "phone",
                            prefixIcon: Icon(Icons.phone,
                                color: StateCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is! UpdateUserSuccessState
                          ? InkWell(
                              onTap: () {
                                CacheHelper.putDataString(key: "phone", value : phoneCont.text );
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  StateCubit.get(context).update(
                                      email: emailCont.text,
                                      phone: phoneCont.text,
                                      name: nameCont.text);
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
                                  "تحديث",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        });
  }
}
