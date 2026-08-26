# 🐐 Goat YouTube Player for Flutter

A highly customizable, powerful, and easy-to-use YouTube player for Flutter. **Goat YouTube Player** provides a seamless video playback experience in your application, empowering developers to integrate YouTube videos effortlessly. 

## ✨ Features

- **🚀 Plug and Play:** Set up the player with just a few lines of code. No complex configuration is required.
- **📱 Fully Responsive:** Adapts flawlessly across different screen sizes and orientations.
- **🎮 Custom Controller:** Complete programmatic control over the playback state (Play, Pause, Load Video, etc.).
- **⚡ High Performance:** Optimized for smooth and seamless video streaming.
- **🎨 Highly Customizable:** Flexible enough to fit your app's unique design and behavior requirements.

## 🎯 What is it for?

Whether you are building an educational platform, a media app, or simply want to embed a YouTube tutorial within your application, **Goat YouTube Player** gives you a robust and lightweight solution. It abstracts away all the complexity of video embedding so you can focus on building a great user experience.

## 📦 Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  goat_yt_player_flutter: ^0.0.1
```

Then, run:
```bash
flutter pub get
```

## 🛠️ Usage

Using the player is incredibly simple. Just initialize a controller with your desired YouTube video ID and pass it to the player widget!

```dart
import 'package:flutter/material.dart';
import 'package:goat_yt_player_flutter/goat_yt_player_flutter.dart';

class MyVideoScreen extends StatefulWidget {
  const MyVideoScreen({Key? key}) : super(key: key);

  @override
  State<MyVideoScreen> createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen> {
  late GoatYtPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with a YouTube Video ID
    _controller = GoatYtPlayerController(
      initialVideoId: 'iLnmTe5Q2Qw', // Replace with your video ID
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goat YouTube Player'),
      ),
      body: Center(
        child: GoatYtPlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
```

## 🔗 Additional information

If you encounter any issues or want to contribute to the project, feel free to visit the GitHub repository.

- **Repository:** [goat-yt-player-flutter](https://github.com/Amar-singh-123/goat-yt-player-flutter)
- **Bugs/Feature Requests:** Please file an issue on our [GitHub Issue Tracker](https://github.com/Amar-singh-123/goat-yt-player-flutter/issues).

We welcome contributions and feedback to make this the *Greatest Of All Time* YouTube player for Flutter! 🐐
