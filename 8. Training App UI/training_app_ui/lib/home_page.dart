// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app_ui/video_info.dart';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("json/info.json");
  }

  List info = [];

  @override
  void initState() {
    super.initState();
    _loadFromAsset().then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
          padding: const EdgeInsets.only(top: 65, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Training",
                      style: TextStyle(
                        fontSize: 30,
                        color: color.AppColor.homePageTitle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_back_ios,
                        size: 20, color: color.AppColor.homePageIcons),
                    const SizedBox(width: 10),
                    Icon(Icons.calendar_today_outlined,
                        size: 20, color: color.AppColor.homePageIcons),
                    const SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios,
                        size: 20, color: color.AppColor.homePageIcons),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Your Program",
                      style: TextStyle(
                        fontSize: 20,
                        color: color.AppColor.homePageSubtitle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text: "Details ",
                        style: TextStyle(
                          fontSize: 20,
                          color: color.AppColor.homePageDetail,
                        ),
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.arrow_forward,
                                size: 20, color: color.AppColor.homePageIcons),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.AppColor.gradientFirst.withOpacity(0.8),
                          color.AppColor.gradientSecond.withOpacity(0.9)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          color: color.AppColor.gradientSecond.withOpacity(0.2),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80),
                      )),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 25, right: 20, bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next workout",
                          style: TextStyle(
                            fontSize: 16,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Legs Toning",
                          style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                        ),
                        Text(
                          "and Glutes Workout",
                          style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: color
                                          .AppColor.homePageContainerTextSmall,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " 60 min",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: color
                                          .AppColor.homePageContainerTextSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.AppColor.gradientFirst,
                                      blurRadius: 10,
                                      offset: Offset(4, 8),
                                    )
                                  ]),
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 60,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  // color: Colors.green,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 40,
                              offset: Offset(8, 10),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3),
                            ),
                            BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(right: 200, bottom: 30),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/figure.png"),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 100,
                        margin: const EdgeInsets.only(
                            left: 140, top: 50, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Yo are doing great!",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color.AppColor.homePageDetail),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                  text: "Keep it up",
                                  style: TextStyle(
                                    color: color.AppColor.homePagePlanColor,
                                    fontSize: 16,
                                  ),
                                  children: const [
                                    TextSpan(text: "stick to your plan")
                                  ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Area of focus",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: color.AppColor.homePageTitle,
                  ),
                ),
                SizedBox(height: 15),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  crossAxisCount: 2,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 20.0,
                  children: info
                      .map((item) => TypeCard(
                          title: item["title"] ?? "",
                          imagePath: item["img"] ?? ""))
                      .toList(),
                )
                // Wrap(
                //   children: info
                //       .map((item) => TypeCard(
                //           title: item["title"] ?? "",
                //           imagePath: item["img"] ?? ""))
                //       .toList(),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TypeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  const TypeCard({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoInfo()),
        );
      },
      child: Container(
        // height: 100,
        // width: 200,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(5, 5),
              color: color.AppColor.gradientSecond.withOpacity(0.2),
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-5, -5),
              color: color.AppColor.gradientSecond.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(imagePath,
                width: MediaQuery.of(context).size.width / 2 * 0.5),
            const SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    fontSize: 16, color: color.AppColor.homePageDetail)),
          ],
        ),
      ),
    );
  }
}
