import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(BubbleLevelApp());
}

class BubbleLevelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble Level',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BubbleLevelScreen(),
    );
  }
}

class BubbleLevelScreen extends StatefulWidget {
  @override
  _BubbleLevelScreenState createState() => _BubbleLevelScreenState();
}

class _BubbleLevelScreenState extends State<BubbleLevelScreen> {
  double _x = 0.0;
  double _y = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange : Color(0xFF4C4C4C);
    Color bubbleColor2 = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange :
    Color.fromRGBO(203, 219, 188, 10);
    Color bubbleColor3 = (_x.abs() < 0.1) ? Colors.orange :
    Colors.black;
    Color bubbleColor4 = (_y.abs() < 0.1) ? Colors.orange :
    Color.fromRGBO(203, 219, 188, 10);

    // Clamping the values to keep the bubbles within the bounds of the bars
    double clampedX = (_x / 10).clamp(-10.0, 10.0);
    double clampedY = (_y / 10).clamp(-10.0, 10.0);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth*2,
                          height: screenWidth*2,
                          child: SizedBox(
                            width: screenWidth*0.5,
                            height: screenWidth*0.5,
                            child: Image.asset(
                              'assets/images/bgrdBubble3.png',
                            ),
                          ),
                        ),
                        // Central bubble
                        Positioned(
                          left: screenWidth / 2 + _x * 5 - 20,
                          top: screenHeight / 2 - _y * 5 - 40,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: bubbleColor2,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Vertical bar
                        Positioned(
                          left: screenWidth * 6 / 8 + 50,// + 150, // Adjust
                          // as needed
                          top: screenHeight / 2 - 120, // Center vertically
                          // .100 for ht
                          child: Container(
                            width: 20,
                            height: 200,
                            color: Colors.black,
                            child: Align(
                              alignment: Alignment(0, - clampedY), // Adjust
                              // alignment: Alignment(0, - _y/5), // Adjust
                              // division to position the bar correctly
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bubbleColor4,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Horizontal bar
                        Positioned(
                          left: screenWidth/2 - 100, // Adjust as needed
                          top: screenHeight/2 + screenWidth/2 - 40,
                          // Center vertically.-10 as width 20 ,screenwidth/2 for image size
                          child: Container(
                            width: 200,
                            height: 20,
                            color: Color.fromRGBO(203, 219, 188, 10),
                            child: Align(
                              alignment: Alignment(clampedX, 0), // Adjust division
                              // alignment: Alignment(_x/5, 0), // Adjust division
                              // to position the bar correctly
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: bubbleColor3,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('_x value: ' + _x.toStringAsFixed(5) + '°'),
                      Text('_y value: ' + _y.toStringAsFixed(5) + '°'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}