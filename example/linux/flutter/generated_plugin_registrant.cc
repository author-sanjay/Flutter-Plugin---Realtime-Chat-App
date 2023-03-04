//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <chat_app_plugin/chat_app_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) chat_app_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ChatAppPlugin");
  chat_app_plugin_register_with_registrar(chat_app_plugin_registrar);
}
