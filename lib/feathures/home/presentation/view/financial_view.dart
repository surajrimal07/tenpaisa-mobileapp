import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
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
        title: const Text("NRB Indicator"),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildShortTermInterestCard(
                        nrbBankingData.shortTermInterestRates.values),
                    SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: 20,
                        dataRowMaxHeight: 60,
                        dividerThickness: 0.4,
                        columns: [
                          const DataColumn(
                            label: Text(
                              'Indicator',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              nrbBankingData.totalDeposits.keys.elementAt(0),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              nrbBankingData.totalDeposits.keys.elementAt(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          buildDataRow(
                            'Total Deposits',
                            nrbBankingData.totalDeposits,
                          ),
                          buildDataRow(
                            'Commercial Banks Total Deposits',
                            nrbBankingData.commercialBanksTotalDeposits,
                          ),
                          buildDataRow(
                            'Other BFIs Total Deposits',
                            nrbBankingData.otherBfIsTotalDeposits,
                          ),
                          buildDataRow(
                            'Total Lending',
                            nrbBankingData.commercialBanksTotalLending,
                          ),
                          buildDataRow(
                            'Commercial Banks Total Lending',
                            nrbBankingData.commercialBanksTotalLending,
                          ),
                          buildDataRow(
                            'Other BFIs Total Lending',
                            nrbBankingData.otherBfIsTotalLending,
                          ),
                          buildDataRow(
                            'CD Ratio',
                            nrbBankingData.cdRatio,
                          ),
                          buildDataRow(
                            'Interbank Interest',
                            nrbBankingData.interbankInterestRateLcyWeightedAvg,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildShortTermInterestCard(
      Map<String, String> shortTermInterestRates) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Short Term Interest Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: shortTermInterestRates.entries.map((entry) {
                return _buildInfoBox(entry.key, entry.value);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String data) {
    return SizedBox(
      width: Sizes.dynamicWidth(20),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$data%",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  DataRow buildDataRow(String parameter, Map<String, String> values) {
    return DataRow(
      cells: [
        DataCell(Text(parameter)),
        DataCell(Text(values.values.elementAt(0))),
        DataCell(Text(values.values.elementAt(1))),
      ],
    );
  }
}
