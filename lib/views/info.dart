import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jiffy/jiffy.dart';

import '../SM/cubit.dart';

class Info extends StatefulWidget {
  final Map? data;
  const Info({Key? key, this.data}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Map<String, dynamic>? author = {};
  
  

  @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) {
                    return Image.network(
                      widget.data!["images"][index],
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: widget.data!["images"].length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {},
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data!["title"]}',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: StateCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(Jiffy(widget.data!["date"]).fromNow(),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600)),
                    Text(
                      '${widget.data!["name"]}',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: StateCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${widget.data!["phone"]}',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: StateCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          ' متر ${widget.data!["space"]} ',
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
                        Spacer(),
                        Text(
                          widget.data!["price"],
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
                          Icons.price_change_outlined,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        Spacer(),
                        Text(
                          widget.data!["place"],
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text('${widget.data!["about"]}',
                        style: TextStyle(
                          fontSize: 15,
                          color: StateCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        )),
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
