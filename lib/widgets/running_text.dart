import 'package:flutter/material.dart';

class RunningText extends StatefulWidget {
  const RunningText({super.key, required this.constraints, required this.text});

  final BoxConstraints constraints;
  final String text;

  @override
  State<RunningText> createState() => _RunningTextState();
}

class _RunningTextState extends State<RunningText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  double _textWidth = 0;

  void _startAnimationLoop() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    while (mounted) {
      await _controller.forward(from: 0);
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted) _controller.value = 0;
      await Future<void>.delayed(const Duration(seconds: 2));
    }
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: Duration(milliseconds: ((_textWidth / 230) * 2000).round()),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: _textWidth / 230).animate(_controller);
  }

  @override
  void initState() {
    super.initState();

    final painter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.white),
      ),
      maxLines: 1,
      textDirection: .ltr,
      textWidthBasis: .longestLine,
    )..layout();
    _textWidth = painter.width + 20;

    _initAnimation();
    _startAnimationLoop();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        final slide = _animation.value * (widget.constraints.maxWidth) - (_textWidth - widget.constraints.maxWidth);

        return Stack(
          alignment: .center,
          children: [
            SizedBox(width: _textWidth, height: 24),
            Positioned(
              right: slide,
              width: _textWidth,
              height: 24,
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
