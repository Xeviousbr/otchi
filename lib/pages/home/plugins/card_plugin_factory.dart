import 'package:flutter/material.dart';
import 'package:ot/pages/home/plugins/card_plugin.dart';
import 'package:ot/pages/home/plugins/card_plugins.dart';

CardPlugin buildPlugin(CardPluginType type) {
  switch (type) {
    case CardPluginType.timer:
      return CardPluginTimer();
    case CardPluginType.text:
      return CardPluginText();
    case CardPluginType.notifier:
      return CardPluginNotifier();
  }
}
