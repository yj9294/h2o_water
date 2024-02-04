

enum TabbarItem {
  drink,
  charts,
  medal,
  profile
}

extension TabbarItemExt on TabbarItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get icon => name;
  String get selectedIcon => "${name}_selected";
}