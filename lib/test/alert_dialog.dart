import 'package:CheckMate/test/error_pagesss/article_miss.dart';
import 'package:CheckMate/test/error_pagesss/connection_error_page.dart';
import 'package:CheckMate/test/error_pagesss/login_error_page.dart';
import 'package:CheckMate/test/error_pagesss/time_out.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: ErrorPages(),
  ));
}

class ErrorPages extends StatelessWidget {
  const ErrorPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: ClipPath(
          clipper: BottomCornersClipper(),
          child: AppBar(
            backgroundColor: Colors.blue,
            toolbarHeight: 120,
            centerTitle: true,
            title: Text('Error pages'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginErrorPage(),
                  ),
                );
              },
              child: Text('LoginErrorPage'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConnectionError(),
                  ),
                );
              },
              child: Text('ConnectionErrorPage'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TimeOut(),
                  ),
                );
              },
              child: Text('ServerTimeOutPage'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ArticleMissedPage(),
                  ),
                );
              },
              child: Text('ArticleMissedPage'),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomCornersClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cornerRadius = 20.0; // Adjust this radius as needed
    Path path = Path();
    path.lineTo(0, size.height - cornerRadius);
    path.quadraticBezierTo(0, size.height, cornerRadius, size.height);
    path.lineTo(size.width - cornerRadius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - cornerRadius);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
