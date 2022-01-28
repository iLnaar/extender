
class Path {
  late final String full;
  late final String folder;
  late final String fileName;

  Path.fromFullPath(String fullPath) {
    full = fullPath.trim();
    final lastSlash1 = full.lastIndexOf('\\');
    final lastSlash2 = full.lastIndexOf('/');
    final lastSlash = lastSlash1 >= lastSlash2 ? lastSlash1 + 1: lastSlash2 + 1;
    if (lastSlash == -1) {
      throw 'Bad full path to file: "$full"';
    }
    folder = full.substring(0, lastSlash);
    fileName = full.substring(lastSlash);
  }
}