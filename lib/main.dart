import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:song_merge/screens/Home.dart';
import 'package:song_merge/screens/Musica.dart';

void main() => runApp(MaterialApp(
  home: Main(),
  theme: ThemeData(accentColor: Colors.black),
  debugShowCheckedModeBanner: false,
));

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _url = "https://i.ytimg.com/vi/-EzURpTF5c8/maxresdefault.jpg";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        title: Center(
          child: Text(
            "Song Merge",
            style: TextStyle(letterSpacing: 2, color: Colors.black)
          ),
        ),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          unselectedLabelColor: Colors.black,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("todas as músicas"),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("música atual"),
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Home(),
          Musica(),
        ],
      ),
    );
  }
}

