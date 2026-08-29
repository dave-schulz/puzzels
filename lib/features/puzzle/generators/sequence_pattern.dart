enum SequencePattern {
  add1,
  add2,
  add3,
  multiply2,
  multiply3;

  int next(int value) {
    return switch (this) {
      SequencePattern.add1 => value + 1,
      SequencePattern.add2 => value + 2,
      SequencePattern.add3 => value + 3,
      SequencePattern.multiply2 => value * 2,
      SequencePattern.multiply3 => value * 3,
    };
  }

  bool get isMultiply => this == multiply2 || this == multiply3;
}
