import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  const Page({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Overlay.wrap(child: content),
            SizedBox(
              height: paddingTop,
              width: double.maxFinite,
              child: const ColoredBox(color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}
