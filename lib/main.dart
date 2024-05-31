// import 'dart:async';
// import 'dart:math' as math;
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
//
// class _MyAppState extends State<MyApp> {
//   double _x = 0.0;
//   double _y = 0.0;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   accelerometerListener();
//   // }
//
//   void initState() {
//     super.initState();
//     accelerometerListener();
//   }
//
//   void accelerometerListener() async {
//     // Request permission for accelerometer data (optional, check package documentation)
//     await SensorsPlus.platformSensorsRequestPermission(
//         SensorType.accelerometer, SensorPermission.motion);
//
//     // Listen for accelerometer events
//     StreamSubscription<UserAccelerometerEvent> streamSubscription =
//     SensorsPlus.accelerometerEvents.listen((event) {
//       setState(() {
//         _x = event.x;
//         _y = event.y;
//       });
//     });
//
//     // Dispose of the stream when the widget is no longer in use
//     @override
//     void dispose() {
//       streamSubscription.cancel();
//       super.dispose();
//     }
//   }
//
//   // void accelerometerListener() async {
//   //   // Access accelerometer data
//   //   var sensorData = await deviceAccelerometer.getCurrentReading();
//   //
//   //   // Update state variables based on accelerometer values
//   //   setState(() {
//   //     _x = sensorData.x;
//   //     _y = sensorData.y;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Bubble Level'),
//         ),
//         body: Center(
//           child: Container(
//             width: 250.0,
//             height: 250.0,
//             child: Stack(
//               children: <Widget>[
//                 // Circular background with level lines
//                 CustomPaint(
//                   painter: CirclePainter(),
//                 ),
//                 // Bubble that moves based on tilt
//                 Positioned(
//                   left: 125.0 + (_x * 60.0), // Adjust multiplier to position bubble
//                   top: 125.0 - (_y * 60.0), // Adjust multiplier to position bubble
//                   child: Container(
//                     width: 50.0,
//                     height: 50.0,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 // Horizontal bar for level indication
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     margin: EdgeInsets.only(top: 30),
//                     width: 200,
//                     height: 10,
//                     color: Colors.black,
//                     child: Stack(
//                       children: [
//                         // Center line
//                         Positioned(
//                           left: 100,
//                           child: Container(
//                             width: 2,
//                             height: 10,
//                             color: Colors.white,
//                           ),
//                         ),
//                         // Indicator based on tilt (replace with custom widget if needed)
//                         LevelIndicator(
//                           offset: _x, // Pass tilt value
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Vertical bar for level indication
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.only(left: 30),
//                     width: 10,
//                     height: 200,
//                     color: Colors.black,
//                     child: Stack(
//                       children: [
//                         // Center line
//                         Positioned(
//                           top: 100,
//                           child: Container(
//                             width: 10,
//                             height: 2,
//                             color: Colors.white,
//                           ),
//                         ),
//                         // Indicator based on tilt (replace with custom widget if needed)
//                         LevelIndicator(
//                           offset: _y, // Pass tilt value
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 4.0;
//
//     // Draw the circle
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
//
//     // Draw horizontal line at center
//     canvas.drawLine(
//         Offset(size.width * 0.1, size.height / 2), Offset(size.width * 0.9, size.height / 2), paint);
//
//     // Draw vertical line at center
//     canvas.drawLine(
//         Offset(size.width / 2, size.height * 0.1), Offset(size.width / 2, size.height * 0.9), paint);
//   }
//
//   @override
//   bool shouldRepaint(CirclePainter oldDelegate) => true;
// }
//
// class LevelIndicator extends StatelessWidget {
//   final double offset; // Tilt value (between -1 and 1)
//
//   const LevelIndicator({Key? key, required this.offset}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double indicatorWidth = 20.0;
//     final double maxPosition = 100.0; // Adjust based on container size
//
//     // Calculate indicator position based on tilt value
//     final double position = maxPosition * (offset.abs() / 1.0);
//
//     // Determine color based on tilt (optional)
//     final Color color = offset > 0.1 ? Colors.red : Colors.green;
//
//     return Container(
//       width: indicatorWidth,
//       height: indicatorWidth,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Container(
//           width: indicatorWidth,
//           height: position, // Adjust height based on tilt
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math'; // Import the math library to use sin and cos functions

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
    Color bubbleColor = (_x.abs() < 0.1 && _y.abs() < 0.1) ? Colors.orange :
    Colors.green;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // body: Center(
      //   child: Column( // Use Column for vertical layout
      //     children: <Widget>[
      //       // Circular grid with lines
      //       Container(
      //         width: 250,
      //         height: 250,
      //         child: CustomPaint(
      //           painter: CircularGridPainter(),
      //         ),
      //       ),
      //       // Row( // Use Row for horizontal layout
      //       //   mainAxisAlignment: MainAxisAlignment.center, // Center widgets horizontally
      //       //   children: <Widget>[
      //           // Central bubble (overlaps circular grid)
      //           Positioned(
      //             left: screenWidth / 2 + _x * 5 - 25,
      //             top: screenHeight / 2 - _y * 5 - 25,
      //             child: Container(
      //               width: 50,
      //               height: 50,
      //               decoration: BoxDecoration(
      //                 color: bubbleColor,
      //                 shape: BoxShape.circle,
      //               ),
      //             ),
      //         //   ),
      //         // ],
      //       ),
      //       // Horizontal bar
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Container(
      //           margin: EdgeInsets.only(top: 30),
      //           width: 200,
      //           height: 10,
      //           color: Colors.black,
      //           child: Align(
      //             alignment: Alignment(_x / 10, 0),  // Adjust division to position the bar correctly
      //             child: Container(
      //               width: 20,
      //               height: 20,
      //               decoration: BoxDecoration(
      //                 color: bubbleColor,
      //                 shape: BoxShape.circle,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       // Vertical bar
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Container(
      //           margin: EdgeInsets.only(left: 30),
      //           width: 10,
      //           height: 200,
      //           color: Colors.black,
      //           child: Align(
      //             alignment: Alignment(0, -_y / 10),  // Adjust division to position the bar correctly
      //             child: Container(
      //               width: 20,
      //               height: 20,
      //               decoration: BoxDecoration(
      //                 color: bubbleColor,
      //                 shape: BoxShape.circle,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Circular grid with lines
            Container(
              width: 250,
              height: 250,
              child: CustomPaint(
                painter: CircularGridPainter(),
              ),
            ),
            Text("data"),
            // Central bubble
            Positioned(
              left: screenWidth/2 + _x * 5 - 25,  // Adjust multiplier to
              // position
              // the bubble correctly
              top: screenHeight/2 - _y * 5 - 25,   // Adjust multiplier to
              // position the bubble correctly
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: bubbleColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Horizontal bar
            Align(
              alignment: Alignment.bottomCenter,
              child:
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 200,
                height: 10,
                color: Colors.black,
                child: Align(
                  alignment: Alignment(_x / 10, 0),  // Adjust division to position the bar correctly
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            // Vertical bar
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 30),
                width: 10,
                height: 200,
                color: Colors.black,
                child: Align(
                  alignment: Alignment(0, -_y / 10),  // Adjust division to position the bar correctly
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (int i = 0; i < 36; i++) {
      final double angle = i * 10 * (pi / 180); // Convert degrees to radians
      final double startX = radius + (radius - 5) * cos(angle);
      final double startY = radius + (radius - 5) * sin(angle);
      final double endX = radius + (radius - 10) * cos(angle);
      final double endY = radius + (radius - 10) * sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }

    // Draw horizontal lines
    for (int i = 0; i < 36; i++) {
      final double angle = i * 10 * (pi / 180); // Convert degrees to radians
      final double startX = radius + (radius - 5) * cos(angle);
      final double startY = radius + (radius - 5) * sin(angle);
      final double endX =
          radius + (radius - 10) * cos(angle + (90 * (pi / 180)));
      final double endY =
          radius + (radius - 10) * sin(angle + (90 * (pi / 180)));
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
