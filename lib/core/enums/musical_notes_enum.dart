import 'package:ultimate_metronome_pro/design_system/drawables/app_drawables.dart';

enum MusicalNotesEnum {
  wholeNote,
  halfNote,
  quarterNote,
  eighthNote,
  sixteenthNote,
  thirtySecondNote,
  tripletNote,
  tripletRestNote,
}

musicalNoteIconString(type) {
  switch (type) {
    case MusicalNotesEnum.wholeNote:
      return '';
    case MusicalNotesEnum.halfNote:
      return '';
    case MusicalNotesEnum.quarterNote:
      return AppDrawables.quarterIcon;
    case MusicalNotesEnum.eighthNote:
      return AppDrawables.eighthIcon;
    case MusicalNotesEnum.sixteenthNote:
      return AppDrawables.sixteenthIcon;
    case MusicalNotesEnum.thirtySecondNote:
      return '';
    case MusicalNotesEnum.tripletNote:
      return AppDrawables.tripletIcon;
    case MusicalNotesEnum.tripletRestNote:
      return AppDrawables.tripletRestIcon;
    default:
      return '';
  }
}
