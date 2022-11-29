import 'dart:async';

import 'package:flutter/material.dart';

import 'card_plugin.dart';

class CardPluginText extends CardPlugin {
  @override
  Widget build(BuildContext context, CardPluginRenderingType type, CardItemViewModel item) {
    return TextFormField(
      enabled: type == CardPluginRenderingType.expanded,
      initialValue: item.content,
      maxLines: null,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }
}

class CardPluginTimer extends CardPlugin {
  @override
  Widget build(BuildContext context, CardPluginRenderingType type, CardItemViewModel item) {
    switch (type) {
      case CardPluginRenderingType.collapsed:
        return Container(color: Colors.red, width: 20, height: 20);
      case CardPluginRenderingType.expanded:
        return StreamBuilder<int>(
            stream: Stream.periodic(Duration(seconds: 1), (seconds) => seconds),
            builder: (context, snapshot) {
              return Container(
                color: Colors.blue,
                height: 20,
                child: Text(snapshot.data?.toString() ?? ''),
              );
            });
    }
  }
}

class CardPluginNotifier extends CardPlugin {
  @override
  Widget build(BuildContext context, CardPluginRenderingType type, CardItemViewModel item) {
    switch (type) {
      case CardPluginRenderingType.collapsed:
        return Container(color: Colors.green, width: 20, height: 20);
      case CardPluginRenderingType.expanded:
        return Container(color: Colors.pink, height: 20);
    }
  }
}
