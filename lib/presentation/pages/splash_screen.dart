import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late AnimationController scaleController;
  late AnimationController rotationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeIn),
    );

    // Scale animation
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: scaleController,
        curve: Curves.elasticOut,
      ),
    );

    // Rotation animation for cloud
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: rotationController, curve: Curves.easeInOut),
    );

    // Start animations
    fadeController.forward();
    scaleController.forward();
    rotationController.repeat(reverse: true);

    // Navigate to home screen after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.off(() => const HomeScreen());
      }
    });
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Weather Icon with pulsing effect
                  AnimatedBuilder(
                    animation: scaleController,
                    builder: (context, child) {
                      return Container(
                        width: 120 + (scaleController.value * 20),
                        height: 120 + (scaleController.value * 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.2 - (scaleController.value * 0.1),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: RotationTransition(
                          turns: rotationAnimation,
                          child: const Icon(
                            Icons.wb_sunny,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  // App Name with fade animation
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: const Text(
                      'Weather App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle with delay
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeIn,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: const Text(
                          'Loading your weather...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                  // Loading indicator
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
