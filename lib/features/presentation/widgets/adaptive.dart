import 'package:flutter/material.dart';

class AdaptiveView extends StatefulWidget {
  final Widget mobileInterface;
  final Widget tabletInterface;

  const AdaptiveView(
      {super.key,
      required this.mobileInterface,
      required this.tabletInterface});

  @override
  State<AdaptiveView> createState() => _AdaptiveViewState();
}

class _AdaptiveViewState extends State<AdaptiveView> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600 &&
            MediaQuery.of(context).orientation == Orientation.landscape
        ? widget.tabletInterface
        : widget.mobileInterface;
  }
}
