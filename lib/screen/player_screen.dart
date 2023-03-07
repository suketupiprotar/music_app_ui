import 'package:flutter/material.dart';
import 'package:music_app/constant/app_color.dart';
import 'package:music_app/model/music_model.dart';
import 'package:music_app/screen/player_list_screen.dart';
import 'package:music_app/widget/neumorphism_button.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currItemPlaying = 0;
  double _currPlayback = 0;

  String formatePlayerTime(double time) {
    final min = time ~/ 60;
    final sec = time % 60;
    return "$min:${sec.toStringAsFixed(0).padRight(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphismBtn(
                    size: 60,
                    child: Icon(
                      musicList[_currItemPlaying].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Text(
                    "Playing Now".toUpperCase(),
                    style: TextStyle(
                      color: AppColor.secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  NeumorphismBtn(
                    size: 60,
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                    onPressed: () async {
                      int selectedIndex = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerListScreen(
                            selectedIndex: _currItemPlaying,
                          ),
                        ),
                      );
                      setState(() {
                        _currItemPlaying = selectedIndex;
                      });
                    },
                  ),
                ],
              ),
              NeumorphismBtn(
                size: size.width * 0.8,
                distance: 20,
                padding: 10,
                imageUrl: musicList[_currItemPlaying].imageUrl,
              ),
              Column(
                children: [
                  Text(
                    musicList[_currItemPlaying].name,
                    style: TextStyle(
                      color: AppColor.primaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    musicList[_currItemPlaying].artist,
                    style: TextStyle(
                      color: AppColor.secondaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatePlayerTime(_currPlayback),
                          style: TextStyle(
                            color: AppColor.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          formatePlayerTime(musicList[_currItemPlaying].length),
                          style: TextStyle(
                            color: AppColor.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: _currPlayback,
                    max: musicList[_currItemPlaying].length,
                    thumbColor: AppColor.blue,
                    activeColor: AppColor.blue,
                    inactiveColor: AppColor.bgDark,
                    onChanged: (value) {
                      setState(() {
                        _currPlayback = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphismBtn(
                    onPressed: () {
                      if (_currItemPlaying > 0)
                        setState(() {
                          _currItemPlaying--;
                        });
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_previous_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  ),
                  NeumorphismBtn(
                    size: 80,
                    colors: [
                      AppColor.blueTopDark,
                      AppColor.blue,
                    ],
                    child: Icon(
                      Icons.pause_rounded,
                      color: AppColor.white,
                      size: 35,
                    ),
                  ),
                  NeumorphismBtn(
                    onPressed: () {
                      if (_currItemPlaying < musicList.length - 1)
                        setState(() {
                          _currItemPlaying++;
                        });
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_next_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
