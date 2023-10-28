
class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}

List<Point> get points {
  final data = <double>[2, 4, 6, 11, 3, 6, 4];
  return data.map((index) => Point(x: index.toDouble(), y: index)).toList();
}
