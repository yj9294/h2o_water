
import 'package:h2o_keeper/generated/l10n.dart';

enum ProfileItem {
  reminder,
  language,
  privacy,
  rate 
}

extension ProfileItemExt on ProfileItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get title {
    switch (this) {
      case ProfileItem.reminder:
      return S.current.reminder;
      case ProfileItem.language:
      return S.current.language;
      case ProfileItem.privacy:
      return S.current.privacy;
      case ProfileItem.rate:
      return S.current.rate;
    }
  }
}

enum ProfileTipItem{
  how,
  better,
  when
}

extension ProfileTipItemExt on ProfileTipItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get icon => "profile_$name.png";

  String get title {
    switch (this) {
      case ProfileTipItem.how:
      return S.current.tip_how;
      case ProfileTipItem.better:
      return S.current.tip_better;
      case ProfileTipItem.when:
      return S.current.tip_when;
    }  
  }

  String get description {
    switch (this) {
      case ProfileTipItem.how:
      return S.current.tip_how_descrip;
      case ProfileTipItem.better:
      return S.current.tip_better_descrip;
      case ProfileTipItem.when:
      return S.current.tip_when_descrip;
    }  
  }
}