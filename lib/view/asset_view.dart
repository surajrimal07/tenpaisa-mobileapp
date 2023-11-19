// // asset_view.dart

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:paisa/utils/colors_utils.dart';
// import '../model/asset_model.dart';
// import '../services/asset_services.dart';

// class Stock {
//   final String symbol;
//   final String name;
//   final String sector;
//   final String assetType;
//   final double price;
//   final double percentageChange;
//   final double eps;
//   //final List<double> priceLast7Days;

//   Stock({
//     required this.symbol,
//     required this.name,
//     required this.sector,
//     required this.assetType,
//     required this.price,
//     required this.percentageChange,
//     required this.eps,
//     //required this.priceLast7Days,
//   });
// }

// class AssetView extends StatefulWidget {
//   const AssetView({super.key, required this.stockData});
//   final Stock stockData;

//   @override
//   _AssetViewState createState() => _AssetViewState();
// }

// class _AssetViewState extends State<AssetView> {
//   String symbol = "";
//   String name = "";
//   String sector = "";
//   String category = "";
//   double ltp = 0;
//   double percentageChange = 0;
//   double previousclose = 0;
//   double totaltradedquantity = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: MyColors.btnColor,
//       statusBarIconBrightness: Brightness.light,
//       systemNavigationBarColor: MyColors.btnColor,
//       systemNavigationBarIconBrightness: Brightness.light,
//     ));
//   }

//   Future<void> _loadUserData() async {
//     List<Map<String, dynamic>> fetchedAssets =
//         await AssetService.getassets(stockData);

//     //fetchedSymbols.sort((a, b) => a['name'].compareTo(b['name']));

//     setState(() {
//       symbol = fetchedAssets['symbol'] ?? "";
//       name = fetchedAssets['name'];
//       sector = fetchedAssets['sector'];
//       category = fetchedAssets['category'];
//       ltp = fetchedAssets['ltp'] ?? "";
//       percentageChange = fetchedAssets['percentageChange'];
//       previousclose = fetchedAssets['previousclose'];
//       totaltradedquantity = fetchedAssets['totaltradedquantity'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Stock stockData = widget.stockData;

