import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height / 4);

    var firstEndPoint = Offset(size.width * .68, size.height * .35);
    var firstControlpoint = Offset(size.width * 0.25, size.height * .15);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    
    var secondEndPoint = Offset(size.width * .9, size.height * .85);
    var secondControlPoint = Offset(size.width * .95, size.height * .5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    var thirdEndPoint = Offset(size.width, size.height);
    var thirdControlPoint = Offset(size.width * .87, size.height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);
    
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;


}