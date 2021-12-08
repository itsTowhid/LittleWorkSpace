import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class EllipseUtils {
  const EllipseUtils(this._canvas, this._paint);

  final Canvas _canvas;
  final Paint _paint;

  drawEllipse(double rx, double ry, double xc, double yc) {
    final points = <Offset>[];
    double dx, dy, d1, d2, x, y;
    x = 0;
    y = ry;

// Initial decision parameter of region 1
    d1 = (ry * ry) - (rx * rx * ry) + (0.25 * rx * rx);
    dx = 2 * ry * ry * x;
    dy = 2 * rx * rx * y;

// For region 1
    while (dx < dy) {
// Print points based on 4-way symmetry
      points.add(Offset(x + xc, y + yc));
      points.add(Offset(-x + xc, y + yc));
      points.add(Offset(x + xc, -y + yc));
      points.add(Offset(-x + xc, -y + yc));

// Checking and updating value of
// decision parameter based on algorithm
      if (d1 < 0) {
        x++;
        dx = dx + (2 * ry * ry);
        d1 = d1 + dx + (ry * ry);
      } else {
        x++;
        y--;
        dx = dx + (2 * ry * ry);
        dy = dy - (2 * rx * rx);
        d1 = d1 + dx - dy + (ry * ry);
      }
    }

// Decision parameter of region 2
    d2 = ((ry * ry) * ((x + 0.5) * (x + 0.5))) +
        ((rx * rx) * ((y - 1) * (y - 1))) -
        (rx * rx * ry * ry);

// Plotting points of region 2
    while (y >= 0) {
// Print points based on 4-way symmetry
      points.add(Offset(x + xc, y + yc));
      points.add(Offset(-x + xc, y + yc));
      points.add(Offset(x + xc, -y + yc));
      points.add(Offset(-x + xc, -y + yc));

// Checking and updating parameter
// value based on algorithm
      if (d2 > 0) {
        y--;
        dy = dy - (2 * rx * rx);
        d2 = d2 + (rx * rx) - dy;
      } else {
        y--;
        x++;
        dx = dx + (2 * ry * ry);
        dy = dy - (2 * rx * rx);
        d2 = d2 + dx - dy + (rx * rx);
      }
    }

    int i = 0;
    for (final p in points) {
      i % 10 == 0 ? _canvas.drawCircle(p, 10, _paint) : null;
      i++;
    }
    print(points.length);
    print(x);
    print(y);
  }

  static Path drawEllipsePath(
    Size size, {
    Offset center = Offset.zero,
    double rotation = pi / 4,
  }) {
    final w = size.width, h = size.height;

    Path p = Path()
      ..moveTo(0, h / 2)
      ..quadraticBezierTo(0, 0, w / 2, 0)
      ..quadraticBezierTo(w, 0, w, h / 2)
      ..quadraticBezierTo(w, h, w / 2, h)
      ..quadraticBezierTo(0, h, 0, h / 2)
      ..close();

    final transMatrix = Matrix4.identity()
      ..rotateZ(rotation)
      ..translate(-w / 2, -h / 2);
    p = p.transform(transMatrix.storage);

    return p.shift(center);
  }

  static Path drawEllipseFrontHalf(
    Size size, {
    Offset center = Offset.zero,
    double rotation = pi / 4,
  }) {
    final w = size.width, h = size.height;

    Path p = Path()
      ..moveTo(w / 2, 0)
      ..quadraticBezierTo(w, 0, w, h / 2)
      ..quadraticBezierTo(w, h, w / 2, h);

    final transMatrix = Matrix4.identity()
      ..rotateZ(rotation)
      ..translate(-w / 2, -h / 2);
    p = p.transform(transMatrix.storage);

    return p.shift(center);
  }

  static Path drawEllipseBackHalf(
    Size size, {
    Offset center = Offset.zero,
    double rotation = pi / 4,
  }) {
    final w = size.width, h = size.height;

    Path p = Path()
      ..moveTo(w / 2, h)
      ..quadraticBezierTo(0, h, 0, h / 2)
      ..quadraticBezierTo(0, 0, w / 2, 0);

    final transMatrix = Matrix4.identity()
      ..rotateZ(rotation)
      ..translate(-w / 2, -h / 2);
    p = p.transform(transMatrix.storage);

    return p.shift(center);
  }
}
