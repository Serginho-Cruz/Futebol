import 'package:flutter/material.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> rotate;
  late final Animation<double> width;
  late final Animation<double> opacityText;
  late final Animation<double> opacityIcon;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    rotate = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8),
      ),
    );

    width = Tween(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    opacityIcon = Tween(begin: 0.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0),
      ),
    );

    opacityText = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        if (_controller.isCompleted) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pushReplacementNamed('/home');
          });
        }

        _controller.forward();
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: screenSize.height * 0.4,
                right: screenSize.width * width.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi * rotate.value),
                  child: Opacity(
                    opacity: opacityIcon.value,
                    child: const Icon(
                      Icons.star_rounded,
                      color: Colors.yellow,
                      size: 150,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height * 0.6,
                child: Opacity(
                  opacity: opacityText.value,
                  child: const Text(
                    "Simulador 2022",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 34,
                      decoration: TextDecoration.none,
                      letterSpacing: 2.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
