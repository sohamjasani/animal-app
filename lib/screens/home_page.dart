import 'dart:typed_data';

import 'package:animal_app/global.dart';
import 'package:animal_app/helpers/images_api_helper.dart';
import 'package:animal_app/helpers/db_helper.dart';
import 'package:animal_app/modals/animal.dart';
import 'package:animal_app/widgets/app_bar.dart';
import 'package:animal_app/widgets/circuler_progress_indicator.dart';
import 'package:animal_app/widgets/options_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height * 0.38,
              color: Global.color.withOpacity(0.5),
              child: Stack(
                children: [
                  FutureBuilder(
                    future: ImageAPI.imageAPI.getImage(search: "wild animal"),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        Uint8List? image = snapShot.data;
                        return Image.memory(
                          height: height * 0.38,
                          width: double.infinity,
                          image!,
                          fit: BoxFit.cover,
                          color: Global.color.withOpacity(0.8),
                          colorBlendMode: BlendMode.modulate,
                        );
                      } else if (snapShot.hasError) {
                        return Center(child: Text("${snapShot.error}"));
                      } else {
                        return circularProgressIndicator();
                      }
                    },
                  ),
                  Container(
                    height: height * 0.38,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        appBar(),
                        const Spacer(),
                        Text(
                          "Welcome to\nNew Aplanet",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 43,
                            color: Colors.white.withOpacity(0.86),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(height: height * 0.015),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.63,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Global.color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    FutureBuilder(
                      future: DBHelper.dbHelper.fetchAllAnimalData(
                          tableName: "animalsData", data: Global.animalData),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          List<AnimalDB> res = snapShot.data!;
                          return SizedBox(
                            height: height * 0.38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: res.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.26,
                                        width: width * 0.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 3,
                                            )
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(res[i].image),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        res[i].name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        res[i].description,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapShot.hasError) {
                          return Center(child: Text("${snapShot.error}"));
                        } else {
                          return circularProgressIndicator();
                        }
                      },
                    ),
                    const Spacer(),
                    Text(
                      "Quick Categories",
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Global.category = "Elephant";
                            setState(() {});
                          },
                          child: optionsContainer(
                            name: "Elephant",
                            image: "elephant",
                            height: height,
                            width: width,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Global.category = "Lion";
                            setState(() {});
                          },
                          child: optionsContainer(
                            name: "Lion",
                            image: "lion",
                            height: height,
                            width: width,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Global.category = "Snake";
                            setState(() {});
                          },
                          child: optionsContainer(
                            name: "Snake",
                            image: "snake",
                            height: height,
                            width: width,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Global.category = "Dog";
                            setState(() {});
                          },
                          child: optionsContainer(
                            name: "Dog",
                            image: "dog",
                            height: height,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
