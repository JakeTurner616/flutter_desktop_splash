
# flutter_desktop_splash

`flutter_desktop_splash` is a customizable splash screen widget for Flutter desktop applications, allowing you to configure logos, background colors, animations, and optional loading text.

![](docs/flutter_desktop_splash.gif?raw=true)

## Reasoning
Easily manage the launch screen of apps the target windows, macos, and linux as splash screen support must be done at the application level after flutter init: [https://github.com/flutter/flutter/issues/41980](https://github.com/flutter/flutter/issues/41980)

## Usage

```dart
DesktopSplashScreen(
  logo: Image.asset(
    'assets/logo.png',
    width: 250,       // Width of the logo
    height: 250,      // Height of the logo
  ),
  backgroundColor: Colors.deepPurple, // Splash screen background color
  duration: Duration(seconds: 5),     // Duration to display the splash screen
  
  // Callback after splash duration completes
  onInitializationComplete: () {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  },

  // Custom loading animation
  loadingIndicator: LoadingIndicator(
    indicatorType: Indicator.ballPulse,
    colors: [Colors.orange, Colors.yellow, Colors.red],
    strokeWidth: 2,
  ),
  
  // Optional loading text below the animation
  loadingText: 'Preparing your experience...',
)
```

### Parameters

- **`logo`**: Custom logo widget to display in the center.
- **`backgroundColor`**: Background color for the splash screen.
- **`duration`**: Duration the splash screen is shown.
- **`onInitializationComplete`**: Callback to transition to the main app.
- **`loadingIndicator`**: Customizable loading animation from `loading_indicator`.
- **`loadingText`**: Optional message shown below the loading indicator.



## Platform-Specific Check

By default this package will work on all platforms. Simply add a platform conditional to target desktop platforms (Windows, macOS, and Linux) for the `DesktopSplashScreen` Widget to keep mobile splash screens independent:

```dart
import 'dart:io' show Platform; // Add this to run platform conditionals
import 'package:flutter/material.dart';
import 'package:flutter_desktop_splash/flutter_desktop_splash.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform-Aware Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Platform.isWindows || Platform.isMacOS || Platform.isLinux // Platform conditions are user dependent
          ? DesktopSplashScreen(
              logo: Image.asset('assets/logo.png', width: 250, height: 250),
              backgroundColor: Colors.deepPurple,
              duration: Duration(seconds: 5),
              onInitializationComplete: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              loadingIndicator: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Colors.orange, Colors.yellow, Colors.red],
                strokeWidth: 2,
              ),
              loadingText: 'Preparing your experience...',
            )
          : HomePage(), // skip for non-desktop platforms
    );
  }
}


```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/JakeTurner616/flutter_desktop_splash/blob/main/LICENSE) file for details.
