import 'pattern_cell.dart';

class PatternGrid {
  const PatternGrid({required this.rows});

  final List<List<PatternCellState>> rows;

  int get rowCount => rows.length;

  int get columnCount => rows.isEmpty ? 0 : rows.first.length;

  PatternCellState cellAt(int row, int column) => rows[row][column];
}
