import 'dart:io';
import 'atomic_writer.dart';
import 'dart:convert';
import 'file.dart';
import 'logging.dart';

class Cache {
  final String? cacheDirPath;
  late final Directory dir;

  Cache([this.cacheDirPath]) {
    if (cacheDirPath != null) {
      dir = Directory(expandHome(cacheDirPath!));
    } else {
      dir = Directory(expandHome('~/.dartpedia/cache'));
    }
    logger.info('Initializing cache directory at ${dir.path}');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  Future<void> save(String key, dynamic data) async {
    logger.info('Saving data to cache with key "$key"');
    await AtomicWriter('${dir.path}/$key.json').write(jsonEncode(data));
  }

  Future<dynamic> get(String key) async {
    logger.info('Retrieving data from cache with key "$key"');
    final file = File('${dir.path}/$key.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      logger.info('Cache hit for key "$key"');
      return jsonDecode(content);
    }
    logger.info('Cache miss for key "$key"');
    return null;
  }

  Future<void> clear() async {
    logger.info('Clearing cache directory at ${dir.path}');
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}
