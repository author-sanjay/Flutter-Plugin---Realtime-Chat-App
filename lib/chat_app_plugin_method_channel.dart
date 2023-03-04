import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'chat_app_plugin_platform_interface.dart';

/// An implementation of [ChatAppPluginPlatform] that uses method channels.
class MethodChannelChatAppPlugin extends ChatAppPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('chat_app_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
