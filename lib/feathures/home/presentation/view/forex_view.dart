import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/domain/entity/currency_entity.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/nrbdata_viewmodel.dart';
import 'package:paisa/feathures/home/presentation/widget/nrb_dialog.dart';

class ForexDataView extends ConsumerWidget {
  const ForexDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nrbForexData =
        ref.watch(nrbDataViewModelProvider).nrbData.nrbForexData;
    final state = ref.watch(nrbDataViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forex Data",
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DataSourceDialog();
                },
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(
              child: LoadingIndicatorWidget(
                size: 50,
                showText: true,
                text: "Loading Forex Data",
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(nrbDataViewModelProvider.notifier)
                    .getNrbData(true);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: nrbForexData.currencyData.length,
                  itemBuilder: (context, index) {
                    final currency = nrbForexData.currencyData[index];
                    return _buildCurrencyCard(currency);
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildCurrencyCard(CurrencyEntity currency) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 191, 215, 233),
                Color.fromARGB(255, 117, 155, 188)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currency.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Sizes.dynamicHeight(1)),
                Text("Unit: ${currency.unit}"),
                Text("Buy: NPR ${currency.buy}"),
                Text("Sell: NPR ${currency.sell}"),
              ],
            ),
          ),
        ));
  }
}
