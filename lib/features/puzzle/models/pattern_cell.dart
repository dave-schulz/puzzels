enum PatternCellState {
  filled,
  empty,
  unknown;

  String get label => switch (this) {
        PatternCellState.filled => '⬛',
        PatternCellState.empty => '⬜',
        PatternCellState.unknown => '?',
      };
}
