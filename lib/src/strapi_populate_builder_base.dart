import 'dart:convert';
import 'dart:io';
import 'package:strapi_populate_builder/src/list_format.dart';

/// A utility class for building Strapi-compatible query strings
/// from nested JSON structures or JSON files.
class StrapiPopulateBuilder {
  /// Converts a nested Strapi-style JSON object into a URL query string.
  ///
  /// The [json] parameter must be a valid JSON-like map representing Strapi's
  /// `populate` or related structure (e.g., fields, nested populate).
  ///
  /// Optional parameters:
  /// - [prefix]: A prefix for the query keys (default is '').
  /// - [encode]: Whether to URI-encode keys and values (default is true).
  /// - [maxDepth]: Maximum depth of recursion for nested objects. Set to `null` for unlimited depth.
  ///   Default is 10, to prevent stack overflows or malicious deeply nested structures.
  /// - [listFormat]: Defines how lists are serialized in the query string.
  ///   Use [ListFormat.indexed] for `field[0]=x`, or [ListFormat.repeat] for `field=x&field=y`.
  ///
  /// Throws [ArgumentError] if [maxDepth] is below 0 or if recursion exceeds allowed depth.
  ///
  /// Returns a well-formed query string ready to be appended to a Strapi API URL.
  static String build(
    Map<String, dynamic> json, {
    String prefix = '',
    bool encode = true,
    int? maxDepth = 10,
    ListFormat listFormat = ListFormat.indexed,
  }) {
    if (maxDepth != null && maxDepth < 0) {
      throw ArgumentError.value(maxDepth, 'maxDepth', 'must be ≥ 0 or null');
    }

    final buffer = StringBuffer();

    void write(String key, Object value) {
      final k = encode ? Uri.encodeQueryComponent(key) : key;
      final v = encode ? Uri.encodeQueryComponent(value.toString()) : value;
      buffer
        ..write(k)
        ..write('=')
        ..write(v)
        ..write('&');
    }

    void buildRec(Map<String, dynamic> obj, String path, int depth) {
      if (maxDepth != null && depth > maxDepth) {
        throw ArgumentError('populate tree deeper than $maxDepth levels');
      }

      for (final entry in obj.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value == null ||
            (value is String && value.isEmpty) ||
            (value is Iterable && value.isEmpty)) {
          continue;
        }

        final newPath = path.isEmpty ? key : '$path[$key]';

        if (value is Map<String, dynamic>) {
          buildRec(value, newPath, depth + 1);
        } else if (value is Iterable) {
          int idx = 0;
          for (final item in value) {
            if (item == null) continue;
            switch (listFormat) {
              case ListFormat.indexed:
                if (item is Map<String, dynamic>) {
                  buildRec(item, '$newPath[$idx]', depth + 1);
                } else {
                  write('$newPath[$idx]', item);
                }
                break;
              case ListFormat.repeat:
                if (item is Map<String, dynamic>) {
                  buildRec(item, newPath, depth + 1);
                } else {
                  write(newPath, item);
                }
                break;
            }
            idx++;
          }
        } else {
          write(newPath, value);
        }
      }
    }

    buildRec(json, prefix, 0);

    final qs = buffer.toString();
    return qs.isNotEmpty ? qs.substring(0, qs.length - 1) : qs;
  }

  /// Reads a JSON file from [filePath] and converts its contents into a Strapi-compatible query string.
  ///
  /// The file must contain a valid JSON object at its root. The JSON structure is expected
  /// to follow Strapi's syntax for parameters like `populate`, `fields`, etc.
  ///
  /// Optional parameters behave identically to [build]:
  /// - [prefix]: Prefix for query parameters.
  /// - [encode]: Whether to URI-encode keys and values.
  /// - [maxDepth]: Limits the nesting depth to avoid stack overflows (default: 10).
  /// - [listFormat]: Controls list serialization style.
  ///
  /// Throws:
  /// - [ArgumentError] if the file does not exist.
  /// - [FormatException] if the file does not contain a valid JSON object.
  ///
  /// Returns a `Future<String>` containing the serialized query string.
  static Future<String> buildFromFile(
    String filePath, {
    String prefix = '',
    bool encode = true,
    int? maxDepth = 10,
    ListFormat listFormat = ListFormat.indexed,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw ArgumentError('File not found: $filePath');
    }

    final content = await file.readAsString();
    final json = jsonDecode(content);

    if (json is! Map<String, dynamic>) {
      throw FormatException('Expected root JSON object in file');
    }

    return build(
      json,
      prefix: prefix,
      encode: encode,
      maxDepth: maxDepth,
      listFormat: listFormat,
    );
  }
}
