import 'package:Horoscope/Models/signs.dart';
import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  final Function onTap;
  final Sign sign;
  final Function today, week, month, year;

  const Second(
      {Key key,
      this.onTap,
      @required this.sign,
      this.today,
      this.week,
      this.month,
      this.year})
      : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Center(child: Text(widget.sign.name)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: widget.onTap,
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildText('Today', 700, widget.today),
            buildText('This Week', 800, widget.week),
            buildText('This Month', 900, widget.month),
            buildText('This Year', 1000, widget.year),
          ],
        ),
      ),
    );
  }

  Widget buildText(String data, int i, Function ontap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        onPressed: ontap,
        color: Colors.transparent,
        child: Text(
          data,
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }
}
