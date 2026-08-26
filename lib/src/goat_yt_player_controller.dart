import 'package:webview_flutter/webview_flutter.dart';

/// A controller to programmatically interact with the [GoatYtPlayer].
///
/// Use this controller to play, pause, seek, mute, and perform other actions on the player.
class GoatYtPlayerController {
  WebViewController? _webViewController;
  
  /// Whether the player is ready and attached to a WebViewController.
  bool get isReady => _webViewController != null;

  /// Attaches the WebViewController to this controller.
  /// Used internally by [GoatYtPlayer].
  void attach(WebViewController controller) {
    _webViewController = controller;
  }

  void _sendMessage(String command, [dynamic value]) {
    if (!isReady) return;
    
    // Execute JS to send a postMessage to the iframe/window
    final jsCommand = "window.postMessage({command: '$command', value: ${value != null ? "'$value'" : "null"}}, '*');";
    _webViewController!.runJavaScript(jsCommand);
  }

  /// Plays the current video.
  void play() => _sendMessage('play');
  
  /// Pauses the current video.
  void pause() => _sendMessage('pause');
  
  /// Seeks to a specified time in the video (in seconds).
  void seek(double seconds) => _sendMessage('seek', seconds);
  
  /// Mutes the video.
  void mute() => _sendMessage('mute');
  
  /// Unmutes the video.
  void unmute() => _sendMessage('unmute');
  
  /// Sets the volume of the player (0-100).
  void setVolume(int volume) => _sendMessage('setVolume', volume);
  
  /// Sets the playback rate (e.g., 1.0, 1.5, 2.0).
  void setPlaybackRate(double rate) => _sendMessage('setPlaybackRate', rate);
  
  /// Sets the video quality (e.g., 'small', 'medium', 'large', 'hd720', 'hd1080', 'highres').
  void setQuality(String quality) => _sendMessage('setQuality', quality);
  
  /// Loads a new YouTube video by its ID.
  void loadVideo(String videoIdOrUrl) => _sendMessage('loadVideo', videoIdOrUrl);
  
  /// Requests the player to enter fullscreen mode.
  void enterFullscreen() => _sendMessage('enterFullscreen');
  
  /// Requests the player to exit fullscreen mode.
  void exitFullscreen() => _sendMessage('exitFullscreen');
}
