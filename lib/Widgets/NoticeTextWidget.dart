import 'package:club_app/Utilities/BottonStyle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovingNoticeText extends StatefulWidget {
  @override
  _MovingNoticeTextState createState() => _MovingNoticeTextState();
}

class _MovingNoticeTextState extends State<MovingNoticeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String noticeText = 'Loading...';
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat(reverse: false);
    fetchNoticeText();
  }

  Future<void> fetchNoticeText() async {
    try {
      final noticeDoc = await FirebaseFirestore.instance
          .collection('notices')
          .doc('notice1') // Adjust document ID as necessary
          .get();

      if (noticeDoc.exists) {
        setState(() {
          noticeText = noticeDoc['text'];
        });
      } else {
        print("Document does not exist in Firestore.");
      }
    } catch (e) {
      print("Error fetching notice text: $e");
    }
  }

  Future<void> updateNoticeText(String newText) async {
    try {
      await FirebaseFirestore.instance.collection('notices').doc('notice1').set(
          {'text': newText},
          SetOptions(merge: true)); // Merging updates the existing document

      print("Notice text updated successfully!");
      setState(() {
        noticeText = newText;
      });
    } catch (e) {
      print("Error updating notice text: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    _animation = Tween<double>(
      begin: screenWidth,
      end: -screenWidth, // Move entirely off screen
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _editController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        padding: EdgeInsets.only(left: 8,right: 8),
        alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 12,right: 12),
        child: Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Text(
            noticeText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'kalpurush',
              color: Colors.red.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
