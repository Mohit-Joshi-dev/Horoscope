import 'package:Horoscope/Models/signs.dart';
import 'package:flutter/material.dart';

class Pager extends StatefulWidget {
  final int delay;
  final Function onTap;
  final Sign sign;

  const Pager({Key key, @required this.delay, this.onTap, this.sign})
      : super(key: key);
  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> with SingleTickerProviderStateMixin {
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  void show() async {
    await Future.delayed(Duration(milliseconds: widget.delay));
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    show();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 64 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                height: 150,
                child: Image.asset(
                  widget.sign.imageurl,
                  colorBlendMode: BlendMode.hue,
                )),
            SizedBox(height: 20),
            GestureDetector(
              onTap: widget.onTap,
              child: Text(
                widget.sign.name,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
