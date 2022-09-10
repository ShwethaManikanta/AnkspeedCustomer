import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.94);

    var firstEndPoint = Offset(size.width * .5, size.height - 70);
    var firstControlpoint = Offset(size.width * 0.20, size.height);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 120.0);
    var secondControlPoint = Offset(size.width * .80, size.height - 170);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class CustomShapeCopyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.94);

    var firstEndPoint = Offset(size.width * .5, size.height - 70);
    var firstControlpoint = Offset(size.width * 0.20, size.height);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 70.0);
    var secondControlPoint = Offset(size.width * .90, size.height - 120);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

//Custom clipper to render curve in card used to show two different images
class CustomClipperBannerBackgound extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width * 0.5, size.height);
    var firstEndPoint = Offset(size.width * 0.25, size.height / 2);
    var controlPoint = Offset(size.width * 0.25, 0.0);
    path.quadraticBezierTo(
        firstEndPoint.dx, firstEndPoint.dy, controlPoint.dx, controlPoint.dy);
    path.lineTo(size.width * 0.25, 0.0);
    // path.lineTo(size.height, 0.0)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//Custom triangle Clipper used inside box to display message.
class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(0, 0);
    // path.lineTo(size., y)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
