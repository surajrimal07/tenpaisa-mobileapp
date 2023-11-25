// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/asset_model.dart';

class AssetView extends StatefulWidget {
  const AssetView(
      {super.key, required this.assetData, this.fromCommodityPage = false});

  final Asset assetData;
  final bool fromCommodityPage;

  @override
  _AssetViewState createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  //bool _isMounted = false; // Initialize with an empty string
  Map<String, List<FlSpot>> assetChartData = {};

  @override
  void initState() {
    super.initState();
    //_loadAssetData();

    //bool isMounted = false;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    //_isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Asset stockData = widget.assetData;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Hero(
          tag: 'Info', //tag: 'stockName_${stockData.name}',
          child: Text(
            widget.fromCommodityPage ? "Commodity Info" : "Asset Info",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 47,
        automaticallyImplyLeading: true,
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 0),
              Hero(
                tag: 'stockInfo${stockData.name}',
                child: Text(
                  stockData.name,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Hero(
                tag: 'stockSymbol_${stockData.name}',
                child: RichText(
                  text: TextSpan(
                    text: widget.fromCommodityPage
                        ? ''
                        : '(${stockData.symbol}) - ',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: stockData.sector,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 400,
              //   child: Hero(
              //     tag: 'stockInfo_${stockData.name}',
              //     child: !widget.fromCommodityPage
              //         ? WebView(
              //             initialUrl:
              //                 _getWebViewUrl(stockData.symbol, stockData.name),
              //             javascriptMode: JavascriptMode.unrestricted,
              //           )
              //         : Container(),
              //   ),
              // ),
              Visibility(
                visible: !widget.fromCommodityPage,
                child: SizedBox(
                  height: 400,
                  child: Hero(
                    tag: 'stockInfo_${stockData.name}',
                    child: WebView(
                      initialUrl:
                          _getWebViewUrl(stockData.symbol, stockData.name),
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.fromCommodityPage,
                child: Container(),
              ),
              const SizedBox(height: 8),
              Container(
                child: !widget.fromCommodityPage
                    ? ElevatedButton(
                        onPressed: () {
                          _launchURL(context, stockData.symbol, stockData.name);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                        ),
                        child: Text(
                          'Show Advance Chart',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(),
              ),
              const SizedBox(height: 2),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Today's Data",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDetailItem(
                'Asset Type',
                stockData.category ?? "",
              ),
              const SizedBox(height: 8),
              _buildDetailItem(
                'Price',
                'Rs ${stockData.ltp}', //added ? //'\$${stockData.ltp?.toStringAsFixed(2)}',
              ),
              if (widget.fromCommodityPage)
                Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildDetailItem(
                      'Unit',
                      stockData.unit ?? "",
                    ),
                  ],
                ),
              Container(
                child: !widget.fromCommodityPage &&
                        stockData.category != "Metals"
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          _buildDetailItem(
                            'Percentage Change',
                            stockData.percentchange != null
                                ? '${double.parse(stockData.percentchange!).toStringAsFixed(1)}%'
                                : 'N/A',
                          ),
                        ],
                      )
                    : Container(), // An empty container when fromCommodityPage is true
              ),
              Container(
                child: !widget.fromCommodityPage &&
                        stockData.category != "Metals"
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          _buildDetailItem(
                            'Previous Close',
                            '${stockData.previousclose}', //'\$${stockData.eps?.toStringAsFixed(2)}',
                          ),
                        ],
                      )
                    : Container(), // An empty container when fromCommodityPage is true
              ),
              Container(
                child:
                    !widget.fromCommodityPage && stockData.category != "Metals"
                        ? Column(
                            children: [
                              const SizedBox(height: 8),
                              _buildDetailItem(
                                'Trading Quantity',
                                '${stockData.totaltradedquantity}', //'\$${stockData.eps?.toStringAsFixed(2)}',
                              ),
                            ],
                          )
                        : Container(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Placeholder for Buy button action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      backgroundColor: Colors.green[400],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 9.0, // Adjust the vertical padding as needed
                      ),
                      child: Text(
                        'Add to portfolio',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Placeholder for Buy button action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      backgroundColor: Colors.red[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 9.0, // Adjust the vertical padding as needed
                      ),
                      child: Text(
                        'Add to Watchlist',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _getWebViewUrl(String sym, String name) {
    String baseUrl = 'https://www.nepsealpha.com/trading/chart?symbol=';
    String query = Uri.encodeComponent(sym);

    if (widget.fromCommodityPage) {
      return '$baseUrl$query';
    } else if (name == "Fine Gold" || name == "Tejabi Gold") {
      return 'https://www.tradingview.com/chart/?symbol=OANDA%3AXAUUSD';
    } else if (name == "Silver") {
      return 'https://www.tradingview.com/chart/?symbol=TVC%3ASILVER';
    } else {
      return '$baseUrl$query';
    }
  }

  void _launchURL(BuildContext context, sym, name) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: WebView(
              initialUrl: _getWebViewUrl(sym, name),
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),
    ).then((value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
  }
}
