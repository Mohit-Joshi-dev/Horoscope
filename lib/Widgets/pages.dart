import 'package:Horoscope/Models/signs.dart';
import 'package:Horoscope/Screens/second.dart';
import 'package:Horoscope/Screens/third.dart';
import 'package:flutter/material.dart';
import 'package:Horoscope/Widgets/page.dart';

import 'package:http/http.dart' as http;

class Pages extends StatefulWidget {
  final Sign sign;
  const Pages({
    Key key,
    this.sign,
  }) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int pageNumber = 1;
  Widget pageWidget = Container();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    // init();
  }

  init() async {
    var result = await http.get(
        'http://horoscope-api.herokuapp.com/horoscope/today/' +
            widget.sign.name);
    print(result.body);
  }

  @override
  Widget build(BuildContext context) {
    // Widget page = pageNumber == 1
    //     ? Page(sign: Sign('Leo', 'Leo the Lion',
    //                   'https://i.pinimg.com/564x/82/8b/2d/828b2d7ac9c2fabe4668d1c79a93d914.jpg')
    //       )
    //     : Page(
    //       );

    switch (pageNumber) {
      case 1:
        pageWidget = Pager(
          delay: 100,
          // sign: Sign('Leo', 'Leo the Lion',
          //     'https://i.pinimg.com/564x/82/8b/2d/828b2d7ac9c2fabe4668d1c79a93d914.jpg'),
          onTap: () {
            if (pageNumber == 1) {
              setState(() {
                pageNumber = 2;
              });
            } else {
              setState(() {
                pageNumber = 1;
              });
            }
          },
          sign: widget.sign,
        );
        _offset = 510;
        print('1');

        break;
      case 2:
        _offset = 100;
        print('2');
        // pageWidget = Second(
        //   sign: widget.sign,
        //   onTap: () {
        //     if (pageNumber == 1) {
        //       setState(() {
        //         pageNumber = 2;
        //       });
        //     } else {
        //       setState(() {
        //         pageNumber = 1;
        //       });
        //     }
        //   },
        //   today: () {
        //     setState(() {
        //       pageNumber = 3;
        //     });
        //   },
        //   week: () {
        //     setState(() {
        //       pageNumber = 4;
        //     });
        //   },
        //   month: () {
        //     setState(() {
        //       pageNumber = 5;
        //     });
        //   },
        //   year: () {
        //     setState(() {
        //       pageNumber = 6;
        //     });
        //   },
        // );
        break;

      case 3:
        pageWidget = Thrid(
          day: 'today',
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          sign: widget.sign,
        );
        break;

      case 4:
        pageWidget = Thrid(
          day: 'week',
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          sign: widget.sign,
        );
        break;

      case 5:
        pageWidget = Thrid(
          day: 'month',
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          sign: widget.sign,
        );
        break;

      case 6:
        pageWidget = Thrid(
          day: 'year',
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          sign: widget.sign,
        );
        break;

      default:
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: backgroundDecoration,
        child: Stack(
          children: <Widget>[
            pageWidget,
            Positioned(
              bottom: -10,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.translationValues(0, _offset, 1),
                child: Thrid(
                  day: 'today',
                  sign: widget.sign,
                  onTap: () {
                    if (pageNumber == 1) {
                      setState(() {
                        pageNumber = 2;
                      });
                    } else {
                      setState(() {
                        pageNumber = 1;
                      });
                    }
                  },
                  // show: pageNumber == 2 ? true : false
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemFaders extends StatefulWidget {
  final Widget child;

  const ItemFaders({Key key, @required this.child}) : super(key: key);

  @override
  _ItemFadersState createState() => _ItemFadersState();
}

class _ItemFadersState extends State<ItemFaders>
    with SingleTickerProviderStateMixin {
  //1 means its below, -1 means its above
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  void show() {
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
      child: widget.child,
    );
  }
}
