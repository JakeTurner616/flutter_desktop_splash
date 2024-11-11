// lib/flutter_desktop_splash.dart

library flutter_desktop_splash;

import 'package:flutter/material.dart';

class DesktopSplashScreen extends StatefulWidget {
  final Widget logo;
  final Color backgroundColor;
  final Duration duration;
  final VoidCallback onInitializationComplete;
  final Widget? loadingIndicator;
  final String? loadingText; // Parameter for optional text

  const DesktopSplashScreen({
    Key? key,
    required this.logo,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(seconds: 3),
    required this.onInitializationComplete,
    this.loadingIndicator,
    this.loadingText, // Initialize the optional text
  }) : super(key: key);

  @override
  _DesktopSplashScreenState createState() => _DesktopSplashScreenState();
}

class _DesktopSplashScreenState extends State<DesktopSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the fade-out animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Start the splash screen timer
    _startSplash();
  }

  Future<void> _startSplash() async {
    // Display splash screen elements for the specified duration
    await Future.delayed(widget.duration);
    // Start the fade-out animation
    _controller.forward().then((_) {
      widget.onInitializationComplete(); // Complete the initialization
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          // Content that is always displayed
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.logo,
                const SizedBox(height: 20),
                // Ensure the loading indicator has size constraints
                SizedBox(
                  width: 100, // Set a max width
                  height: 100, // Set a max height
                  child: widget.loadingIndicator ?? CircularProgressIndicator(),
                ),
                if (widget.loadingText != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    widget.loadingText!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Fade-out overlay after duration
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(color: widget.backgroundColor),
          ),
        ],
      ),
    );
  }
}
