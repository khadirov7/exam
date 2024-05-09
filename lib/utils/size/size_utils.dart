double height = 0.0;
double width = 0.0;

extension SizeUtils on int {
  double get h => (this / 800) * height;

  double get w => (this / 360) * width;
}
