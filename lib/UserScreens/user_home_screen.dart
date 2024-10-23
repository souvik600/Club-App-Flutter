import 'package:club_app/AppColors/AppColors.dart';
import 'package:club_app/UserScreens/splash_screen.dart';
import 'package:club_app/Utilities/BackgroundStyle.dart';
import 'package:club_app/Widgets/CatagoriListWidget.dart';
import 'package:club_app/Widgets/CustomDrawerWidget.dart';
import 'package:club_app/Widgets/ImageSlideShowWidget.dart';
import 'package:club_app/Widgets/NoticeTextWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Define a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,  // Assign the key to the Scaffold
        appBar: AppBar(
          backgroundColor: AppColors.pColor,
          title: const Text(
            "মানব কল্যাণ যুব সংঘ",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              fontFamily: 'kalpurush',
              color: colorWhite,
            ),

          ),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: colorWhite,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();  // Use the global key to open the drawer
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.privacy_tip_outlined,
                color: AppColors.wColor,
                size: 22,
              ),
              onPressed: () {
                // Add your notification handling logic here
              },
            ),
          ],
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ScreenBackground(context),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.pColor.withOpacity(0.8),
                                  AppColors.pColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: ImageSlideShow(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.pColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.wColor,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: MovingNoticeText()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "ক্যাটেগরি সমূহ...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'kalpurush',
                          color: AppColors.pColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/blood_doner.json",
                                  "ব্লাড ব্যাঙ্ক"),
                              const SizedBox(
                                width: 10,
                              ),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/news.json",
                                  "নিউজ ফিড"),
                              const SizedBox(
                                width: 10,
                              ),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/membar.json",
                                  "কমিটি সদস্য"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/call.json",
                                  "জরুরি সেবা"),
                              const SizedBox(
                                width: 10,
                              ),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/about.json",
                                  "সংঘ সম্পর্কে"),
                              const SizedBox(
                                width: 10,
                              ),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/comment.json",
                                  "আপনার মতামত"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: const Drawer(
          child: CustomDrawerWidget(),
        ),
      ),
    );
  }
}
