import 'package:webview_flutter/webview_flutter.dart';

class GoatYtPlayerController {
  WebViewController? _webViewController;
  
  bool get isReady => _webViewController != null;

  void attach(WebViewController controller) {
    _webViewController = controller;
  }

  void _sendMessage(String command, [dynamic value]) {
    if (!isReady) return;
    
    // Execute JS to send a postMessage to the iframe/window
    final jsCommand = "window.postMessage({command: '$command', value: ${value != null ? "'$value'" : "null"}}, '*');";
    _webViewController!.runJavaScript(jsCommand);
  }

  void play() => _sendMessage('play');
  void pause() => _sendMessage('pause');
  void seek(double seconds) => _sendMessage('seek', seconds);
  void mute() => _sendMessage('mute');
  void unmute() => _sendMessage('unmute');
  void setVolume(int volume) => _sendMessage('setVolume', volume);
  void setPlaybackRate(double rate) => _sendMessage('setPlaybackRate', rate);
  void setQuality(String quality) => _sendMessage('setQuality', quality);
  void loadVideo(String videoIdOrUrl) => _sendMessage('loadVideo', videoIdOrUrl);
  void enterFullscreen() => _sendMessage('enterFullscreen');
  void exitFullscreen() => _sendMessage('exitFullscreen');
}
