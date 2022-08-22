import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';
import 'package:states/views/Login.dart';
import 'package:states/views/Splash.dart';
import 'package:states/views/add.dart';

import '../widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    StateCubit cubit = StateCubit.get(context);

    return BlocConsumer<StateCubit, StatesStates>(listener: (context, state) {
      if (state is SignOutSuccess) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    }, builder: (context, state) {
      return Scaffold(
        drawer: StateCubit.get(context).userData != null
            ? Drawer(
                backgroundColor: StateCubit.get(context).isDark
                    ? HexColor("333739")
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            "${StateCubit.get(context).userData!["name"]}"),
                        onTap: () {},
                        leading: Icon(
                          Icons.person,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddLand()));
                        },
                        title: Text("Add Land"),
                        leading: Icon(
                          Icons.landscape,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text("LOGOUT"),
                        onTap: () {
                          StateCubit.get(context).logout();
                        },
                        leading: Icon(
                          Icons.logout,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            StateCubit.get(context).changeNavBar(index);
            print(index);
          },
          currentIndex: cubit.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.landscape), label: "MyLands"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                StateCubit.get(context).Mode();
              },
              icon: StateCubit.get(context).isDark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              color:
                  StateCubit.get(context).isDark ? Colors.yellow : Colors.black,
            )
          ],
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const Text(
            "الصفحة الرئيسية",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: StateCubit.get(context).userData != null
            ? RefreshIndicator(
                onRefresh: () async {
                  await StateCubit.get(context).getLands();
                   StateCubit.get(context).getMyLands();
                },
                child: cubit.pages[cubit.currentIndex])
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
