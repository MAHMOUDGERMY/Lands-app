import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';

import '../widgets.dart';

class Lands extends StatefulWidget {
  const Lands({Key? key}) : super(key: key);

  @override
  State<Lands> createState() => _LandsState();
}

class _LandsState extends State<Lands> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCubit, StatesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var data;
        if (StateCubit.get(context).isFilterd) {
          data = StateCubit.get(context).filterData;
        } else {
          data = StateCubit.get(context).landsData;
        }

        return state is GetLandsLoadingState
            ? const Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              StateCubit.get(context).removeFilter();
                            },
                            icon: Icon(Icons.cancel)),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: "الشمال",
                                child: Text("الشمال"),
                              ),
                               PopupMenuItem(
                                value: "غزة",
                                child: Text("غزة"),
                              ),
                              PopupMenuItem(
                                value: "خانيونس",
                                child: Text("خانيونس"),
                              ),
                               PopupMenuItem(
                                value: "الوسطى",
                                child: Text("الوسطى"),
                              ),
                              
                              PopupMenuItem(
                                value: "رفح",
                                child: Text("رفح"),
                              ),
                            ];
                          },
                          onCanceled: () {
                            print("cenceld");
                          },
                          onSelected: (value) {
                            StateCubit.get(context).filterPlace(
                                key: "place", value: value.toString());
                            print(value);
                          },
                          child: Text(
                            "المدينة",
                            style: TextStyle(
                                color: StateCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: "1000",
                                child: Text("اقل من 1000"),
                              ),
                              PopupMenuItem(
                                value: "5000",
                                child: Text("اقل من 5000"),
                              ),
                              PopupMenuItem(
                                value: "5000+",
                                child: Text("اكثر من 5000"),
                              ),
                            ];
                          },
                          onCanceled: () {
                            print("cenceld");
                          },
                          onSelected: (value) {
                            print(value.toString());
                            if (value == "5000+") {
                              StateCubit.get(context).filterPriceAndSpaceMore(
                                  key: "space", value: "5000");
                            } else {
                              StateCubit.get(context).filterPriceAndSpace(
                                  key: "space", value: "5000");
                            }
                          },
                          child: Text(
                            "المساحة",
                            style: TextStyle(
                                color: StateCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: "1000",
                                child: Text("اقل من 1000"),
                              ),
                              PopupMenuItem(
                                value: "5000",
                                child: Text("اقل من 5000"),
                              ),
                              PopupMenuItem(
                                value: "5000+",
                                child: Text("اكثر من 5000"),
                              ),
                            ];
                          },
                          onCanceled: () {},
                          onSelected: (value) {
                            if (value == "5000+") {
                              StateCubit.get(context).filterPriceAndSpaceMore(
                                  key: "price", value: "5000");
                            } else {
                              StateCubit.get(context).filterPriceAndSpace(
                                  key: "price", value: value.toString());
                            }
                          },
                          child: Text(
                            "السعر",
                            style: TextStyle(
                                color: StateCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    data.length != 0
                        ? Expanded(
                            child: ListView.separated(
                                // physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                                itemCount: data.length,
                                separatorBuilder: (c, i) => const SizedBox(
                                      height: 20,
                                    ),
                                itemBuilder: (context, index) => Item(
                                      data: data[index],
                                      my: false,
                                      index: index,
                                    )),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView(
                              children:  [
                                Center(
                                  child: Text("لا يوجد بيانات",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: StateCubit.get(context).isDark?Colors.white:Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              );
      },
    );
  }
}
