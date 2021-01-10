import 'package:Horoscope/Models/signs.dart';
import 'package:Horoscope/Widgets/pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentindex = 0;
  PageController _controller;

  onChanged(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  List<Pages> _pages = [
    Pages(
        sign: Sign('Leo', 'Leo the Lion', 'assets/images/aries.png'
            // 'https://i.pinimg.com/564x/82/8b/2d/828b2d7ac9c2fabe4668d1c79a93d914.jpg'
            // 'https://o.remove.bg/downloads/283fb41e-0c00-46ee-9213-6f7bf4627260/capricorn-zodiac-sign-isolated-on-white-background-vector-22769858-removebg-preview.png'
            )),
    Pages(
        sign: Sign(
      'Libra', 'Leo the Lion',
      'assets/images/libra.png',
      // 'https://wallpaperaccess.com/full/875653.jpg'
    )),
    Pages(
        sign: Sign('Taurus', 'Leo the Lion', 'assets/images/taurus.png'
            // 'https://i.pinimg.com/originals/6c/10/41/6c104134a19348812711bc77d068e315.jpg'
            )),
  ];

  List<String> imageurls = [
    'assets/images/leo.png',
    'assets/images/libra.png',
    'assets/images/taurus.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Colors.amber,
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl:
                    'https://i.pinimg.com/originals/6c/10/41/6c104134a19348812711bc77d068e315.jpg',
                fit: BoxFit.cover,
              )),
          PageView(
              controller: _controller,
              onPageChanged: onChanged,
              children: _pages),
        ],
      ),
    );
  }
}
