import '../../../design_system/strings/app_strings_portuguese.dart';

String getTempoName(int bpm) {
  if (bpm < 40) return AppStringsPortuguese.largoTempoString; // Grave/Largo
  if (bpm <= 60) return AppStringsPortuguese.largoTempoString;
  if (bpm <= 76) return AppStringsPortuguese.adagioTempoString;
  if (bpm <= 108) return AppStringsPortuguese.andanteTempoString;
  if (bpm <= 120) return AppStringsPortuguese.moderatoTempoString;
  if (bpm <= 168) return AppStringsPortuguese.allegroTempoString;
  if (bpm <= 200) return AppStringsPortuguese.prestoTempoString;
  return AppStringsPortuguese.prestissimoTempoString;
}