import 'dart:math' as math;
import 'dart:math';
import 'package:fitness/controllers/watercountController.dart';
import 'package:flutter/material.dart';


import 'dart:math' as math;
import 'package:get/get.dart';

class WaveWidget extends StatefulWidget {
  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];
  double width = 700;
  double height = 700;
  double depth = 10;

  final WaterLevelController controller = Get.put(WaterLevelController());

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2; i <= width; i++) {
        var val = math.sin((animationController.value * 360 - i) % 360 * math.pi / 180);
        animList1.add(Offset(i.toDouble(), val * depth + height * (1 - controller.waterLevelPercentage.value / 100)));
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today", style: TextStyle(color: Color(0xff325F89))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xff325F89)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: AnimatedBuilder(
                    animation: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.easeInOut,
                    ),
                    builder: (context, child) {
                      return ClipPath(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff62B5CC),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        clipper: WaveClipper(animationController.value, animList1),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            '${(controller.waterLevelPercentage.value / 12).round()}',
                            style: TextStyle(
                              fontSize: 80,
                              color: Color(0xff325F89),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text(
                        'Glasses',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff325F89),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(8, (index) {
                          return Expanded(
                            child: GestureDetector(
                              child: Obx(() => Icon(
                                    Icons.local_drink,
                                    color: index <= controller.selectedGlassIndex.value
                                        ? Color(0xff325F89)
                                        : Colors.black,
                                  )),
                              onTap: () {
                                controller.updateWaterLevel(index);
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'GOAL: 8 GLASSES A DAY',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff325F89),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;
  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon(waveList1, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => animation != oldClipper.animation;
}
