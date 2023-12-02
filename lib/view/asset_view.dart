// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/services/asset_services.dart';
import 'package:paisa/services/portfolio_services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/asset_model.dart';

class AssetView extends StatefulWidget {
  const AssetView({
    super.key,
    required this.assetData,
    this.fromCommodityPage = false,
  });

  final Asset assetData;
  final bool fromCommodityPage;

  @override
  _AssetViewState createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  Asset? fetchedAsset;
  bool isWishlistTapped = false;
  List<Map<String, dynamic>> portfolioData = [];

  @override
  void initState() {
    super.initState();
    _loadPortfolioData();
    if (!widget.fromCommodityPage) {
      fetchData(widget.assetData.symbol);
    }
  }

  _loadPortfolioData() async {
    try {
      List<Map<String, dynamic>> data = await PortfolioService.getPortfolio();
      setState(() {
        portfolioData = data;
      });
    } catch (error) {
      CustomToast.showToast("Portfolio Error");
    }
  }

  Future<void> fetchData(String symbol) async {
    try {
      Asset singleAsset = await SingleAssetData.getSingleAssetData(symbol);

      setState(() {
        fetchedAsset = singleAsset;
      });
    } catch (error) {
      CustomToast.showToast("Error occurred fetching data");
    }
  }

  @override
  Widget build(BuildContext context) {
    Asset stockData = widget.fromCommodityPage
        ? widget.assetData
        : fetchedAsset ?? widget.assetData;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Hero(
            tag: 'Info',
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
            child: fetchedAsset == null && !widget.fromCommodityPage
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          "Loading",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Container(
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
                                child: Row(
                                  children: [
                                    RichText(
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
                                          if (stockData.sector != null &&
                                              stockData.sector!.isNotEmpty)
                                            TextSpan(
                                              text: stockData.sector!.length >
                                                      23
                                                  ? '${stockData.sector!.substring(0, 23)}...' // Limiting the sector name
                                                  : stockData.sector!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (stockData.category != "Vegetables")
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isWishlistTapped =
                                                !isWishlistTapped;
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            isWishlistTapped
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isWishlistTapped
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: stockData.category != "Vegetables",
                                child: SizedBox(
                                  height: 400,
                                  child: Hero(
                                    tag: 'stockInfo_${stockData.name}',
                                    child: WebView(
                                      initialUrl: _getWebViewUrl(
                                          stockData.symbol,
                                          stockData.name,
                                          stockData.category ?? ""),
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
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
                                          _launchURL(
                                              context,
                                              stockData.symbol,
                                              stockData.name,
                                              stockData.category);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              MyColors.primaryColor,
                                        ),
                                        child: Text(
                                          'Show Advance Chart',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                  'Asset Type', stockData.category ?? ""),
                              const SizedBox(height: 8),
                              _buildDetailItem('Price', 'Rs ${stockData.ltp}'),
                              if (widget.fromCommodityPage)
                                Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    _buildDetailItem(
                                        'Unit', stockData.unit ?? ""),
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
                                            fetchedAsset?.percentchange != null
                                                ? '${double.parse(fetchedAsset?.percentchange ?? '0').toStringAsFixed(1)}%'
                                                : 'N/A',
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              Container(
                                child: !widget.fromCommodityPage &&
                                        stockData.category != "Metals"
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            'Previous Close',
                                            '${fetchedAsset?.previousclose}',
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              Container(
                                child: !widget.fromCommodityPage &&
                                        stockData.category != "Metals"
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            'Trading Quantity',
                                            '${fetchedAsset?.totaltradedquantity}',
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: stockData.category != "Vegetables",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showAddStockDialog(
                                            context, stockData.symbol);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        backgroundColor: Colors.green[400],
                                        minimumSize: const Size(100, 42),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          'Add to portfolio',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isWishlistTapped = !isWishlistTapped;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        backgroundColor: Colors.red[300],
                                        minimumSize: const Size(100, 42),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          'Add to Watchlist',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ])));
  }

  void showAddStockDialog(BuildContext context, String stocksymbol) async {
    String? selectedPortfolioId;

    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    FocusNode quantityFocus = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Stock to Portfolio"),
              content: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      hint: const Text('Select Portfolio'),
                      value: selectedPortfolioId,
                      items: portfolioData.map((portfolio) {
                        return DropdownMenuItem<String>(
                          value: portfolio['id'].toString(),
                          child: Text(portfolio['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPortfolioId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a portfolio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: quantityController,
                      focusNode: quantityFocus,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid quantity';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Price'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (selectedPortfolioId != null) {
                        int quantity =
                            int.tryParse(quantityController.text) ?? 0;
                        double price =
                            double.tryParse(priceController.text) ?? 0.0;
                        addStockToPortfolio(
                            selectedPortfolioId!, stocksymbol, quantity, price);
                        Navigator.pop(context);
                      } else {
                        CustomToast.showToast('Please select a portfolio');
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Future<List<String>> getStockSuggestions(String pattern) async {
  //   List<String> stockSymbols = (await AssetData.getAssetData())
  //       .map((asset) => asset.symbol.toString())
  //       .toList();

  //   return stockSymbols
  //       .where((symbol) => symbol.toLowerCase().contains(pattern.toLowerCase()))
  //       .toList();
  // }

  void addStockToPortfolio(
      String ptid, String stSymbol, int qt, double pr) async {
    try {
      await PortfolioService.addtoPort(
          int.parse(ptid), stSymbol, qt, pr.toInt());
      CustomToast.showToast("Stock added successfully");
      setState(() {});
    } catch (error) {
      CustomToast.showToast("Error occured");
    }
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

  String _getWebViewUrl(String sym, String name, String category) {
    String baseUrl = 'https://www.nepsealpha.com/trading/chart?symbol=';
    String query = Uri.encodeComponent(sym);

    if (name == "Fine Gold" || name == "Tejabi Gold") {
      return 'https://www.tradingview.com/chart/?symbol=OANDA%3AXAUUSD';
    } else if (name == "Silver") {
      return 'https://www.tradingview.com/chart/?symbol=TVC%3ASILVER';
    } else {
      return '$baseUrl$query';
    }
  }

  void _launchURL(BuildContext context, sym, name, category) {
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
              initialUrl: _getWebViewUrl(sym, name, category),
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
