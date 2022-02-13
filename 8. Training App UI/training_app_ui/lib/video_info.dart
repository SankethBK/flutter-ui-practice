// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("json/videoinfo.json");
  }

  List videoInfo = [];
  bool _playArea = false;
  // late VideoPlayerController _controller;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _loadFromAsset().then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
      // print(value);

      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      );

      _initializeVideoPlayerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.8),
                color.AppColor.gradientSecond,
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                height: !_playArea
                    ? 300
                    : MediaQuery.of(context).size.width * (9 / 16) + 5,
                child: !_playArea
                    ? topHero()
                    : Column(mainAxisAlignment: MainAxisAlignment.center,
                        // color: Colors.red,
                        children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      // If the VideoPlayerController has finished initialization, use
                                      // the data it provides to limit the aspect ratio of the video.
                                      return AspectRatio(
                                        aspectRatio: 16 / 9,

                                        // Use the VideoPlayer widget to display the video.
                                        child: VideoPlayer(_controller),
                                      );
                                    } else {
                                      // If the VideoPlayerController is still initializing, show a
                                      // loading spinner.
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                Positioned(
                                  top: 20,
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            size: 20,
                                            color: color
                                                .AppColor.secondPageIconColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.info_outline,
                                            size: 20,
                                            color: color
                                                .AppColor.secondPageIconColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                _controllerView(context),
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                      backgroundColor: Colors.red,
                                      bufferedColor: Colors.black,
                                      playedColor: Colors.blueAccent),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                          ]),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          // const SizedBox(width: 30),
                          Text(
                            "Circuit 1: Legs Toning",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color.AppColor.circuitsColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.loop,
                            size: 30,
                            color: color.AppColor.loopColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "3 sets",
                            style: TextStyle(
                                fontSize: 15, color: color.AppColor.setsColor),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: videoInfo.length,
                          itemBuilder: (_, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _playArea = true;
                                });
                                _onTapVideo(videoInfo[index]["videoUrl"]);
                              },
                              child: VideoCard(
                                videoInfo: videoInfo[index],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _controllerView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds - 10));
          },
          child: Icon(Icons.fast_rewind, size: 22, color: Colors.white),
        ),
        FlatButton(
          onPressed: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
              setState(() {});
            } else {
              // If the video is paused, play it.
              _controller.play();
              setState(() {});
            }
          },
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 22,
              color: Colors.white),
        ),
        FlatButton(
          onPressed: () {
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds + 10));
          },
          child: Icon(Icons.fast_forward, size: 22, color: Colors.white),
        ),
      ],
    );
  }

  _onTapVideo(String videoURL) {
    _controller.dispose();
    _controller = VideoPlayerController.network(videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
  }
}

class topHero extends StatelessWidget {
  const topHero({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,
                    size: 20, color: color.AppColor.secondPageIconColor),
              ),
              InkWell(
                child: Icon(Icons.info_outline,
                    size: 20, color: color.AppColor.secondPageIconColor),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            "Legs Toning",
            style: TextStyle(
              fontSize: 25,
              color: color.AppColor.secondPageTitleColor,
            ),
          ),
          Text(
            "and Glutes Workout",
            style: TextStyle(
              fontSize: 25,
              color: color.AppColor.secondPageTitleColor,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      color.AppColor.secondPageContainerGradient1stColor,
                      color.AppColor.secondPageContainerGradient2ndColor,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.timer,
                          size: 20,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      TextSpan(
                        text: " 60 min",
                        style: TextStyle(
                          fontSize: 14,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      color.AppColor.secondPageContainerGradient1stColor,
                      color.AppColor.secondPageContainerGradient2ndColor,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.handyman_outlined,
                          size: 20,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      TextSpan(
                        text: " Resistent Band, Kettebell",
                        style: TextStyle(
                          fontSize: 14,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Map<String, dynamic> videoInfo;

  const VideoCard({
    Key? key,
    required this.videoInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            minLeadingWidth: 0,
            leading: Image.asset(
              videoInfo["thumbnail"],
              width: 60,
              fit: BoxFit.fill,
            ),
            title: Text(
              videoInfo["title"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                videoInfo["time"],
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "15s rest",
                  style: TextStyle(color: Color(0xFF839fed)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DotWidget(
                    dashColor: Color(0xFF839fed),
                    dashHeight: 3,
                    dashWidth: 3,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final boxWidth = constraints.constrainWidth();
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          boxWidth ~/ (dashWidth + emptyWidth),
          (_) => Container(
            width: dashWidth,
            height: dashHeight,
            color: dashColor,
            margin:
                EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
          ),
        ),
      );
    });
  }
}
