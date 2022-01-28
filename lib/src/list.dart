
import 'package:quiver/iterables.dart' as quiver;
import 'int.dart';


extension ListExt<E> on List<E> {
  ///
  ///
  /// S - упрощённая
  E? firstWhereS(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
  }

  ///
  ///
  ///
  E? min([int Function(E, E)? comparator]) => quiver.min(this, comparator);

  ///
  ///
  ///
  E? max([int Function(E, E)? comparator]) => quiver.max(this, comparator);

  ///
  /// Generates a new list of elements in random order
  ///
  List<E> toRandomList() {
    final randomIndexes = randomIntList(length, false);
    final randomList = <E>[];
    for (var index in randomIndexes) {
      randomList.add(this[index]);
    }
    return randomList;
  }
}