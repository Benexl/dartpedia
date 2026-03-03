import 'dart:io';
import 'logging.dart';

class AtomicWriter {
  final String filePath;

  AtomicWriter(this.filePath);

  Future<void> write(String content) async {
    logger.info('Writing to file $filePath atomically');
    final tempFile = File('$filePath.tmp');
    await tempFile.writeAsString(content);
    await tempFile.rename(filePath);
  }
}
