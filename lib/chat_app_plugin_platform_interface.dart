import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'chat_app_plugin_method_channel.dart';

abstract class ChatAppPluginPlatform extends PlatformInterface {
  /// Constructs a ChatAppPluginPlatform.
  ChatAppPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ChatAppPluginPlatform _instance = MethodChannelChatAppPlugin();

  /// The default instance of [ChatAppPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelChatAppPlugin].
  static ChatAppPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ChatAppPluginPlatform] when
  /// they register themselves.
  static set instance(ChatAppPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
