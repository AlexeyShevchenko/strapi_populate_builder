// Example usage of the StrapiPopulateBuilder package.
// This demonstrates how to convert a nested JSON `populate` object
// into a Strapi-compatible query string, both from a Dart `Map`
// and from a JSON file.

import 'package:strapi_populate_builder/strapi_populate_builder.dart';

Future<void> main() async {
  // Example 1: Build query string from a Dart Map
  final populateMap = {
    'populate': {
      'media': {
        'fields': ['url', 'formats'],
      },
      'routes': {
        'populate': {
          'media': {
            'fields': ['url', 'formats'],
          },
          'image': {
            'fields': ['url', 'formats'],
          },
        },
      },
      'events': {
        'populate': {
          'media': {
            'fields': ['url', 'formats'],
          },
          'spot': {'populate': true},
        },
      },
      'image': {
        'fields': ['url', 'formats'],
      },
    },
  };

  final queryFromMap = StrapiPopulateBuilder.build(populateMap);
  print('Query from Dart Map:\n$queryFromMap\n');

  // Example 2: Build query string from a JSON file
  //
  // The file should contain a valid JSON object with a similar structure
  // as shown above. You can place the file in the project root or assets directory.
  //
  // Example file content (populate.json):
  // {
  //   "populate": {
  //     "media": {
  //       "fields": ["url", "formats"]
  //     },
  //     "stories": {
  //       "populate": true
  //     }
  //   }
  // }
  const filePath = 'example/populate.json'; // Adjust path if needed
  try {
    final queryFromFile = await StrapiPopulateBuilder.buildFromFile(filePath);
    print('Query from JSON file:\n$queryFromFile');
  } catch (e) {
    print('Could not load JSON from file: $e');
  }
}
