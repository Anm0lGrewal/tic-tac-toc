// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

  var currentplayer = 'X';

  void drawxo(i) {
    if (grid[i] == '-') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });
      findWinnner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      winner = '';
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  var winner = '';
  bool checkMove(i, j, k, sign) {
    if (grid[i] == sign && grid[j] == sign && grid[k] == sign) {
      return true;
    }
    return false;
  }

  void findWinnner(cunnentSign) {
    if (checkMove(0, 1, 2, cunnentSign) ||
        checkMove(3, 4, 5, cunnentSign) ||
        checkMove(6, 7, 8, cunnentSign) ||
        checkMove(0, 3, 6, cunnentSign) ||
        checkMove(1, 4, 7, cunnentSign) ||
        checkMove(2, 5, 8, cunnentSign) ||
        checkMove(0, 4, 8, cunnentSign) ||
        checkMove(2, 4, 6, cunnentSign)) {
      setState(() {
        winner = cunnentSign;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // to change the color theme of the app
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('TIC TAC TOE'),
        ),
        body: Column(
          children: [
            Center(
              // it will make the container look in center in chrome
              child: Container(
                //  to look good in chrome
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                //color: Colors.black,
                margin: EdgeInsets.only(left: 25, right: 25, top: 100),
                child: GridView.builder(
                  // the grid will ocuupy the space of content only
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // no. of boxes horizontally
                    mainAxisSpacing: 10, // space b/w veritcal
                    crossAxisSpacing: 10, // splace b/w horizontal boxes
                  ),
                  itemCount: grid.length,
                  itemBuilder: ((context, index) => Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.amber,
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: (() => drawxo(index)),
                          child: Center(
                            child: Text(
                              grid[index],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: EdgeInsets.all(22),
              ),
              onPressed: reset,
              icon: Icon(Icons.refresh),
              label: Text(
                'Play Again',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40),
            if (winner != '')
              Text(
                '$winner WON THE GAME',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
