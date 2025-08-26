/// A simple linear interpolation function for doubles.
double lerpDouble(double a, double b, double t) {
  return a + (b - a) * t.clamp(0.0, 1.0);
}
