// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/config/themes/colored_text.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/world_market_viewmodel.dart';

class WorldMarketList extends ConsumerWidget {
  final String listName;
  final bool limit;

  const WorldMarketList(
      {super.key, required this.listName, this.limit = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(worldMarketViewModelProvider);

    final worldmarkets = ref.watch(worldMarketViewModelProvider.notifier).state;

    late List<dynamic> items;
    late String firstField = "";
    late String secondField = "";
    late String thirdField = "";
    late String fourthField = "";
    late bool showArrow;

    switch (listName) {
      case "American Market":
        firstField = "index";
        secondField = "changee";
        thirdField = "quote";
        fourthField = "changepercentage";

        items = worldmarkets.worldMarket.americanmarket;
        showArrow = true;

      case "Europe Market":
        firstField = "index";
        secondField = "changee";
        thirdField = "quote";

        fourthField = "changepercentage";
        items = worldmarkets.worldMarket.europeanMarket;
        showArrow = true;

      case "Forex Market":
        firstField = "currency";
        secondField = "changee";
        thirdField = "rate";
        fourthField = "changepercentage";

        items = worldmarkets.worldMarket.forex;
        showArrow = true;

      case "Crypto Market":
        firstField = "symbol";
        secondField = "currency";
        thirdField = "rate";

        fourthField = "change";
        items = worldmarkets.worldMarket.cryptocurrency;
        showArrow = true;

      case "Asian Market":
        firstField = "index";
        secondField = "changee";
        thirdField = "quote";

        fourthField = "changepercentage";
        items = worldmarkets.worldMarket.asianmarket;
        showArrow = true;

        break;
      default:
        throw ArgumentError("Invalid list name: $listName");
    }

    return state.isLoading
        ? const Center(
            child: LoadingIndicatorWidget(
              size: 40,
              showText: true,
              text: DashboardStrings.loadingStocks,
            ),
          )
        : ListView.builder(
            itemExtent: 62,
            cacheExtent: 2000,
            itemCount: limit ? 6 : items.length,
            itemBuilder: (context, index) => buildListItem(
                items[index],
                firstField,
                secondField,
                thirdField,
                fourthField,
                showArrow,
                context,
                ref),
          );
  }

  Widget buildListItem(
      dynamic item,
      String firstField,
      String secondField,
      String thirdField,
      String fourthField,
      bool showArrow,
      context,
      WidgetRef ref) {
    String getItemField(String field) {
      switch (field) {
        case "currency":
          return item.currency;
        case "symbol":
          return item.symbol;
        case "rate":
          return item.rate.toString();
        case "changee":
          return "Change: ${item.change}";
        case "change":
          return item.change.toString();
        case "index":
          return item.index;
        case "quote":
          return item.quote.toString();
        case "changepercentage":
          return item.changepercentage.toString();
        default:
          throw ArgumentError("Invalid field: $field");
      }
    }

    return InkWell(
      onTap: () async {
        animatednavigateTo(
            context,
            const WebViewPage(
              url: UrlStrings.generalWorldMarket,
              name: "World Markets",
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          color: AppTheme.isDarkMode(context)
              ? AppColors.darktextColor.withOpacity(0.10)
              : AppColors.primaryColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getItemField(firstField),
                  style: AppTextStyles.itemtext1,
                ),
                Text(
                  getItemField(secondField),
                  style: AppTextStyles.itemtext2,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getItemField(thirdField),
                  style: AppTextStyles.itemtext3,
                ),
                if (showArrow)
                  _buildArrowAndPercentage(
                      double.parse(getItemField(fourthField))),
                if (!showArrow)
                  Text(
                    () {
                      final fieldValue = getItemField(fourthField);
                      return fieldValue;
                    }(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: () {
                        return showArrow
                            ? double.parse(getItemField(fourthField)) > 0
                                ? Colors.green
                                : Colors.red
                            : AppTheme.isDarkMode(context)
                                ? AppColors.darktextColor
                                : AppColors.whitetextColor;
                      }(),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowAndPercentage(dynamic item) {
    return Row(
      children: [
        Icon(
          item > 0 ? Icons.arrow_upward : Icons.arrow_downward,
          color: item > 0 ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 4),
        BuildColoredText(
                text: '${item.abs()}%',
                value: item,
                textStyle: AppTextStyles.itemtext3)
            .build(),
      ],
    );
  }
}
