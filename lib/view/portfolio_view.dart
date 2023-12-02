// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:paisa/app/common/drawer_common.dart';
import 'package:paisa/app/common/navbar_common.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/services/asset_services.dart';
import 'package:paisa/services/portfolio_services.dart';
import 'package:paisa/utils/colors_utils.dart';

import './portfoliodetail_view.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  PortfolioScreenState createState() => PortfolioScreenState();
}

class PortfolioScreenState extends State<PortfolioView> {
  int indexBottomBar = 2;
  List<Map<String, dynamic>> portfolioData = [];

  @override
  void initState() {
    super.initState();
    _loadPortfolioData();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Portfolios',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.black),
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(5),
              child: portfolioData.isNotEmpty
                  ? Column(
                      children: [
                        if (portfolioData.isNotEmpty) _buildSummaryCard(),
                        for (var portfolio in portfolioData)
                          _buildPortfolioContainer(portfolio),
                      ],
                    )
                  : const Text(
                      'No portfolio',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
            ),
          ),
        ),
      ),
      drawer: const CommonDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 2) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.wishlistRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width / 1.5,
              398.0,
              0.0,
              0.0,
            ),
            items: [
              PopupMenuItem<String>(
                value: 'createPortfolio',
                onTap: () => _showCreatePortfolioDialog(),
                child: const Row(
                  children: [
                    Icon(Icons.create),
                    SizedBox(width: 8),
                    Text('Create Portfolio'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'addStock',
                onTap: () => showAddStockDialog(context),
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add Stock'),
                  ],
                ),
              ),
            ],
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: MyColors.btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: const Icon(Icons.add_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSummaryCard() {
    if (portfolioData.isEmpty) {
      return Container();
    }

    num totalPortfolioCost = 0;
    num totalPortfolioValue = 0;
    num totalUnits = 0;
    num totalPortGainLoss = 0;

    for (var portfolio in portfolioData) {
      totalPortfolioCost += portfolio['portfoliocost'] ?? 0;
      totalPortfolioValue += portfolio['portfoliovalue'] ?? 0;
      totalUnits += portfolio['totalunits'] ?? 0;
    }
    totalPortGainLoss = totalPortfolioValue - totalPortfolioCost;

    Color cardColor = totalPortGainLoss >= 0
        ? const Color.fromARGB(255, 177, 227, 120)
        : const Color.fromARGB(255, 244, 121, 112);

    return Card(
      margin: const EdgeInsets.all(0), // No margin
      color: cardColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    const TextSpan(
                        text: 'Summary',
                        style:
                            TextStyle(color: Color.fromARGB(255, 47, 45, 45))),
                    TextSpan(
                      text:
                          ' (as of ${DateFormat('yyyy-MM-dd').format(DateTime.now())})',
                      style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Number of Portfolios: ${portfolioData.length}',
                style: const TextStyle(fontSize: 15),
              ),
              Text('Portfolio Cost: Rs $totalPortfolioCost',
                  style: const TextStyle(fontSize: 15)),
              Text('Portfolio Value: Rs $totalPortfolioValue',
                  style: const TextStyle(fontSize: 15)),
              Text('Total Units: $totalUnits',
                  style: const TextStyle(fontSize: 15)),
              Text('Port Gain Loss: Rs $totalPortGainLoss',
                  style: const TextStyle(fontSize: 15)),
              const Text('Recommendation: Rebalancing Required!',
                  style: TextStyle(fontSize: 15)), //add recommendation later
            ],
          ),
        ),
      ),
    );
  }

  _buildPortfolioContainer(Map<String, dynamic> portfolio) {
    List<dynamic> gainLossRecords = portfolio['gainLossRecords'];
    Map<String, dynamic>? lastRecord =
        gainLossRecords.isNotEmpty ? gainLossRecords.last : null;

    Color backgroundColor = lastRecord != null && lastRecord['portgainloss'] > 0
        ? const Color.fromARGB(255, 177, 227, 120)
        : lastRecord != null && lastRecord['portgainloss'] < 0
            ? const Color.fromARGB(255, 244, 121, 112)
            : Colors.transparent;

    return GestureDetector(
        onTap: () {
          // Navigate to PortfolioDetailView when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PortfoliodetailView(
                portfolioId: portfolio['id'].toString(),
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 0.1,
            ),
            color: backgroundColor,
          ),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${portfolio['name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(Rs ${lastRecord?['portgainloss']})',
                        style: const TextStyle(
                          fontSize: 14, // Adjust the font size as needed
                          fontWeight: FontWeight
                              .normal, // You can adjust other styles here
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    // onSelected: (value) {
                    //   // Handle the selected menu item
                    //   switch (value) {
                    //     case 'rename':
                    //       // Handle rename portfolio
                    //       break;
                    //     case 'addAsset':
                    //       // Handle add asset
                    //       break;
                    //     case 'removeAsset':
                    //       // Handle remove asset
                    //       break;
                    //     case 'deletePortfolio':
                    //       // Handle delete portfolio
                    //       break;
                    //     case 'comparePortfolio':
                    //       // Handle compare portfolio
                    //       break;
                    //     case 'view':
                    //       // Navigate to PortfolioDetailView()
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const PortfoliodetailView()),
                    //       );
                    //       break;
                    //   }
                    // },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'addAsset',
                          onTap: () => showAddStockDialog(context,
                              portid: portfolio['id'].toString()),
                          child: const Text('Add Asset'),
                        ),
                        PopupMenuItem<String>(
                          value: 'removeAsset',
                          onTap: () => _showDeleteStockDialog(),
                          child: const Text('Remove Asset'),
                        ),
                        PopupMenuItem<String>(
                          value: 'deletePortfolio',
                          child: const Text('Delete Portfolio'),
                          onTap: () => _showDeleteDialog(portfolio),
                        ),
                        PopupMenuItem<String>(
                          value: 'rename',
                          child: const Text('Rename Portfolio'),
                          onTap: () => _showEditDialog(portfolio),
                        ),
                        PopupMenuItem<String>(
                          value: 'view',
                          onTap: () => Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => PortfoliodetailView(
                                      portfolioId:
                                          portfolio['id'].toString())))),
                          child: const Text('View Portfolio'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'comparePortfolio',
                          child: Text('Compare Portfolio'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              if (portfolio['stocks'] != null &&
                  (portfolio['stocks'] as List).isNotEmpty)
                Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Symbol',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Value(Rs)',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        for (var stock in _getTopStocks(portfolio['stocks']))
                          DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  '${stock['symbol']}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${stock['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${stock['currentprice']}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                )
              else
                const Text(
                  'No stocks found',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
            ],
          ),
        ));
  }

  void _showCreatePortfolioDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create Portfolio"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Portfolio Name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String portfolioName = controller.text;
                _createPortfolio(portfolioName);
                Navigator.pop(context);
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
  }

  void _createPortfolio(String portfolioName) async {
    try {
      await PortfolioService.createPort(portfolioName);
      await _loadPortfolioData();
      CustomToast.showToast("Portfolio created successfully");
    } catch (statusCode) {
      if (statusCode == 400) {
        CustomToast.showToast("Duplicate Portfolio Name");
      } else if (statusCode == 500) {
        CustomToast.showToast("Failed to create portfolio");
      } else {
        CustomToast.showToast("Error Occured");
      }
    }
  }

  void _showDeleteDialog(Map<String, dynamic> portfolio) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content:
              const Text("Are you sure you want to delete this portfolio?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await PortfolioService.deleteport(portfolio['id']);
                  await _loadPortfolioData();
                  CustomToast.showToast("Portfolio deleted");
                  Navigator.pop(context);
                } catch (error) {
                  CustomToast.showToast("Failed to delete portfolio");
                  Navigator.pop(context);
                }
              },
              child: const Text('Yes'),
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
  }

  void showAddStockDialog(BuildContext context, {String? portid}) async {
    String? selectedPortfolioId = portid;
    String? selectedStockSymbol;

    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    FocusNode quantityFocus = FocusNode();
    FocusNode stockSymbolFocus = FocusNode();
    final autocompleteController = TextEditingController();

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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return RawAutocomplete<String>(
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            return await getStockSuggestions(
                                textEditingValue.text);
                          },
                          onSelected: (String selection) {
                            setState(() {
                              selectedStockSymbol = selection;
                            });
                            stockSymbolFocus.unfocus();
                            FocusScope.of(context).requestFocus(quantityFocus);
                            autocompleteController.clear();
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController controller,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            stockSymbolFocus = focusNode;

                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                  labelText: 'Stock Symbol'),
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 250.0,
                                height: 160,
                                child: Material(
                                  elevation: 4,
                                  clipBehavior: Clip.antiAlias,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: options.map((e) {
                                      return ListTile(
                                        title: Text(e),
                                        onTap: () {
                                          onSelected(e);
                                          autocompleteController.clear();
                                        },
                                      );
                                    }).toList(),
                                  )),
                                ),
                              ),
                            );
                          },
                        );
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
                      if (selectedPortfolioId != null &&
                          selectedStockSymbol != null) {
                        int quantity =
                            int.tryParse(quantityController.text) ?? 0;
                        double price =
                            double.tryParse(priceController.text) ?? 0.0;
                        addStockToPortfolio(selectedPortfolioId!,
                            selectedStockSymbol!, quantity, price);
                        Navigator.pop(context);
                      } else {
                        CustomToast.showToast(
                            'Please select a portfolio and stock symbol');
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

//
  Future<List<String>> getStockSuggestions(String pattern) async {
    List<String> stockSymbols = (await AssetData.getAssetData())
        .map((asset) => asset.symbol.toString())
        .toList();

    return stockSymbols
        .where((symbol) => symbol.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  void addStockToPortfolio(
      String ptid, String stSymbol, int qt, double pr) async {
    try {
      await PortfolioService.addtoPort(
          int.parse(ptid), stSymbol, qt, pr.toInt());
      await _loadPortfolioData();
      CustomToast.showToast("Stock added successfully");
      setState(() {});
    } catch (error) {
      CustomToast.showToast("Error occured");
    }
  }

  void _showDeleteStockDialog() {
    String? selectedPortfolioId;
    String? selectedStockSymbol;

    TextEditingController quantityController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Delete Stock from Portfolio"),
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
                          selectedStockSymbol =
                              null; // Reset selected stock symbol when portfolio changes
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a portfolio';
                        }
                        return null;
                      },
                    ),
                    if (selectedPortfolioId != null)
                      DropdownButtonFormField<String>(
                        hint: const Text('Select Stock Symbol'),
                        value: selectedStockSymbol,
                        items:
                            _getStockSymbols(selectedPortfolioId!).map((stock) {
                          return DropdownMenuItem<String>(
                            value: stock['symbol'],
                            child: Text(stock['symbol']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStockSymbol = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a stock symbol';
                          }
                          return null;
                        },
                      ),
                    if (selectedPortfolioId != null &&
                        selectedStockSymbol != null)
                      TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Quantity'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          int quantityToDelete = int.tryParse(value) ?? 0;
                          int existingQuantity = _getStockQuantity(
                              selectedPortfolioId!, selectedStockSymbol!);
                          if (quantityToDelete > existingQuantity) {
                            return 'Quantity cannot be greater than $existingQuantity';
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
                      if (selectedPortfolioId != null &&
                          selectedStockSymbol != null) {
                        int quantityToDelete =
                            int.tryParse(quantityController.text) ?? 0;
                        _deleteStockFromPortfolio(selectedPortfolioId!,
                            selectedStockSymbol!, quantityToDelete);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Delete'),
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

  List<Map<String, dynamic>> _getStockSymbols(String portfolioId) {
    var portfolio = portfolioData
        .firstWhere((portfolio) => portfolio['id'].toString() == portfolioId);
    return List<Map<String, dynamic>>.from(portfolio['stocks']);
  }

  int _getStockQuantity(String portfolioId, String stockSymbol) {
    var portfolio = portfolioData
        .firstWhere((portfolio) => portfolio['id'].toString() == portfolioId);
    var stock = portfolio['stocks']
        .firstWhere((stock) => stock['symbol'] == stockSymbol);
    return stock['quantity'];
  }

  void _deleteStockFromPortfolio(
      String portfolioId, String stockSymbol, int quantityToDelete) async {
    try {
      await PortfolioService.deletestockfromport(
          int.parse(portfolioId), stockSymbol, quantityToDelete);
      await _loadPortfolioData();
      CustomToast.showToast("Stock removed successfully");
    } catch (error) {
      if (error is Exception) {
        CustomToast.showToast(error.toString());
      } else {
        CustomToast.showToast("An unexpected error occurred");
      }
    }
  }

  void _showEditDialog(Map<String, dynamic> portfolio) async {
    TextEditingController controller =
        TextEditingController(text: portfolio['name']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Portfolio Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Portfolio Name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                try {
                  String newName = controller.text;
                  await PortfolioService.renameport(portfolio['id'], newName);
                  await _loadPortfolioData();
                  setState(() {
                    portfolio['name'] = newName;
                  });
                  CustomToast.showToast("Portfolio Renamed");
                  Navigator.pop(context);
                } catch (error) {
                  CustomToast.showToast("Failed to rename portfolio");
                  Navigator.pop(context);
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
  }

  List<Map<String, dynamic>> _getTopStocks(List<dynamic> stocks) {
    stocks.sort((a, b) => (b['currentprice'] * b['quantity'])
        .compareTo(a['currentprice'] * a['quantity']));
    return List<Map<String, dynamic>>.from(stocks.take(5));
  }

  Future<void> _handleRefresh() async {
    await _loadPortfolioData();
  }
}
