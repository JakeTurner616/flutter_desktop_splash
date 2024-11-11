import 'package:flutter/material.dart';
import 'package:flutter_desktop_splash/flutter_desktop_splash.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  runApp(MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop Splash Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Builder(
        builder: (context) => DesktopSplashScreen(
          // Display a custom logo image from assets
          logo: Image.asset(
            'assets/logo.png', // Path to the logo image in assets
            width: 300, // Set the logo width
            height: 300, // Set the logo height
          ),
          backgroundColor:
              Colors.blueAccent, // Background color for the splash screen
          duration:
              Duration(seconds: 6), // Duration to display the splash screen

          // Action to perform once the splash screen duration completes
          onInitializationComplete: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },

          // Custom loading indicator below the logo
          loadingIndicator: LoadingIndicator(
            indicatorType:
                Indicator.ballClipRotatePulse, // Choose animation type
            colors: [Colors.white], // Loading indicator colors
            strokeWidth: 3, // Stroke width for indicators with lines
          ),

          // Optional text displayed below the loading indicator
          loadingText: 'Loading, please wait...',
        ),
      ),
    );
  }
}

/// The main home page displayed after the splash screen completes.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
