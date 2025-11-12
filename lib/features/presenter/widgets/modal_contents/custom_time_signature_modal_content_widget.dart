import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ultimate_metronome_pro/design_system/strings/app_strings_portuguese.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/styles/app_text_styles.dart';
import 'package:ultimate_metronome_pro/design_system/dimens/app_spacing.dart';

class CustomTimeSignatureModalContentWidget extends StatelessWidget {
  final MetronomeController controller;

  const CustomTimeSignatureModalContentWidget({super.key, required this.controller});

  static const List<int> _denominatorOptions = [1, 2, 4, 8];

  @override
  Widget build(BuildContext context) {
    final numeratorInitial = (controller.numerator.clamp(1, 16)).toInt();
    final denominatorInitial = _denominatorOptions.contains(controller.denominator) ? controller.denominator : 4;
    final numeratorController = FixedExtentScrollController(initialItem: numeratorInitial - 1);
    final denominatorController = FixedExtentScrollController(
      initialItem: _denominatorOptions.indexOf(denominatorInitial),
    );

    return Padding(
      padding: EdgeInsets.all(AppSpacing.medium(context)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStringsPortuguese.musicalSignature,
              style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(height: AppSpacing.medium(context)),

            Observer(
              builder: (_) {
                return Text(
                  '${controller.numerator}/${controller.denominator}',
                  style: AppTextStyles.appBarTitleTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                );
              },
            ),

            SizedBox(height: AppSpacing.medium(context)),

            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Numerator picker (1..16)
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: CupertinoPicker(
                          scrollController: numeratorController,
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            final value = index + 1;
                            controller.setNumerator(value);
                          },
                          children: List.generate(16, (index) {
                            final value = index + 1;
                            return Center(
                              child: Text(
                                value.toString(),
                                style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),

                  // Denominator picker (1,2,4,8)
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: CupertinoPicker(
                          scrollController: denominatorController,
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            final value = _denominatorOptions[index];
                            controller.setDenominator(value);
                          },
                          children:
                              _denominatorOptions.map((d) {
                                return Center(
                                  child: Text(
                                    d.toString(),
                                    style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.medium(context)),

            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  Text(AppStringsPortuguese.save, style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
