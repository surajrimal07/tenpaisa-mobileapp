// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/services/asset_services.dart';
import 'package:paisa/utils/icons_utils.dart';
import 'package:paisa/view/asset_view.dart';

class DashboardList extends StatelessWidget {
  final BuildContext context;

  const DashboardList({
    super.key,
    required this.context,
    required this.firstitem,
    required this.seconditem,
    required this.thirditem,
    required this.assetList,
    this.trendingList,
    this.arrow,
    this.utils,
    this.type,
  });

  final List<Asset> assetList;
  final List<Asset>? trendingList;
  final firstitem;
  final seconditem;
  final thirditem;
  final arrow;
  final utils;
  final type;

  @override
  Widget build(BuildContext context) {
    List<Asset> displayList = trendingList ?? assetList;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayList.length,
      itemBuilder: (context, index) => buildAssetListItem(
          displayList[index], firstitem, seconditem, thirditem),
    );
  }

  Widget buildAssetListItem(Asset asset, firstitem, seconditem, thirditem) {
    return InkWell(
      onTap: () {
        _onAssetTapped(asset, type);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(Iconss.equityIcon),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.symbol,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FutureBuilder<String>(
                      future: getPropertyValue(firstitem, asset),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            snapshot.data ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder<String>(
                  future: getPropertyValue(seconditem, asset),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String propertyValue = snapshot.data ?? '';
                      String formattedValue = 'Rs $propertyValue';
                      return Text(
                        formattedValue,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<String>(
                  future: getPropertyValue(thirditem, asset),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String propertyValue = snapshot.data ?? '';
                      if (utils == "percentchange") {
                        Widget arrowAndPercentage = _buildArrowAndPercentage(
                          asset.percentchange,
                        );

                        return Row(
                          children: [
                            arrowAndPercentage,
                          ],
                        );
                      } else {
                        return Text(
                          propertyValue,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getPropertyValue(String propertyName, Asset asset) async {
    switch (propertyName) {
      case 'category':
        return asset.category ?? '';
      case 'sector':
        return asset.sector ?? '';
      case 'eps':
        return asset.eps ?? '';
      case 'bookvalue':
        return asset.bookvalue ?? '';
      case 'pe':
        return asset.pe ?? '';
      case 'percentchange':
        return asset.percentchange ?? '';
      case 'ltp':
        return asset.ltp ?? '';
      case 'unit':
        return asset.unit ?? '';
      case 'totaltradedquantity':
        return asset.totaltradedquantity ?? '';
      case 'previousclose':
        return asset.previousclose ?? '';
      case 'turnover':
        return asset.turnover ?? '';
      case 'name':
        if (asset.name.isNotEmpty) {
          return getShortenedName(asset.name);
        } else {
          String missingData =
              await MissingData.getMissingData(asset.symbol, "name");
          return missingData;
        }
      default:
        return '';
    }
  }

  String getShortenedName(String fullName) {
    List<String> words = fullName.split(' ');
    return words.length > 2 ? words.sublist(0, 2).join(' ') : fullName;
  }

  Widget _buildArrowAndPercentage(String? percentChange) {
    double change = double.tryParse(percentChange ?? '0.0') ?? 0.0;

    IconData arrowIcon = Icons.arrow_upward;
    Color arrowColor = Colors.green;

    if (change < 0) {
      arrowIcon = Icons.arrow_downward;
      arrowColor = Colors.red;
    }

    String formattedChange = change.toStringAsFixed(1);

    return Row(
      children: [
        Icon(
          arrowIcon,
          color: arrowColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$formattedChange%',
          style: GoogleFonts.poppins(
            color: arrowColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  void _onAssetTapped(Asset asset, comopage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AssetView(assetData: asset, fromCommodityPage: comopage),
      ),
    );
  }
}
