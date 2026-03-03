import 'dart:io';
import 'logging.dart';

String expandHome(String path) {
  if (path.startsWith('~')) {
    final home = Platform.isWindows
        ? Platform.environment['USERPROFILE']
        : Platform.environment['HOME'];
    if (home == null) throw Exception('Home directory not found');
    // Replace '~/...' or just '~' with the home directory
    logger.info('Expanding path "$path" to home directory "$home"');
    if (path == '~') return home;
    if (path.startsWith('~/')) return '$home${path.substring(1)}';
  }
  return path;
}
