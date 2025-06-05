# strapi_populate_builder

[![Pub Version](https://img.shields.io/pub/v/strapi_populate_builder.svg)](https://pub.dev/packages/strapi_populate_builder)
[![Dart SDK](https://img.shields.io/badge/dart-%3E%3D2.17-blue.svg)](https://dart.dev)
[![Build Status](https://img.shields.io/github/actions/workflow/status/AlexeyShevchenko/strapi_populate_builder/ci.yml?branch=main)](https://github.com/AlexeyShevchenko/strapi_populate_builder/actions)

A Dart package for converting nested Strapi `populate` JSON objects into fully encoded query strings compatible with Strapi's REST API.

---

## ✨ Features

- ✅ Converts complex nested `populate` structures into query strings
- ✅ Supports both indexed and repeated list formats
- ✅ Handles URI encoding
- ✅ Optional depth limiting for recursion safety
- ✅ Supports loading from `.json` files
- ✅ Null-safe and Dart 3+ ready

---

## 🚀 Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  strapi_populate_builder: ^0.0.1
```

Import it:

```dart
import 'package:strapi_populate_builder/strapi_populate_builder.dart';
```

---

## 📦 Usage

### Build from a Dart map:

```dart
final query = StrapiPopulateBuilder.build({
  "populate": {
    "media": {
      "fields": ["url", "formats"]
    },
    "routes": {
      "populate": {
        "media": {
          "fields": ["url", "formats"]
        },
        "image": {
          "fields": ["url", "formats"]
        }
      }
    },
    "events": {
      "populate": {
        "media": {
          "fields": ["url", "formats"]
        },
        "spot": {
          "populate": true
        }
      }
    },
    "image": {
      "fields": ["url", "formats"]
    }
  }
});

print(query);
// Outputs something like:
// populate[media][fields][0]=url&populate[media][fields][1]=formats&...
```

---

### Build from a JSON file:

```dart
final query = await StrapiPopulateBuilder.buildFromFile('assets/populate.json');
print(query);
```

---

## ⚙️ Configuration Options

| Parameter   | Description                                               | Default                |
|-------------|-----------------------------------------------------------|------------------------|
| `prefix`    | Optional key prefix for the query string root             | `''`                   |
| `encode`    | Whether to URI encode the output                          | `true`                 |
| `maxDepth`  | Limit the recursive depth (set `null` for unlimited)      | `10`                   |
| `listFormat`| List serialization style (`indexed` or `repeat`)          | `ListFormat.indexed`   |

---

## 📁 Example

See the [example](example/strapi_populate_builder_example.dart) directory for a complete runnable demo.

---

## 🔒 License

MIT © [Your Name](https://github.com/AlexeyShevchenko)
