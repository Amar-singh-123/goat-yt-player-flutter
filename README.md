# 🐐 Goat YouTube Player for Flutter

A highly customizable, powerful, and easy-to-use YouTube player for Flutter. **Goat YouTube Player** provides a seamless video playback experience in your application, empowering developers to integrate YouTube videos effortlessly. 

## 🏆 Why Goat YouTube Player?

| Feature | Description |
| :--- | :--- |
| **🚀 Plug & Play** | Drop the widget in, pass a video ID, and you're good to go. |
| **🎮 Programmatic Control** | Full API to play, pause, seek, and switch videos dynamically. |
| **📱 Responsive Design** | Adapts perfectly to portrait, landscape, and tablets. |
| **⚡ High Performance** | Highly optimized rendering with minimal overhead. |
| **🎨 Customizable** | Easy to tweak UI/UX to match your app's theme. |
| **🛡️ Safe & Secure** | Follows best practices for embedding third-party content securely. |

## 🌍 Platform Support

This package ensures a reliable viewing experience across major platforms:

| Platform | Supported |
| :--- | :---: |
| 🤖 **Android** | ✅ |
| 🍎 **iOS** | ✅ |
| 🌐 **Web** | ✅ |
| 💻 **macOS** | ✅ |
| 🪟 **Windows** | 🚧 *Coming Soon* |
| 🐧 **Linux** | 🚧 *Coming Soon* |

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
          // Customizing the player is easy!
          autoplay: true,
          mute: true,
          showControls: true,
          accentColor: 'FF0000', // Make the UI red
        ),
      ),
    );
  }
}
```

## 🎨 Customization & Properties

**GoatYtPlayer** comes packed with customizable parameters to tailor the player exactly to your needs.

### 🎛️ Player Options

| Parameter | Type | Default | Description |
| :--- | :---: | :---: | :--- |
| `autoplay` | `bool` | `false` | Automatically starts the video when loaded. |
| `mute` | `bool` | `false` | Starts the video muted. |
| `loop` | `bool` | `false` | Loops the video playback indefinitely. |
| `start` | `int` | `0` | Starts the video at a specific time (in seconds). |
| `end` | `int?` | `null` | Stops the video at a specific time (in seconds). |
| `aspectRatio` | `double` | `16/9` | The aspect ratio of the player widget. |

### 🖌️ UI Controls & Theming

| Parameter | Type | Default | Description |
| :--- | :---: | :---: | :--- |
| `showControls` | `bool` | `true` | Shows or hides the entire control bar. |
| `accentColor` | `String?` | `null` | HEX color string (e.g., `FF0000`) for the player's primary accents. |
| `autohide` | `int` | `3000` | Time in ms before controls automatically hide on inactivity. |
| `showSeek` | `bool` | `true` | Shows the seek bar slider. |
| `showVolume` | `bool` | `true` | Shows the volume control button. |
| `showFullscreen` | `bool` | `true` | Shows the fullscreen toggle button. |
| `showQuality` | `bool` | `true` | Shows the video quality selector. |
| `showSpeed` | `bool` | `true` | Shows the playback speed selector. |

*(For advanced usage, you can also inject Callbacks like `onReady`, `onStateChange`, `onProgress`, `onVolumeChange`, and more!)*

## 🔗 Additional information

If you encounter any issues or want to contribute to the project, feel free to visit the GitHub repository.

- **Repository:** [goat-yt-player-flutter](https://github.com/Amar-singh-123/goat-yt-player-flutter)
- **Bugs/Feature Requests:** Please file an issue on our [GitHub Issue Tracker](https://github.com/Amar-singh-123/goat-yt-player-flutter/issues).

We welcome contributions and feedback to make this the *Greatest Of All Time* YouTube player for Flutter! 🐐
