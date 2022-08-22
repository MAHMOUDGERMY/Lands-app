import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/components.dart';
import 'package:states/views/info.dart';

class Item extends StatefulWidget {
  final Map data;
  final bool my;
  final int index;

  const Item({required this.data, required this.my, required this.index});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.data["title"]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Info(
                      data: widget.data,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 20,
          shadowColor: StateCubit.get(context).isDark
              ? Color.fromARGB(255, 188, 183, 183)
              : Colors.black,
          child: Column(
            children: [
           if(widget.my)   Row(
             children: [
               IconButton(onPressed: (){
                StateCubit.get(context).removeLand(widget.index, widget.data["id"]);

                  }, icon:const Icon(Icons.delete , color: Colors.red,)),
             ],
           ),
              widget.data["images"].length > 0
                  ? Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.data["images"][0]),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        
                    ],
                  )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data["title"],
                
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      ' متر ${widget.data["space"]} ',
                      style: TextStyle(
                          fontSize: 15,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.area_chart,
                      color: StateCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                    const Spacer(),
                    Text(
                      widget.data["place"],
                      style: TextStyle(
                          fontSize: 15,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.location_city,
                      color: StateCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
