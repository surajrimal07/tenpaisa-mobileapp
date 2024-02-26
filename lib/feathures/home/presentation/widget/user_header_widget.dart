// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/config/themes/colored_text.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/presentation/state/index_state.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/widget/text_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/state/portfolio_state.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PortfolioCard extends ConsumerWidget {
  const PortfolioCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexState = ref.watch(indexViewModelProvider);
    final state = ref.watch(portfolioViewModelProvider);

    final totalPortfolioReturns =
        state.portfolioDataEntity.totalPortfolioReturns.toDouble();

    bool marketStatus = indexState.index[0].marketStatus == 'Market Open';
    final portfolioIconDetails = _buildIcon(totalPortfolioReturns);

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 2, 3, 4),
      decoration: BoxDecoration(
        color: AppTheme.isDarkMode(context)
            ? AppColors.greyPrimaryColor
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
              indexState.index,
              totalPortfolioReturns,
              marketStatus,
              portfolioIconDetails,
              ref,
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 90,
              child: indexState.isLoading
                  ? const LoadingIndicatorWidget(
                      color: Colors.white, showText: false)
                  : _buildLineChart(indexState.index, context),
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
          _buildMarketTodayRow(indexState, marketStatus),
          _buildMyPortfolioRow(state, totalPortfolioReturns,
              portfolioIconDetails, indexState, ref, marketStatus),
        ],
      ),
    );
  }

  Widget _buildMarketTodayRow(indexState, marketStatus) {
    return GestureDetector(
      onTap: () {
        CustomToast.showToast(
            indexState.index[0].marketStatus ?? "Market Closed");
      },
      child: Row(
        children: [
          Text(
            'Market Today',
            style: AppTextStyles.text16w400White,
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
                        ? AppColors.greenColor
                        : AppColors.redColor),
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
      IndexState indexState,
      WidgetRef ref,
      marketStatus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: marketStatus
              ? [_buildLiveText(ref)]
              : [
                  Skeletonizer(
                    enabled: indexState.isLoading,
                    child: GestureDetector(
                      onTap: () {
                        CustomToast.showToast(
                            indexState.index[0].marketStatus ??
                                "Market Closed");
                      },
                      child: Row(
                        children: [
                          BuildColoredText(
                            text: indexState.index[0].index.toString(),
                            value: indexState.index[0].percentageChange,
                            textStyle: AppTextStyles.text15w500,
                          ).build(),
                          BuildColoredText(
                            text: ' ${indexState.index[0].pointChange}',
                            value: indexState.index[0].percentageChange,
                            textStyle: AppTextStyles.text15w500,
                          ).build(),
                          Icon(
                            _buildIcon(
                                indexState.index[0].percentageChange)['icon'],
                            color: _buildIcon(
                                indexState.index[0].percentageChange)['color'],
                            size: _buildIcon(
                                indexState.index[0].percentageChange)['size'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
        ),
        Text(
          'My Portfolio',
          style: AppTextStyles.text17w400White,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 1),
        GestureDetector(
          onTap: () => ref.read(selectedIndexProvider.notifier).state = 2,
          child: Skeletonizer(
            enabled: state.isLoading,
            child: totalPortfolioReturns == 0.0
                ? Text(
                    'Empty Portfolio',
                    style: AppTextStyles.text16w400White,
                  )
                : RichText(
                    text: TextSpan(
                      children: [
                        buildTextSpan(
                          text:
                              'Rs ${totalPortfolioReturns.toStringAsFixed(0)}',
                          value: totalPortfolioReturns,
                          fontSize: 16,
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

          return Skeletonizer(
            enabled: snapshot.connectionState == ConnectionState.waiting,
            child: Row(
              children: [
                BuildColoredText(
                        text: indexData.index.toString(),
                        value: indexData.percentageChange,
                        textStyle: AppTextStyles.text15w500)
                    .build(),
                BuildColoredText(
                        text: ' ${indexData.percentageChange.toString()}%',
                        value: indexData.percentageChange,
                        textStyle: AppTextStyles.text15w500)
                    .build(),
                Icon(
                  _buildIcon(indexData.percentageChange)['icon'],
                  color: _buildIcon(indexData.percentageChange)['color'],
                  size: _buildIcon(indexData.percentageChange)['size'],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error Fetching Live Data',
            style: AppTextStyles.text15w500White,
            textAlign: TextAlign.left,
          );
        } else {
          return const SizedBox.shrink();
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
      iconColor = AppColors.greenColor;
    } else {
      iconData = Icons.arrow_downward;
      iconColor = AppColors.redColor;
    }

    return {
      'icon': iconData,
      'color': iconColor,
      'size': 16.0,
    };
  }
}
