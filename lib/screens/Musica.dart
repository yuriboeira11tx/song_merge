import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Musica extends StatefulWidget {
  @override
  _MusicaState createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  final Color _dotColor = Color(0xff040602);
  final String _albumArtUrl = 'https://mmminimal.com/wp-content/uploads/2011/03/Pink-Floyd-Dark-Side-of-t.jpg';
  double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Stack(
        children: <Widget>[
          _albumArt(),
          _seekBar(),
          _musicTitle(),
          _bottomButtons(),
        ],
      ),
    );
  }

  Widget _bottomButtons() => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      height: 0.22 * height,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Text("1:15"),

          Expanded(
            child: Center(
              child: Row(
                children: <Widget>[
                  Icon(Icons.shuffle),
                  Expanded(
                    child: _musicControls(),
                  ),
                  Icon(Icons.repeat),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  Widget _musicControls() => Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.fast_rewind),
                SizedBox(width: 120),
                Icon(Icons.fast_forward),
              ],
            ),
          ),
        ),
      ),

      CircleAvatar(
        radius: 35,
        backgroundColor: _dotColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.play_arrow),
      ),
    ],
  );

  Widget _musicTitle() => Positioned(
    bottom: 0.4 * height,
    left: 55,
    right: 55,
    child: Column(
      children: <Widget>[
        Text("Time", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text("Pink Floyd", style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ],
    ),
  );

  Widget _seekBar() => Positioned(
    left: 0,
    right: 3,
    bottom: 0.25 * height,
    child: SleekCircularSlider(
      min: 0,
      max: 100,
      initialValue: 32,
      onChange: (double value) {
        print(value);
      },
      innerWidget: (value) => Container(),
      appearance: CircularSliderAppearance(
        startAngle: 0,
        angleRange: 180,
        size: width - 50,
        customWidths: CustomSliderWidths(
          progressBarWidth: 4.0,
          trackWidth: 4.0,
          handlerSize: 8.0,
        ),
        customColors: CustomSliderColors(
          progressBarColor: _dotColor,
          trackColor: Colors.grey,
          dotColor: _dotColor,
        ),
      ),
    ),
  );

  Widget _albumArt() => Container(
    width: double.infinity,
    height: double.infinity,
    margin: EdgeInsets.only(
      left: 50,
      right: 50,
      bottom: 0.3 * height,
    ),

    decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_albumArtUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular((width - 100) / 2),
          bottomRight: Radius.circular((width - 100) / 2),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 8),
              blurRadius: 5.0)
        ],
    ),
  );
}
