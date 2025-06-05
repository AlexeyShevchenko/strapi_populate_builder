/// Enumeration for controlling how arrays are serialized in the query string.
enum ListFormat {
  /// Produces output like: `fields[0]=url&fields[1]=formats`
  indexed,

  /// Produces output like: `fields=url&fields=formats`
  repeat,
}
