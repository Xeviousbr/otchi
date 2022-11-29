import 'package:flutter/material.dart';
import 'package:ot/pages/home/plugins/card_plugin.dart';

class CardItem extends StatefulWidget {
  const CardItem({
    Key? key,
    required this.item,
    required this.buildPlugin,
  }) : super(key: key);
  final CardItemViewModel item;
  final CardPlugin Function(CardPluginType) buildPlugin;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _expanded = false;
  late Iterable<CardPlugin> _plugins;

  @override
  void initState() {
    _plugins = widget.item.plugins.map(widget.buildPlugin);
    for (final plugin in _plugins) {
      plugin.onInitialize(widget.item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(8),
      color: Colors.amber[50],
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(
                    _expanded ? Icons.close : Icons.edit,
                    size: 16,
                  ),
                ),
              ],
            ),
            if (_expanded)
              ..._plugins
                  .map(
                    (plugin) => plugin.build(
                      context,
                      CardPluginRenderingType.expanded,
                      widget.item,
                    ),
                  )
                  .toList()
            else
              SizedBox(
                height: 80,
                child: Wrap(
                  children: _plugins
                      .map(
                        (plugin) => Expanded(
                          child: plugin.build(
                            context,
                            CardPluginRenderingType.collapsed,
                            widget.item,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    for (final plugin in _plugins) {
                      plugin.onUpdate(widget.item);
                    }
                  },
                  icon: const Icon(Icons.check),
                ),
                IconButton(
                  onPressed: () {
                    for (final plugin in _plugins) {
                      plugin.onDelete(widget.item);
                    }
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final plugin in _plugins) {
      plugin.onDispose(widget.item);
    }
    super.dispose();
  }
}
