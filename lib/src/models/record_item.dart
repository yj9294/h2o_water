
enum RecordItem {
  water,
  drinks,
  milk,
  coffee,
  tea,
  customization
}

extension RecordItemExt on RecordItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get title {
    return name.capitalize();
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
}