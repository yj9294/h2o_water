
enum GADPosition {
  open,
  native,
  interstitial;
}

extension GADPositionExt on GADPosition {
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String title() {
    return describeEnum(this);
  }
}
