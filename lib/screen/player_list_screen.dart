import 'package:flutter/material.dart';
import 'package:music_app/constant/app_color.dart';
import 'package:music_app/model/music_model.dart';
import 'package:music_app/widget/neumorphism_button.dart';

class PlayerListScreen extends StatefulWidget {
  // const PlayerListScreen({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  PlayerListScreen({required this.selectedIndex});

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late int selectedIndex;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.selectedIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calculateScrollPossition(scrollController);
    });
    super.initState();
  }

  calculateScrollPossition(ScrollController scrollController) {
    int totallength = musicList.length;
    final macScroll = scrollController.position.maxScrollExtent;

    scrollController.animateTo(
      macScroll / totallength * selectedIndex,
      duration: Duration(milliseconds: 10),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Flume kai".toUpperCase(),
              style: TextStyle(
                color: AppColor.secondaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: size.height * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphismBtn(
                    onPressed: () {
                      Navigator.pop(context, selectedIndex);
                    },
                    size: 60,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  NeumorphismBtn(
                    size: size.width * 0.45,
                    distance: 20,
                    padding: 8,
                    imageUrl: musicList[selectedIndex].imageUrl,
                  ),
                  NeumorphismBtn(
                    size: 60,
                    child: Icon(
                      musicList[selectedIndex].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      decoration: selectedIndex == index
                          ? BoxDecoration(
                              color: AppColor.secondaryTextColor.withOpacity(
                                0.3,
                              ),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            )
                          : null,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicList[index].name,
                                style: TextStyle(
                                  color: AppColor.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                musicList[index].artist,
                                style: TextStyle(
                                  color: AppColor.secondaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          selectedIndex == index
                              ? NeumorphismBtn(
                                  size: 50,
                                  colors: [
                                    AppColor.blueTopDark,
                                    AppColor.blue,
                                  ],
                                  child: Icon(
                                    Icons.pause_rounded,
                                    color: AppColor.white,
                                  ),
                                )
                              : NeumorphismBtn(
                                  size: 50,
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColor.secondaryTextColor,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
