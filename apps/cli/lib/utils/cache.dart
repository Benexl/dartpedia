import 'dart:io';
import 'atomic_writer.dart';
import 'dart:convert';
import 'file.dart';

class Cache {
  final String? cacheDirPath;
  late final Directory dir;

  Cache([this.cacheDirPath]) {
    if (cacheDirPath != null) {
      dir = Directory(expandHome(cacheDirPath!));
    } else {
      dir = Directory(expandHome('~/.dartpedia_cache'));
    }
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  Future<void> save(String key, dynamic data) async {
    await AtomicWriter('${dir.path}/$key.json').write(jsonEncode(data));
  }

  Future<dynamic> get(String key) async {
    final file = File('${dir.path}/$key.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    }
    return null;
  }

  Future<void> clear() async {
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}
