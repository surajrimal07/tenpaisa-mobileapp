// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';

class CompareView extends ConsumerStatefulWidget {
  const CompareView(
      {super.key, this.selectedPortfolio1, this.selectedPortfolio2});

  final PortfolioEntity? selectedPortfolio1;
  final PortfolioEntity? selectedPortfolio2;

  @override
  CompareViewState createState() => CompareViewState();
}

class CompareViewState extends ConsumerState<CompareView> {
  late PortfolioEntity? _selectedPortfolio1;
  late PortfolioEntity? _selectedPortfolio2;

  @override
  void initState() {
    super.initState();
    _selectedPortfolio1 = widget.selectedPortfolio1;
    _selectedPortfolio2 = widget.selectedPortfolio2;
  }

  @override
  Widget build(BuildContext context) {
    final portfolios = ref
        .watch(portfolioViewModelProvider.notifier)
        .state
        .portfoliosEntity
        .where((portfolio) =>
            portfolio.stocks != null && portfolio.stocks!.isNotEmpty)
        .toList();
    final state = ref.watch(portfolioViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Portfolio'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildDropdownButton(
                    portfolios,
                    _selectedPortfolio1,
                    (portfolio) {
                      setState(() {
                        _selectedPortfolio1 = portfolio;
                      });
                    },
                    'Portfolio 1',
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _buildDropdownButton(
                    portfolios,
                    _selectedPortfolio2,
                    (portfolio) {
                      setState(() {
                        _selectedPortfolio2 = portfolio;
                      });
                    },
                    'Portfolio 2',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildComparisonTable(),
          ),
          if (_selectedPortfolio1 != null && _selectedPortfolio2 != null)
            Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedPortfolio1!.percentage != null &&
                              _selectedPortfolio2!.percentage != null
                          ? 'Portfolio ${_selectedPortfolio1!.percentage! > _selectedPortfolio2!.percentage! ? _selectedPortfolio1!.name : _selectedPortfolio2!.name} has ${(_selectedPortfolio1!.percentage! - _selectedPortfolio2!.percentage!).abs().toStringAsFixed(2)}% higher returns than the other portfolio.'
                          : 'Returns comparison not available',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(
    List<PortfolioEntity> portfolios,
    PortfolioEntity? selectedPortfolio,
    Function(PortfolioEntity?) onChanged,
    String hintText,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.4),
        color: Colors.grey[10],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PortfolioEntity>(
          isExpanded: true,
          hint: Text(hintText),
          value: selectedPortfolio,
          onChanged: onChanged,
          items: portfolios
              .map((portfolio) => DropdownMenuItem(
                    value: portfolio,
                    child: Text(portfolio.name),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    if ((_selectedPortfolio1?.stocks?.isEmpty ?? true) ||
        (_selectedPortfolio2?.stocks?.isEmpty ?? true) ||
        _selectedPortfolio1 == null ||
        _selectedPortfolio2 == null) {
      return const Center(child: EmptyAssetsWidget());
    }

    if (_selectedPortfolio1 == _selectedPortfolio2) {
      return const Center(
        child: Text('Select two different portfolios to compare.'),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          color: Colors.grey[10],
          borderRadius: BorderRadius.circular(10),
        ),
        child: DataTable(
          dividerThickness: 0,
          horizontalMargin: 10,
          columnSpacing: 20,
          dataRowMaxHeight: 60,
          columns: [
            const DataColumn(
              label: Text('Name'),
              numeric: false,
            ),
            DataColumn(
              label: Text(_selectedPortfolio1!.name),
              numeric: false,
            ),
            DataColumn(
              label: Text(_selectedPortfolio2!.name),
              numeric: false,
            ),
          ],
          rows: [
            _buildDataRow(
                'Stocks',
                _selectedPortfolio1!.stocks!.length.toString(),
                _selectedPortfolio2!.stocks!.length.toString()),
            _buildDataRow('Units', _selectedPortfolio1!.totalunits.toString(),
                _selectedPortfolio2!.totalunits.toString()),
            _buildDataRow('Cost', 'Rs ${_selectedPortfolio1!.portfoliocost}',
                'Rs ${_selectedPortfolio2!.portfoliocost}'),
            _buildDataRow('Value', 'Rs ${_selectedPortfolio1!.portfoliovalue}',
                'Rs ${_selectedPortfolio2!.portfoliovalue}'),
            _buildDataRow('Returns', '${_selectedPortfolio1!.percentage}%',
                '${_selectedPortfolio2!.percentage}%'),
            _buildDataRow('Tip', _selectedPortfolio1!.recommendation ?? '',
                _selectedPortfolio2!.recommendation ?? ''),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String label, String value1, String value2) {
    Widget? arrow1;
    Widget? arrow2;

    if (label == 'Returns') {
      final double returns1 = double.tryParse(value1.replaceAll('%', '')) ?? 0;
      final double returns2 = double.tryParse(value2.replaceAll('%', '')) ?? 0;

      if (returns1 != returns2) {
        arrow1 = returns1 > returns2
            ? const Icon(Icons.arrow_upward, color: Colors.green)
            : const Icon(Icons.arrow_downward, color: Colors.red);

        arrow2 = returns1 > returns2
            ? const Icon(Icons.arrow_downward, color: Colors.red)
            : const Icon(Icons.arrow_upward, color: Colors.green);
      }
    }

    return DataRow(
      cells: [
        DataCell(Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
          ],
        )),
        DataCell(Row(
          children: [
            Expanded(child: Text(value1)),
            if (arrow1 != null) arrow1,
          ],
        )),
        DataCell(Row(
          children: [
            Expanded(child: Text(value2)),
            if (arrow2 != null) arrow2,
          ],
        )),
      ],
    );
  }
}
