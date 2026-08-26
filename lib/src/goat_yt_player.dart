import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'goat_yt_player_controller.dart';

/// The main widget for embedding a YouTube video player.
class GoatYtPlayer extends StatefulWidget {
  /// The YouTube Video ID to be played.
  final String videoId;
  
  /// The URL of the hosted player HTML page.
  final String hostedPlayerUrl;
  
  /// The controller to programmatically interact with the player.
  final GoatYtPlayerController? controller;
  
  /// The aspect ratio of the player (default is 16/9).
  final double aspectRatio;
  
  /// Whether the video should automatically start playing (default is false).
  final bool autoplay;
  
  /// Whether the video starts muted (default is false).
  final bool mute;
  
  /// Whether the video should loop indefinitely (default is false).
  final bool loop;
  
  /// Time in seconds where the video should start.
  final int start;
  
  /// Time in seconds where the video should end.
  final int? end;
  
  /// Whether to show the entire control bar (default is true).
  final bool showControls;
  
  /// Time in ms before controls automatically hide on inactivity (default is 3000).
  final int autohide;
  
  /// HEX color string (e.g., `FF0000`) for the player's primary accents.
  final String? accentColor;
  
  /// Call to action text for the player.
  final String? ctaText;
  
  /// URL to redirect to when the CTA is clicked.
  final String? ctaUrl;
  
  /// Whether to show the seek bar (default is true).
  final bool showSeek;
  
  /// Whether to show the volume control (default is true).
  final bool showVolume;
  
  /// Whether to show the playback speed control (default is true).
  final bool showSpeed;
  
  /// Whether to show the video quality selector (default is true).
  final bool showQuality;
  
  /// Whether to show the rewind button (default is true).
  final bool showRewind;
  
  /// Whether to show the fullscreen toggle button (default is true).
  final bool showFullscreen;

  /// Callback when the player is ready to receive commands.
  final VoidCallback? onReady;
  
  /// Callback when the player's state changes (e.g., playing, paused).
  final Function(String state)? onStateChange;
  
  /// Callback when an error occurs.
  final Function(String code)? onError;
  
  /// Callback for video progress updates.
  final Function(double currentTime, double duration, double buffered)? onProgress;
  
  /// Callback when the volume changes or is muted.
  final Function(int volume, bool muted)? onVolumeChange;
  
  /// Callback when the video quality changes.
  final Function(String quality)? onQualityChange;
  
  /// Callback when the player enters or exits fullscreen mode.
  final Function(bool fullscreen)? onFullscreenChange;

  /// Creates a new instance of [GoatYtPlayer].
  const GoatYtPlayer({
    super.key,
    required this.videoId,
    required this.hostedPlayerUrl,
    this.controller,
    this.aspectRatio = 16 / 9,
    this.autoplay = false,
    this.mute = false,
    this.loop = false,
    this.start = 0,
    this.end,
    this.showControls = true,
    this.autohide = 3000,
    this.accentColor,
    this.ctaText,
    this.ctaUrl,
    this.showSeek = true,
    this.showVolume = true,
    this.showSpeed = true,
    this.showQuality = true,
    this.showRewind = true,
    this.showFullscreen = true,
    this.onReady,
    this.onStateChange,
    this.onError,
    this.onProgress,
    this.onVolumeChange,
    this.onQualityChange,
    this.onFullscreenChange,
  });

  @override
  State<GoatYtPlayer> createState() => _GoatYtPlayerState();
}

class _GoatYtPlayerState extends State<GoatYtPlayer> {
  late final WebViewController _webViewController;
  late final GoatYtPlayerController _internalController;
  final GlobalKey _webViewKey = GlobalKey();
  bool _isFullscreen = false;
  String _playerState = 'unstarted';

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? GoatYtPlayerController();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..addJavaScriptChannel(
        'YoutubePlayerEvent',
        onMessageReceived: _handleMessage,
      )
      ..loadRequest(Uri.parse(_buildUrl()));

    if (_webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _internalController.attach(_webViewController);
  }

