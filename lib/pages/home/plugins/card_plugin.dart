import 'package:flutter/material.dart';

class CardItemViewModel {
  CardItemViewModel({
    required this.content,
    required this.id,
    required this.plugins,
  });
  final String content;
  final String id;
  final Iterable<CardPluginType> plugins;
}

enum CardPluginRenderingType { collapsed, expanded }
enum CardPluginType {
  timer,
  text,
  notifier,
}

abstract class CardPlugin {
  void onInitialize(CardItemViewModel item) {}
  void onDispose(CardItemViewModel item) {}
  void onDelete(CardItemViewModel item) {}
  void onUpdate(CardItemViewModel item) {}

  Widget build(
    BuildContext context,
    CardPluginRenderingType type,
    CardItemViewModel item,
  );
}
