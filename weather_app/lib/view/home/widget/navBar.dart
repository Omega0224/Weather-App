import 'package:flutter/material.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/view/login.dart';
import 'package:weather_app/view/search.dart';

class CustomBottomBar extends StatelessWidget {
  final VoidCallback onLocationPressed;

  const CustomBottomBar({
    super.key,
    required this.onLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: FullInwardConcavePainter(),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: MountainPainter(),
            ),
          ),

          Positioned(
            bottom: 20,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.power_settings_new_outlined, color: Colors.deepPurple),
                onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage(lat: 0.0, lon: 0.0,)));
                },
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.location_searching_outlined, color: Colors.white),
                  onPressed: onLocationPressed
                ),
                SizedBox(width: 60),
                IconButton(
                  icon: Icon(Icons.menu_outlined, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullInwardConcavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2F2353)
      ..style = PaintingStyle.fill;

    final path = Path();
    const double curveDepth = 30; 

    path.moveTo(0, size.height);

    path.lineTo(0, 0);

    path.quadraticBezierTo(
      size.width / 2,
      curveDepth * 2,
      size.width,
      0,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = colors.whiteColor // Warna gelap menyatu dengan background
    //   ..style = PaintingStyle.fill
    //   ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6); // Soft shadow

    // final path = Path();

    // // Mulai dari kiri bawah
    // path.moveTo(size.width * 0.15, size.height);

    // // Naik perlahan membentuk sisi kiri gunung
    // path.quadraticBezierTo(
    //   size.width * 0.35, size.height * 0.4, // Titik kontrol untuk sisi kiri
    //   size.width * 0.5, size.height * 0.1,  // Puncak gunung
    // );

    // // Puncak datar
    // path.lineTo(size.width * 0.7, size.height * 0.1); // Garis datar di atas

    // // Turun perlahan membentuk sisi kanan gunung
    // path.quadraticBezierTo(
    //   size.width * 0.85, size.height * 0.4, // Titik kontrol untuk sisi kanan
    //   size.width * 0.85, size.height,
    // );

    // path.close();
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}





