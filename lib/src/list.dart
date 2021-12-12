
import 'package:quiver/iterables.dart' as quiver;

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
}