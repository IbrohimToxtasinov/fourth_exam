import 'package:flutter/material.dart';

class AnimationCircularBar extends StatefulWidget {
  const AnimationCircularBar({super.key});

  @override
  State<AnimationCircularBar> createState() => _AnimationCircularBarState();
}

class _AnimationCircularBarState extends State<AnimationCircularBar> {
  bool isChanged = true;
  Color colorsGalochka = Colors.grey;
  int seconds = 16;

  @override
  Widget build(BuildContext context) {
    Color colorsGalochka = Colors.grey;
    int seconds = 8;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => colorsGalochka = Colors.green);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            isChanged ? const Text("Animations") : const Text("Custom Paint"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isChanged = !isChanged;
                });
              },
              icon: const Icon(Icons.change_circle))
        ],
      ),
      body: isChanged
          ? Center(
              child: TweenAnimationBuilder(
                duration: Duration(seconds: seconds),
                tween: Tween(begin: 0.0, end: 5),
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.grey,
                            strokeWidth: 10,
                            value: value + 0.0,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.done,
                          size: 50,
                          color: colorsGalochka,
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 500,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.greenAccent, Colors.green])),
                      child: CustomPaint(
                        size: const Size(500, 500),
                        painter: MyPainter(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    Path paths = Path();

    paths.lineTo(0, size.height * 0.5);

    paths.cubicTo(
      size.width * 0.3,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.7,
      size.width,
      size.height * 0.5,
    );

    paths.lineTo(size.width, 0);
    canvas.drawPath(paths, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
