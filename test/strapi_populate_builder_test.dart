import 'package:strapi_populate_builder/strapi_populate_builder.dart';
import 'package:test/test.dart';

void main() {
  group('StrapiPopulateBuilder.build', () {
    test('builds query string with nested media/routes/events/image fields', () {
      // Arrange
      final Map<String, dynamic> json = {
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

      // Act
      final query = StrapiPopulateBuilder.build(json);

      // Assert
      expect(
        query,
        'populate%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bevents%5D%5Bpopulate%5D%5Bspot%5D%5Bpopulate%5D=true&populate%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bimage%5D%5Bfields%5D%5B1%5D=formats',
      );
    });

    test('builds query string with nested media/spots/stories/image fields', () {
      // Arrange
      final Map<String, dynamic> json = {
        'populate': {
          'media': {
            'fields': ['url', 'formats'],
          },
          'spots': {
            'populate': {
              'media': {
                'fields': ['url', 'formats'],
              },
              'image': {
                'fields': ['url', 'formats'],
              },
            },
          },
          'stories': {'populate': true},
          'image': {
            'fields': ['url', 'formats'],
          },
        },
      };

      // Act
      final query = StrapiPopulateBuilder.build(json);

      // Assert
      expect(
        query,
        'populate%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspots%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bspots%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspots%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bspots%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Bstories%5D%5Bpopulate%5D=true&populate%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bimage%5D%5Bfields%5D%5B1%5D=formats',
      );
    });

    test(
      'builds query string with nested spot.routes/events/media/city/stories',
      () {
        // Arrange
        final Map<String, dynamic> json = {
          'populate': {
            'spot': {
              'populate': {
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
                'media': {
                  'fields': ['url', 'formats'],
                },
              },
            },
            'city': {'populate': true},
            'stories': {'populate': true},
            'media': {
              'fields': ['url', 'formats'],
            },
          },
        };

        // Act
        final query = StrapiPopulateBuilder.build(json);

        // Assert
        expect(
          query,
          'populate%5Bspot%5D%5Bpopulate%5D%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bspot%5D%5Bpopulate%5D%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspot%5D%5Bpopulate%5D%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bspot%5D%5Bpopulate%5D%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspot%5D%5Bpopulate%5D%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bspot%5D%5Bpopulate%5D%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspot%5D%5Bpopulate%5D%5Bevents%5D%5Bpopulate%5D%5Bspot%5D%5Bpopulate%5D=true&populate%5Bspot%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bspot%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bcity%5D%5Bpopulate%5D=true&populate%5Bstories%5D%5Bpopulate%5D=true&populate%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bmedia%5D%5Bfields%5D%5B1%5D=formats',
        );
      },
    );

    test(
      'builds query string with multiple nested entities (spots, routes, hotels, etc.)',
      () {
        // Arrange
        final Map<String, dynamic> json = {
          'populate': {
            'spots': {
              'populate': {
                'media': {
                  'fields': ['url', 'formats'],
                },
                'image': {
                  'fields': ['url', 'formats'],
                },
              },
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
            'hotels': {
              'populate': {
                'image': {
                  'fields': ['url', 'formats'],
                },
              },
            },
            'stories': {'populate': true},
            'media': {
              'fields': ['url', 'formats'],
            },
            'image': {
              'fields': ['url', 'formats'],
            },
          },
        };

        // Act
        final query = StrapiPopulateBuilder.build(json);

        // Assert
        expect(
          query,
          'populate%5Bspots%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bspots%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspots%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bspots%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Broutes%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Broutes%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bevents%5D%5Bpopulate%5D%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bevents%5D%5Bpopulate%5D%5Bspot%5D%5Bpopulate%5D=true&populate%5Bhotels%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bhotels%5D%5Bpopulate%5D%5Bimage%5D%5Bfields%5D%5B1%5D=formats&populate%5Bstories%5D%5Bpopulate%5D=true&populate%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bimage%5D%5Bfields%5D%5B0%5D=url&populate%5Bimage%5D%5Bfields%5D%5B1%5D=formats',
        );
      },
    );

    test('builds query string with shallow populate = true on all entities', () {
      // Arrange
      final Map<String, dynamic> json = {
        'populate': {
          'media': {
            'fields': ['url', 'formats'],
          },
          'spots': {'populate': true},
          'routes': {'populate': true},
          'events': {'populate': true},
          'hotels': {'populate': true},
          'image': {'populate': true},
        },
      };

      // Act
      final query = StrapiPopulateBuilder.build(json);

      // Assert
      expect(
        query,
        'populate%5Bmedia%5D%5Bfields%5D%5B0%5D=url&populate%5Bmedia%5D%5Bfields%5D%5B1%5D=formats&populate%5Bspots%5D%5Bpopulate%5D=true&populate%5Broutes%5D%5Bpopulate%5D=true&populate%5Bevents%5D%5Bpopulate%5D=true&populate%5Bhotels%5D%5Bpopulate%5D=true&populate%5Bimage%5D%5Bpopulate%5D=true',
      );
    });
  });
}
