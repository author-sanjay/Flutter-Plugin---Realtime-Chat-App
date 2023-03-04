#ifndef FLUTTER_PLUGIN_CHAT_APP_PLUGIN_H_
#define FLUTTER_PLUGIN_CHAT_APP_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace chat_app_plugin {

class ChatAppPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ChatAppPlugin();

  virtual ~ChatAppPlugin();

  // Disallow copy and assign.
  ChatAppPlugin(const ChatAppPlugin&) = delete;
  ChatAppPlugin& operator=(const ChatAppPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace chat_app_plugin

#endif  // FLUTTER_PLUGIN_CHAT_APP_PLUGIN_H_
