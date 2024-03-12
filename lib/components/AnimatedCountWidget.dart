import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class AnimatedCountWidget extends StatefulWidget {
  final int count;

  AnimatedCountWidget({required this.count});

  @override
  _AnimatedCountWidgetState createState() => _AnimatedCountWidgetState();
}

class _AnimatedCountWidgetState extends State<AnimatedCountWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = IntTween(begin: 0, end: widget.count).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _animation.value.toString(),
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
