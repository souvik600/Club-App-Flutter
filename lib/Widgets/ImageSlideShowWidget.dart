import 'dart:async';
import 'package:club_app/AppColors/AppColors.dart';
import 'package:flutter/material.dart';


class ImageSlideShow extends StatefulWidget {
  @override
  _ImageSlideShowState createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  int _currentPage = 0;
  final PageController _controller = PageController(initialPage: 0);

  final List<String> _imageAssetPaths = [
    'assets/images/ramnagorchair.jpg',
    'assets/images/ramnagorchair11.jpg',
    'assets/images/club.jpg',
    'assets/images/ramnagorchair4.jpg',
    'assets/images/ramnagorchair12.jpg',
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _imageAssetPaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 185,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)),
              child: PageView.builder(
                controller: _controller,
                itemCount: _imageAssetPaths.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      _imageAssetPaths[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _imageAssetPaths.length,
                (index) => buildDot(index, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 10.0,
      width: _currentPage == index ? 20.0 : 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.pColor : Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
