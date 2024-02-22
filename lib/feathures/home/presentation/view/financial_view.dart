import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/nrbdata_viewmodel.dart';
import 'package:paisa/feathures/home/presentation/widget/nrb_dialog.dart';

class FinancialDataView extends ConsumerWidget {
  const FinancialDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nrbBankingData =
        ref.watch(nrbDataViewModelProvider).nrbData.nrbBankingData;
    final state = ref.watch(nrbDataViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NRB Indicator",
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
                text: "Loading Financial Data",
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
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    dataRowMaxHeight: 60,
                    dividerThickness: 0.4,
                    columns: const [
                      DataColumn(
                          label: Text('Indicator',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ))),
                      DataColumn(
                          label: Text('Value',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ))),
                    ],
                    rows: [
                      buildDataRow(
                          'Total Deposits', nrbBankingData.totalDeposits),
                      buildDataRow('Commercial Banks Total Deposits',
                          nrbBankingData.commercialBanksTotalDeposits),
                      buildDataRow('Other BFIs Total Deposits',
                          nrbBankingData.otherBfIsTotalDeposits),
                      buildDataRow(
                          'Total Lending', nrbBankingData.totalLending),
                      buildDataRow('Commercial Banks Total Lending',
                          nrbBankingData.commercialBanksTotalLending),
                      buildDataRow('Other BFIs Total Lending',
                          nrbBankingData.otherBfIsTotalLending),
                      buildDataRow('CD Ratio', nrbBankingData.cdRatio),
                      buildDataRow(
                          'Interbank Interest Rate LCY - Weighted Avg.',
                          nrbBankingData.interbankInterestRateLcyWeightedAvg),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  DataRow buildDataRow(String parameter, String value) {
    return DataRow(
      cells: [
        DataCell(Text(parameter)),
        DataCell(Text(value)),
      ],
    );
  }
}
