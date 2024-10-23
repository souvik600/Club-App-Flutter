import 'package:flutter/material.dart';

class MovingNoticeText extends StatefulWidget {
  @override
  _MovingNoticeTextState createState() => _MovingNoticeTextState();
}

class _MovingNoticeTextState extends State<MovingNoticeText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat(reverse: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    _animation = Tween<double>(
      begin: screenWidth,
      end: -2000, // To ensure the text fully moves off the screen
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Reset animation to start from the right after reaching the left edge
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: _animation.value,
            child: Text(
            'নড়াইল বাসিকে স্বাগতম।🤗 আপনাদের অনলাইন সেবা কে হাতের মুঠোয় করার জন্য আমাদের এই ক্ষুদ্র প্রচেষ্টা। আশা করি সবাই আপনার প্রয়োজনীয় '
                ' মতামত দিয়ে আপনার সেবার মানতে উন্নত করার লক্ষ্যে সহায়তা করবেন। ধন্যবাদ।👏',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'kalpurush', color:Colors.red.shade900),
            ),
          ),
        ],
      ),
    );
  }
}