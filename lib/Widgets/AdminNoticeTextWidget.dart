import 'package:club_app/Utilities/BottonStyle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMovingNoticeText extends StatefulWidget {
  @override
  _AdminMovingNoticeTextState createState() => _AdminMovingNoticeTextState();
}

class _AdminMovingNoticeTextState extends State<AdminMovingNoticeText>
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

  void _showEditBottomSheet(BuildContext context) {
    _editController.text = noticeText;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to resize with the keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Adds padding based on keyboard height
          ),
          child: SingleChildScrollView( // Allows content to scroll when keyboard appears
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Edit Notice Text',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButtonStyle(text: 'Save', onPressed: () async {
                  final newText = _editController.text.trim();
                  if (newText.isNotEmpty) {
                    await updateNoticeText(newText);
                    Navigator.pop(context);
                  }
                },)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        // Moving Text
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.only(top: 0),
            alignment: Alignment.centerLeft,
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
        ),
        // Edit Button
        Positioned(
          right: 10,
          child: IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _showEditBottomSheet(context),
          ),
        ),
      ],
    );
  }
}