//     return Scaffold(
//       appBar: AppBar(
//         title: Hero(
//           tag: 'stockName_${stockData.name}',
//           child: Text(
//             stockData.name,
//             style: GoogleFonts.poppins(color: Colors.white),
//           ),
//         ),
//         centerTitle: true,
//         toolbarHeight: 47,
//         automaticallyImplyLeading: true,
//         backgroundColor: MyColors.btnColor,
//         iconTheme: const IconThemeData(color: Colors.black),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.black,
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 0),
//               Hero(
//                 tag: 'stockInfo${stockData.name}',
//                 child: Text(
//                   stockData.name,
//                   style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Hero(
//                 tag: 'stockSymbol_${stockData.name}',
//                 child: Text(
//                   '(${stockData.symbol}) - ${stockData.sector}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               SizedBox(
//                 height: 200,
//                 child: Hero(
//                   tag: 'stockInfo_${stockData.name}',
//                   child: LineChart(
//                     LineChartData(
//                       gridData: FlGridData(
//                         show: true,
//                         drawHorizontalLine: true,
//                         drawVerticalLine: true,
//                       ),
//                       titlesData: FlTitlesData(show: false),
//                       borderData: FlBorderData(
//                         show: true,
//                         border: Border.all(color: Colors.white),
//                       ),
//                       lineBarsData: [
//                         // LineChartBarData(
//                         //   spots: _generateSpots(stockData.priceLast7Days),
//                         //   isCurved: true,
//                         //   colors: [Colors.white],
//                         //   dotData: FlDotData(show: false),
//                         //   belowBarData: BarAreaData(show: false),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: () {
//                   // Placeholder for the "Hello" button action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.primaryColor,
//                 ),
//                 child: Text(
//                   'show advance chart',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Text(
//                         "Today's Data",
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildDetailItem(
//                 'Asset Type',
//                 stockData.assetType,
//               ),
//               const SizedBox(height: 8),
//               _buildDetailItem(
//                 'Price',
//                 '\$${stockData.price.toStringAsFixed(2)}',
//               ),
//               const SizedBox(height: 8),
//               _buildDetailItem(
//                 'Percentage Change',
//                 '${stockData.percentageChange}%',
//               ),
//               const SizedBox(height: 8),
//               _buildDetailItem(
//                 'EPS',
//                 '\$${stockData.eps.toStringAsFixed(2)}',
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Placeholder for Buy button action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       backgroundColor: Colors.green[400],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0,
//                         vertical: 9.0, // Adjust the vertical padding as needed
//                       ),
//                       child: Text(
//                         'Buy',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Placeholder for Sell button action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       backgroundColor: Colors.red,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0,
//                         vertical: 9.0, // Adjust the vertical padding as needed
//                       ),
//                       child: Text(
//                         'Sell',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailItem(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   List<FlSpot> _generateSpots(List<double> prices) {
//     return List.generate(
//         prices.length, (index) => FlSpot(index.toDouble(), prices[index]));
//   }
// }

// asset_view.dart
// asset_view.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/utils/colors_utils.dart';

import '../model/asset_model.dart';
import '../services/asset_services.dart';

class AssetView extends StatefulWidget {
  const AssetView({super.key, required this.assetData});
  final Asset assetData;

  @override
  _AssetViewState createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  bool _isMounted = false;
  String symbol = "";
  String name = "";
  String sector = "";
  String category = "";
  double ltp = 0;
  double percentageChange = 0;
  double previousclose = 0;
  double totaltradedquantity = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    bool isMounted = false;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> _loadUserData() async {
    try {
      List<Map<String, dynamic>> fetchedAssets =
          await AssetService.getassets(widget.assetData.symbol);

      if (_isMounted && fetchedAssets.isNotEmpty) {
        final Map<String, dynamic> assetData = fetchedAssets[0];

        setState(() {
          symbol = assetData['symbol'] ?? "";
          name = assetData['name'];
          sector = assetData['sector'];
          category = assetData['category'];
          ltp = double.parse(assetData['ltp'] ?? '0');
          percentageChange = double.parse(assetData['percentchange'] ?? '0');
          previousclose = double.parse(assetData['previousclose'] ?? '0');
          totaltradedquantity =
              double.parse(assetData['totaltradedquantity'] ?? '0');
        });
      }
    } catch (error) {
      if (_isMounted) {
        print('Error loading user data: $error');
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Asset stockData = widget.assetData;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'Info', //tag: 'stockName_${stockData.name}',
          child: Text(
            "Asset Info",
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
        child: Container(
          color: Colors.black,
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
                child: Text(
                  '(${stockData.symbol}) - ${stockData.sector}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 200,
                child: Hero(
                  tag: 'stockInfo_${stockData.name}',
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                      ),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.white),
                      ),
                      lineBarsData: [
                        // LineChartBarData(
                        //   spots: _generateSpots(stockData.priceLast7Days),
                        //   isCurved: true,
                        //   colors: [Colors.white],
                        //   dotData: FlDotData(show: false),
                        //   belowBarData: BarAreaData(show: false),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Placeholder for the "Hello" button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                ),
                child: Text(
                  'show advance chart',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
              const SizedBox(height: 8),
              _buildDetailItem(
                'Percentage Change',
                '${percentageChange.toStringAsFixed(2)}%',
              ),
              const SizedBox(height: 8),
              _buildDetailItem(
                'Previous Close',
                '${stockData.previousclose}', //'\$${stockData.eps?.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8),
              _buildDetailItem(
                'Trading Quantity',
                '${stockData.totaltradedquantity}', //'\$${stockData.eps?.toStringAsFixed(2)}',
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
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Placeholder for Sell button action
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(4.0),
                  //     ),
                  //     backgroundColor: Colors.red,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 20.0,
                  //       vertical: 9.0, // Adjust the vertical padding as needed
                  //     ),
                  //     child: Text(
                  //       'Sell',
                  //       style: GoogleFonts.poppins(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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

  List<FlSpot> _generateSpots(List<double> prices) {
    return List.generate(
        prices.length, (index) => FlSpot(index.toDouble(), prices[index]));
  }
}
