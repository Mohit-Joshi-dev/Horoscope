import 'dart:convert';

import 'package:Horoscope/Models/signs.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Thrid extends StatefulWidget {
  final Sign sign;
  final Function onTap;
  final String day;

  const Thrid({Key key, @required this.sign, this.onTap, @required this.day})
      : super(key: key);
  @override
  _ThridState createState() => _ThridState();
}

class _ThridState extends State<Thrid> {
  var data;

  @override
  void initState() {
    super.initState();
    // if (widget.show == true) {
    // init();
    // }
  }

  init() async {
    var result = await http.get(
        'http://horoscope-api.herokuapp.com/horoscope/' +
            widget.day +
            '/' +
            widget.sign.name);

    var response = json.decode(result.body);
    print(result.body);
    setState(() {
      data = response;
      // print(data['']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        // color: Colors.amber,
        width: width,
        height: height / 1.1,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                    // padding: EdgeInsets.all(20),
                    child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 40,
                )),
              ),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Today'),
                  Tab(text: 'This Week'),
                  Tab(text: 'This Month'),
                ],
              ),
            ),
            body: TabBarView(children: [
              Content(
                // data: data,
                widget: widget,
                day: 'year',
                sign: widget.sign,
              ),
              Content(
                // data: data,
                widget: widget,
                day: 'week',
                sign: widget.sign,
              ),
              Content(
                // data: data,
                widget: widget,
                day: 'month',
                sign: widget.sign,
              ),
            ]),
          ),
        )
        //  Content(widget: widget, data: data),
        );
  }
}

class Content extends StatefulWidget {
  const Content(
      {Key key,
      @required this.day,
      @required this.widget,
      // @required this.data,
      @required this.sign})
      : super(key: key);

  final Thrid widget;
  // final data;
  final String day;
  final Sign sign;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var data;

  @override
  void initState() {
    super.initState();
    // if (widget.show == true) {
    init();
    print(widget.day);
    print(widget.sign.name);
    // }
  }

  init() async {
    var result = await http.get(
        'http://horoscope-api.herokuapp.com/horoscope/' +
            widget.day +
            '/' +
            widget.sign.name.toLowerCase());

    var response = json.decode(result.body);
    print(result.body);
    setState(() {
      data = response;
      // print(data['']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(height: 40, child: CircularProgressIndicator()),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // Text(
                      //   widget.day,
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      Text(
                        data['horoscope'],
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        data['sunsign'],
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
