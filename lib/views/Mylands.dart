import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';

import '../widgets.dart';

class MyLands extends StatefulWidget {
  const MyLands({Key? key}) : super(key: key);

  @override
  State<MyLands> createState() => _MyLandsState();
}

class _MyLandsState extends State<MyLands> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCubit, StatesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var  data = StateCubit.get(context).myLands;
        

        return state is GetMyLandsLoadingState
            ? const Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    
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
                                      my: true,
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
