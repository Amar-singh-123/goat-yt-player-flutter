import 'package:flutter/material.dart';
import 'package:goat_yt_player_flutter/goat_yt_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goat YT Player Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoatYtPlayerController _controller = GoatYtPlayerController();

  String _playerState = 'unstarted';
  double _currentTime = 0;
  double _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goat YT Player'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Using a sample hosted player URL. 
            // In a real app, you would host the HTML folder (goat-yt-web-payer) on Vercel/Netlify.
            // Assuming we hosted it at https://goat-yt-web-player.vercel.app/
            GoatYtPlayer(
              videoId: 'dQw4w9WgXcQ', // Never gonna give you up
              // You must replace this URL with the actual hosted URL of the HTML player you created.
              // For demonstration purposes, we will assume it's hosted locally or on a test domain.
              hostedPlayerUrl: 'https://goat-yt-web-player.vercel.app/', 
              controller: _controller,
              showControls: true,
              autoplay: false,
              mute: false,
              onStateChange: (state) {
                setState(() => _playerState = state);
              },
              onProgress: (currentTime, duration, buffered) {
                setState(() {
                  _currentTime = currentTime;
                  _duration = duration;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('State: $_playerState'),
                  Text('Progress: ${_currentTime.toStringAsFixed(1)}s / ${_duration.toStringAsFixed(1)}s'),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () => _controller.play(),
                        child: const Text('Play'),
                      ),
                      ElevatedButton(
                        onPressed: () => _controller.pause(),
                        child: const Text('Pause'),
                      ),
                      ElevatedButton(
                        onPressed: () => _controller.seek(_currentTime + 10),
                        child: const Text('Forward 10s'),
                      ),
                      ElevatedButton(
                        onPressed: () => _controller.mute(),
                        child: const Text('Mute'),
                      ),
                      ElevatedButton(
                        onPressed: () => _controller.unmute(),
                        child: const Text('Unmute'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
