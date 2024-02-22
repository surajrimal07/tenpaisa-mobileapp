// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

class RenamePortfolioDialog extends ConsumerWidget {
  final String portfolioId;
  final String oldPortfolioName;

  const RenamePortfolioDialog(
      {super.key, required this.oldPortfolioName, required this.portfolioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(formKeyProvider);
    final controller = ref.watch(othersControllerProvider);
    final state = ref.watch(portfolioViewModelProvider);

    return AlertDialog(
      title: const Text(PortfolioStrings.editPortfolioName),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${PortfolioStrings.oldPortfolioName}$oldPortfolioName"),
            SizedBox(height: Sizes.dynamicHeight(1.2)),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  labelText: PortfolioStrings.newPortfolioName),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return PortfolioStrings.emptyPortfolio;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() == true) {
              String portfolioName = controller.text;

              await ref
                  .read(portfolioViewModelProvider.notifier)
                  .renamePortfolio(portfolioId, portfolioName);

              controller.clear();
              Navigator.pop(context);
            }
          },
          child: state.isLoading
              ? const ButtonLoading()
              : const Text(PortfolioStrings.savePortfolio),
        ),
        ElevatedButton(
          onPressed: () {
            controller.clear();
            Navigator.pop(context);
          },
          child: const Text(PortfolioStrings.cancelPortfolio),
        ),
      ],
    );
  }
}
