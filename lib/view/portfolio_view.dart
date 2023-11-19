// portfolio_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/services/portfolio_services.dart'; // Import your PortfolioService
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioView> {
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

  // _loadPortfolioData() async {
  //   try {
  //     List<Map<String, dynamic>> data = await PortfolioService.getPort();
  //     print('Fetched data: $data');

  //     setState(() {
  //       print("State updated");
  //       portfolioData = data;
  //     });
  //   } catch (error) {
  //     CustomToast.showToast("Error occurred");
  //     print('Error loading portfolio data: $error');
  //   }
  // }

  _loadPortfolioData() async {
    try {
      List<Map<String, dynamic>> data = await PortfolioService.getPort();
      print('API Response: $data');

      setState(() {
        print("State updated");
        portfolioData = data;
      });
    } catch (error) {
      CustomToast.showToast("Error occurred");
      print('Error loading portfolio data: $error');
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
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: portfolioData.isNotEmpty
              ? Column(
                  children: [
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
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 2) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.global_search),
            title: const Text("Search"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.document),
            title: const Text("Portfolio"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.wallet_1),
            title: const Text("Wallet"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.profile_circle),
            title: const Text("Profile"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioContainer(Map<String, dynamic> portfolio) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                portfolio['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  // Handle view all button tap
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          if (portfolio['stocks'] != null &&
              (portfolio['stocks'] as List).isNotEmpty)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (portfolio['stocks'] as List).length,
                itemBuilder: (context, index) {
                  var stock = portfolio['stocks'][index];
                  return InkWell(
                    onTap: () {
                      // Handle stock tap
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Add logic to display stock information here
                          // You can access properties like stock['symbol'], stock['name'], etc.
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Text(
              'No stocks found',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
        ],
      ),
    );
  }
}
