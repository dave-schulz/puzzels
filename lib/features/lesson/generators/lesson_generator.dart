import '../../puzzle/generators/sequence_generator.dart';
import '../models/lesson.dart';

class LessonGenerator {
  LessonGenerator({SequenceGenerator? sequenceGenerator})
      : _sequenceGenerator = sequenceGenerator ?? SequenceGenerator();

  final SequenceGenerator _sequenceGenerator;

  Lesson generate({String title = 'Logic Training'}) {
    final puzzles = _sequenceGenerator.generateSession();

    return Lesson(
      id: 'lesson-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      puzzles: puzzles,
    );
  }
}
