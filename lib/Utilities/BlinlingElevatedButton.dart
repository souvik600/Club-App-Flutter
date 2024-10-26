import 'package:flutter/material.dart';

class BlinkingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration blinkDuration;
  final bool enabled;

  const BlinkingButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.blinkDuration = const Duration(milliseconds: 50),
    this.enabled = true,
  }) : super(key: key);

  @override
  _BlinkingButtonState createState() => _BlinkingButtonState();
}

class _BlinkingButtonState extends State<BlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.blinkDuration,
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
            return _colorAnimation.value;
          },
        ),
        elevation: MaterialStateProperty.all<double>(8),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: widget.enabled ? widget.onPressed : null,
      child: widget.child,
    );
  }
}

