// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

class DeletePortfolioDialog extends ConsumerWidget {
  final String portfolioId;
  final String portfolioName;

  const DeletePortfolioDialog(
      {super.key, required this.portfolioId, required this.portfolioName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioViewModelProvider);
    return AlertDialog(
      title: const Text(PortfolioStrings.deletePortfolio),
      content: Text("${PortfolioStrings.deletePortfolioText} $portfolioName?"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(portfolioViewModelProvider.notifier)
                .deletePortfolio(portfolioId);
            Navigator.pop(context);
          },
          child: state.isLoading
              ? const ButtonLoading()
              : const Text(PortfolioStrings.deletePort),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(PortfolioStrings.cancelPortfolio),
        ),
      ],
    );
  }
}
