import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:states/network/cache_helper.dart';
import 'package:states/views/Signup.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover)),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Buying and selling land",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                  CacheHelper.putData(key: "splash", value: true);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor("#CC016B"),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: const Center(
                        child: Text(
                      "EXPLORE NOW",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
