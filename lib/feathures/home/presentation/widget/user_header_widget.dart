// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/presentation/state/index_state.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/state/portfolio_state.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

class PortfolioCard extends ConsumerWidget {
  const PortfolioCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexState = ref.watch(indexViewModelProvider);
    final state = ref.watch(portfolioViewModelProvider);
    final index = indexState.index;
    final totalPortfolioReturns = ref
        .watch(portfolioViewModelProvider.notifier)
        .state
        .portfolioDataEntity
        .totalPortfolioReturns
        .toDouble();

    bool marketStatus = index[0].marketStatus == 'Market Open';
    final portfolioIconDetails = _buildIcon(totalPortfolioReturns);

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 2, 3, 4),
      decoration: BoxDecoration(
        color: AppTheme.isDarkMode(context)
            ? AppColors.darkbackgroundColor
            : AppColors.primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildPortfolioDetails(
              indexState,
              state,
              index,
              totalPortfolioReturns,
              marketStatus,
              portfolioIconDetails,
              ref,
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: Sizes.dynamicHeight(14),
              child: indexState.isLoading
                  ? const LoadingIndicatorWidget(
                      color: Colors.white,
                      size: 40,
                      showText: false,
                      text: PortfolioStrings.loadingPortfolios,
                    )
                  : _buildLineChart(index, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioDetails(
    IndexState indexState,
    PortfolioState state,
    List<IndexEntity> index,
    double totalPortfolioReturns,
    bool marketStatus,
    Map<String, dynamic> portfolioIconDetails,
    WidgetRef ref,
  ) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMarketTodayRow(index, indexState, marketStatus),
          _buildMyPortfolioRow(state, totalPortfolioReturns,
              portfolioIconDetails, indexState, ref, marketStatus, index),
        ],
      ),
    );
  }

  Widget _buildMarketTodayRow(
      List<IndexEntity> index, indexState, bool marketStatus) {
    return GestureDetector(
      onTap: () {
        CustomToast.showToast(index[0].marketStatus ?? "Market Closed");
      },
      child: Row(
        children: [
          Text(
            'Market Today',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
          if (!indexState.isLoading)
            SizedBox(
              width: 20,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: marketStatus
                      ? Colors.green
                      : const Color.fromARGB(255, 235, 117, 109),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMyPortfolioRow(
      PortfolioState state,
      double totalPortfolioReturns,
      Map<String, dynamic> portfolioIconDetails,
      indexState,
      WidgetRef ref,
      marketStatus,
      index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: marketStatus
              ? [_buildLiveText(ref)]
              : [
                  if (indexState.isLoading)
                    Text(
                      'Loading...',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        CustomToast.showToast(
                            index[0].marketStatus ?? "Market Closed");
                      },
                      child: Row(
                        children: [
                          Text(
                            index[0].index.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color:
                                  _buildArrowColor(index[0].percentageChange),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            ' ${index[0].pointChange}', //when market if off we always have pointchangeS

                            // index[0].pointChange != null
                            //     ? ' ${index[0].pointChange}'
                            //     : ' ${index[0].index - index[1].index}',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color:
                                  _buildArrowColor(index[0].percentageChange),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Icon(
                            _buildIcon(index[0].percentageChange)['icon'],
                            color:
                                _buildIcon(index[0].percentageChange)['color'],
                            size: _buildIcon(index[0].percentageChange)['size'],
                          ),
                        ],
                      ),
                    ),
                ],
        ),
        Text(
          'My Portfolio',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 1),
        GestureDetector(
          onTap: () => ref.read(selectedIndexProvider.notifier).state = 2,
          child: totalPortfolioReturns == 0.0
              ? const Text(
                  'Empty Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: state.isLoading
                            ? 'Loading...'
                            : 'Rs ${totalPortfolioReturns.toStringAsFixed(1)} ',
                        style: GoogleFonts.poppins(
                          color: state.isLoading
                              ? Colors.white
                              : _buildArrowColor(totalPortfolioReturns),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (!state.isLoading)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              portfolioIconDetails['icon'],
                              color: portfolioIconDetails['color'],
                              size: portfolioIconDetails['size'],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildLiveText(WidgetRef ref) {
    final indexLiveData = ref.watch(indexLiveViewModelProvider);

    return StreamBuilder<IndexEntity>(
      stream: indexLiveData.indexDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final indexData = snapshot.data!;

          return Row(
            children: [
              Text(
                indexData.index.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _buildArrowColor(indexData.percentageChange),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                ' ${indexData.percentageChange.toString()}%',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _buildArrowColor(indexData.percentageChange),
                ),
                textAlign: TextAlign.left,
              ),
              Icon(
                _buildIcon(indexData.percentageChange)['icon'],
                color: _buildIcon(indexData.percentageChange)['color'],
                size: _buildIcon(indexData.percentageChange)['size'],
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Loading Live Data',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error Fetching Live Data',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLineChart(List<IndexEntity> index, context) {
    return GestureDetector(
      onDoubleTap: () => {
        animatednavigateTo(
            context,
            const WebViewPage(
              url: UrlStrings.nepseUrl,
              name: 'Nepse Chart',
            ))
      },
      onTap: () => {
        CustomToast.showToast("Double Tap to view chart", customType: Type.info)
      },
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < 14; i++)
                  FlSpot(i.toDouble(), index[14 - i].index.toDouble()),
              ],
              isCurved: true,
              colors: [Colors.white],
              barWidth: 1,
              curveSmoothness: 0.1,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 0),
                gradientTo: const Offset(0, 1),
                colors: [
                  Colors.white.withOpacity(0.2),
                  AppColors.primaryColor.withOpacity(0.5),
                ],
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _buildIcon(dynamic data) {
    double numericData;
    if (data is num) {
      numericData = data.toDouble();
    } else {
      numericData = data;
    }

    IconData iconData;
    Color iconColor;

    if (numericData > 0) {
      iconData = Icons.arrow_upward;
      iconColor = const Color.fromARGB(255, 123, 228, 126);
    } else {
      iconData = Icons.arrow_downward;
      iconColor = const Color.fromARGB(255, 248, 144, 144);
    }

    return {
      'icon': iconData,
      'color': iconColor,
      'size': 16.0,
    };
  }

  Color _buildArrowColor(data) {
    return data > 0
        ? const Color.fromARGB(255, 123, 228, 126)
        : const Color.fromARGB(255, 248, 144, 144);
  }
}
