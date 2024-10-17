import 'package:flutter/material.dart';

class MyExplicitAnimation extends StatefulWidget {
  @override
  _MyExplicitAnimationState createState() => _MyExplicitAnimationState();
}

class _MyExplicitAnimationState extends State<MyExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double screenWidth;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenWidth = MediaQuery.of(context).size.width;

    _animation =
        Tween<double>(begin: 0, end: screenWidth - 100).animate(_controller);
  }

  void toggleAnimation() {
    setState(() {
      if (_isAnimating) {
        _controller.stop();
      } else {
        if (_controller.status == AnimationStatus.reverse) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      }
      _isAnimating = !_isAnimating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Positioned(
                          left: _animation.value,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.amber,
                          ))
                    ],
                  );
                })),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
              onPressed: toggleAnimation,
              child: Text(_isAnimating ? 'Stop Animation' : 'Start Animation')),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
