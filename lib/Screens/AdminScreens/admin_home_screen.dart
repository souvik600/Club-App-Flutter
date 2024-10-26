
import 'package:club_app/Screens/UserScreens/user_profile_screen.dart';
import 'package:club_app/Screens/splash_screen.dart';
import 'package:club_app/Widgets/AdminNoticeTextWidget.dart';
import 'package:club_app/Widgets/NoticeTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/AppColors/AppColors.dart';
import 'package:club_app/Utilities/BackgroundStyle.dart';
import 'package:club_app/Widgets/CatagoriListWidget.dart';
import 'package:club_app/Widgets/CustomDrawerWidget.dart';
import 'package:club_app/Widgets/ImageSlideShowWidget.dart';// Assuming you have this widget

class AdminHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String profileImageUrl = '';

    // Fetch the user's profile image URL from Firestore
    Future<void> _loadProfileImage() async {
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          profileImageUrl = userDoc['avatar_url'] ?? ''; // Get the avatar URL
        }
      }
    }

    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.pColor,
          title: const Text(
            "Admin",
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
              color: AppColors.wColor,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            // Profile Image Button
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: FutureBuilder(
                future: _loadProfileImage(),
                builder: (context, snapshot) {
                  // Show loading indicator while fetching the image
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : const AssetImage('assets/images/default_profile.png')
                      as ImageProvider,
                    ),
                  );
                },
              ),
            ),
          ],
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: 70,
        ),
        body: Stack(
          children: [
            ScreenBackground(context),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
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
                              child: Center(child: AdminMovingNoticeText()),
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
                              const SizedBox(width: 10),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/news.json",
                                  "নিউজ ফিড"),
                              const SizedBox(width: 10),
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
                          const SizedBox(height: 20),
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
                              const SizedBox(width: 10),
                              CatagoriList(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ),
                                );
                              }, "assets/lotti_animation/about.json",
                                  "সংঘ সম্পর্কে"),
                              const SizedBox(width: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 2,),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Follow Our Facebook Page.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'kalpurush',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 2), // Add some space between text and icon
                              TextButton.icon(
                                icon: Icon(
                                  Icons.facebook,
                                  color: Colors.blueAccent.shade700,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _launchURL('https://www.facebook.com/profile.php?id=61555683684753');
                                }, label: const Text("Facebook",style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'kalpurush',
                                fontSize: 16,
                              ),),
                              ),
                            ],
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                    )
                
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: const Drawer(
          child: CustomDrawerWidget(),
        ),
      ),
    );
  }
}
