import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app_plugin/chat_app_plugin.dart';
import 'package:chat_app_plugin/chat_app_plugin_platform_interface.dart';
import 'package:chat_app_plugin/chat_app_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockChatAppPluginPlatform
    with MockPlatformInterfaceMixin
    implements ChatAppPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ChatAppPluginPlatform initialPlatform = ChatAppPluginPlatform.instance;

  test('$MethodChannelChatAppPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelChatAppPlugin>());
  });

  test('getPlatformVersion', () async {
    ChatAppPlugin chatAppPlugin = ChatAppPlugin();
    MockChatAppPluginPlatform fakePlatform = MockChatAppPluginPlatform();
    ChatAppPluginPlatform.instance = fakePlatform;

    expect(await chatAppPlugin.getPlatformVersion(), '42');
  });
}
