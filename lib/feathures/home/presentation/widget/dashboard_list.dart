// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/categories_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/commodity_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/metals_viewmodel.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/find_stockentity.dart';

class DashboardList extends ConsumerWidget {
  final String listName;
  final int nameLength;
  final bool limit;

  const DashboardList(
      {super.key,
      required this.listName,
      required this.nameLength,
      this.limit = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesViewModelProvider);
    final metal = ref.watch(metalsViewModelProvider);

    final commodity = ref.watch(commodityViewModelProvider.notifier).state;

    late List<dynamic> items;
    late String firstField = "";
    late String secondField = "";
    late String thirdField = "";
    late String fourthField = "";
    late bool showArrow;
    late int assetType;

    switch (listName) {
      case "Top Gainers":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        fourthField = "percentchange";
        assetType = 0;
        items = state.categories.topGainers;
        showArrow = true;

      case "Top Loosers":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        assetType = 0;
        fourthField = "percentchange";
        items = state.categories.topLoosers;
        showArrow = true;

      case "Top Turnover":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        assetType = 0;
        fourthField = "turnover";
        items = state.categories.topTurnover;
        showArrow = false;

      case "Top Volume":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        assetType = 0;
        fourthField = "volume";
        items = state.categories.topVolume;
        showArrow = false;

      case "Top Transaction":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        assetType = 0;
        fourthField = "transactions";
        items = state.categories.topTrans;
        showArrow = false;

      case "Commodity":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        assetType = 1;
        fourthField = "category";
        items = commodity.commodity;
        showArrow = false;

      case "Metals":
        firstField = "symbol";
        secondField = "name";
        thirdField = "ltp";
        fourthField = "sector";
        assetType = 2;
        items = metal.metals;
        showArrow = false;

        break;
      default:
        throw ArgumentError("Invalid list name: $listName");
    }

    return Scrollbar(
      child: state.isLoading
          ? const Center(
              child: LoadingIndicatorWidget(
                size: 40,
                showText: true,
                text: DashboardStrings.loadingStocks,
              ),
            )
          : ListView.builder(
              cacheExtent: 2000,
              itemCount: limit ? 6 : items.length,
              itemExtent: 60,
              itemBuilder: (context, index) => buildListItem(
                  items[index],
                  firstField,
                  secondField,
                  thirdField,
                  fourthField,
                  showArrow,
                  assetType,
                  context,
                  ref),
            ),
    );
  }

  Widget buildListItem(
      dynamic item,
      String firstField,
      String secondField,
      String thirdField,
      String fourthField,
      bool showArrow,
      int assetType,
      context,
      WidgetRef ref) {
    String getItemField(String field) {
      switch (field) {
        case "name":
          return getShortenedName(item.name, nameLength);
        case "symbol":
          return item.symbol;
        case "ltp":
          return item.ltp.toString();
        case "percentchange":
          return item.percentchange.toString();
        case "turnover":
          return item.turnover.toString();
        case "volume":
          return item.volume.toString();
        case "transactions":
          return item.transactions.toString();
        case "sector":
          return item.sector;
        case "category":
          return item.category;
        default:
          throw ArgumentError("Invalid field: $field");
      }
    }

    return InkWell(
      onTap: () async {
        if (listName != "Metals" && listName != "Commodity") {
          final stock = findStockDetails(item.symbol, ref);
          ref.read(navigationServiceProvider).routeTo(
            '/assetview',
            arguments: {'stockEntity': stock},
          );
        } else if (listName == "Metals") {
          var url = '';

          if (item.symbol != 'Silver') {
            url = UrlStrings.goldUrl;
          } else {
            url = UrlStrings.silverurl;
          }
          animatednavigateTo(
              context,
              WebViewPage(
                url: url,
                name: "Live Gold Price",
              ));
        } else {
          animatednavigateTo(
              context,
              const WebViewPage(
                url: UrlStrings.commoUrl,
                name: "Commodity Price",
              ));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 2),
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
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  getItemField(secondField),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rs ${getItemField(thirdField)}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
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
                        final fieldValue = getItemField(fourthField);
                        return showArrow
                            ? double.parse(fieldValue) > 0
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

  String getShortenedName(String fullName, int nameLength) {
    List<String> characters = fullName.trim().split('');
    String shortenedName = characters.length > nameLength
        ? '${characters.sublist(0, nameLength - 3).join('')}...'
        : fullName;
    return shortenedName;
  }

  Widget _buildArrowAndPercentage(dynamic item) {
    //if (item is double) {
    return Row(
      children: [
        Icon(
          item > 0 ? Icons.arrow_upward : Icons.arrow_downward,
          color: item > 0 ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '${item.abs()}%',
          style: GoogleFonts.poppins(
            color: item > 0 ? Colors.green : Colors.red,
            fontSize: 13,
          ),
        ),
      ],
    );
    // } else if (item is Widget) {
    //   return item;
    // } else {
    //   return Container();
    // }
  }
}
