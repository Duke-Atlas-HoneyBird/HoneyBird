import 'package:uuid/uuid.dart';

/// Centralized utility for generating UUIDs
class UuidUtils {
  static const _uuid = Uuid();

  static String generate() => _uuid.v4();
}
