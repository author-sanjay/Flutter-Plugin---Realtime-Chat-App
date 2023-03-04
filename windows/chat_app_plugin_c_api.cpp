#include "include/chat_app_plugin/chat_app_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "chat_app_plugin.h"

void ChatAppPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  chat_app_plugin::ChatAppPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
