import 'dart:io';

class AtomicWriter {
  final String filePath;

  AtomicWriter(this.filePath);

  Future<void> write(String content) async {
    final tempFile = File('$filePath.tmp');
    await tempFile.writeAsString(content);
    await tempFile.rename(filePath);
  }
}