  @override
  void didUpdateWidget(GoatYtPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _internalController.loadVideo(widget.videoId);
    }
  }

  String _buildUrl() {
    final uri = Uri.parse(widget.hostedPlayerUrl);
    final params = <String, String>{
      'v': widget.videoId,
      'autoplay': widget.autoplay ? '1' : '0',
      'mute': widget.mute ? '1' : '0',
      'loop': widget.loop ? '1' : '0',
      'start': widget.start.toString(),
      'controls': widget.showControls ? '1' : '0',
      'autohide': widget.autohide.toString(),
      'ratio': widget.aspectRatio.toString(),
      'show_seek': widget.showSeek ? '1' : '0',
      'show_volume': widget.showVolume ? '1' : '0',
      'show_speed': widget.showSpeed ? '1' : '0',
      'show_quality': widget.showQuality ? '1' : '0',
      'show_rewind': widget.showRewind ? '1' : '0',
      'show_fullscreen': widget.showFullscreen ? '1' : '0',
    };
    
    if (widget.end != null) params['end'] = widget.end.toString();
    if (widget.accentColor != null) params['accent'] = widget.accentColor!;
    if (widget.ctaText != null) params['cta_text'] = widget.ctaText!;
    if (widget.ctaUrl != null) params['cta_url'] = widget.ctaUrl!;
    params['_t'] = DateTime.now().millisecondsSinceEpoch.toString();

    return uri.replace(queryParameters: params).toString();
  }

  void _handleMessage(JavaScriptMessage message) {
    try {
      final data = jsonDecode(message.message);
      if (data['source'] != 'yt-flutter-player') return;
      
      final event = data['event'];
      final payload = data['data'];

      switch (event) {
        case 'onReady':
          widget.onReady?.call();
          break;
        case 'onStateChange':
          _playerState = payload['state'].toString();
          widget.onStateChange?.call(_playerState);
          break;
        case 'onError':
          widget.onError?.call(payload['code']?.toString() ?? 'unknown');
          break;
        case 'onQualityChange':
          widget.onQualityChange?.call(payload['quality']?.toString() ?? 'auto');
          break;
        case 'onProgress':
          widget.onProgress?.call(
            (payload['currentTime'] as num).toDouble(),
            (payload['duration'] as num).toDouble(),
            (payload['buffered'] as num).toDouble(),
          );
          break;
        case 'onVolumeChange':
          widget.onVolumeChange?.call(
            (payload['volume'] as num).toInt(),
            payload['muted'] == true,
          );
          break;
        case 'onFullscreenChange':
          final bool fullscreen = payload['fullscreen'] == true;
          _toggleFullscreen(fullscreen);
          widget.onFullscreenChange?.call(fullscreen);
          break;
      }
    } catch (e) {
      debugPrint('Error parsing message from webview: $e');
    }
  }

  void _toggleFullscreen(bool fullscreen) {
    if (_isFullscreen == fullscreen) return;
    
    final bool wasPlaying = _playerState == '1';

    if (fullscreen) {
      setState(() {
        _isFullscreen = true;
      });

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          pageBuilder: (context, _, __) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Center(
                  child: WebViewWidget(key: _webViewKey, controller: _webViewController),
                ),
              ),
            );
          },
        ),
      ).then((_) {
        // Runs after popped (e.g. via Android back button or exit button)
        _isFullscreen = false;
        _internalController.exitFullscreen(); // Ensure JS is synced
        
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        if (mounted) setState(() {});
        
        if (wasPlaying) {
          Future.delayed(const Duration(milliseconds: 600), () {
            _internalController.play();
          });
        }
      });
    } else {
      // Just pop. The `then` block above handles restoring state.
      Navigator.of(context).pop();
      if (wasPlaying) {
        Future.delayed(const Duration(milliseconds: 600), () {
          _internalController.play();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullscreen) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(color: Colors.black),
      );
    }
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: WebViewWidget(key: _webViewKey, controller: _webViewController),
    );
  }
}
