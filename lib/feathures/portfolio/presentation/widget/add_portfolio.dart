// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

class CreatePortfolioDialog extends ConsumerWidget {
  const CreatePortfolioDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(othersControllerProvider);
    final goalController = ref.watch(quantityControllerProvider);
    final state = ref.watch(portfolioViewModelProvider);
    final formKey = ref.watch(formKeyProvider);

    return AlertDialog(
      title: const Text(PortfolioStrings.createPortfolio),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: PortfolioStrings.portfolioName),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return PortfolioStrings.emptyPortfolio;
                }
                return null;
              },
            ),
            SizedBox(height: Sizes.dynamicHeight(1.2)),
            TextFormField(
              controller: goalController,
              decoration: const InputDecoration(
                  labelText: PortfolioStrings.portfolioGoal),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return PortfolioStrings.emptyGoal;
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
              await ref
                  .read(portfolioViewModelProvider.notifier)
                  .createPortfolio(nameController.text, goalController.text);

              // if (success) {
              //   nameController.clear();
              //   goalController.clear();
              //   Navigator.pop(context);
              // }
              if (state.error == null) {
                nameController.clear();
                goalController.clear();
                Navigator.pop(context);
              }
            }
            // if (!state.isLoading && state.error == null) {
            //   //this is not working so we might manually check the state
            //   // and if change is detected then close this dialog box
            //   nameController.clear();
            //   goalController.clear();
            //   Navigator.pop(context);
            // }
          },
          child: state.isLoading
              ? const ButtonLoading()
              : const Text(PortfolioStrings.savePortfolio),
        ),
        ElevatedButton(
          onPressed: () {
            nameController.clear();
            goalController.clear();
            Navigator.pop(context);
          },
          child: const Text(PortfolioStrings.cancelPortfolio),
        ),
      ],
    );
  }
}
