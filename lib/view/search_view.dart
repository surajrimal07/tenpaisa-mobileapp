// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:paisa/app/routes/approutes.dart';
// import 'package:paisa/utils/colors_utils.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import '../services/asset_services.dart';

// class SearchView extends StatefulWidget {
//   const SearchView({super.key});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchView> {
//   int indexBottomBar = 1;
//   //List<dynamic> symbols = [];
//   List<Map<String, dynamic>> symbols = [];

//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: MyColors.btnColor,
//       statusBarIconBrightness: Brightness.light,
//       systemNavigationBarColor: MyColors.btnColor,
//       systemNavigationBarIconBrightness: Brightness.light,
//     ));
//   }

//   Future<void> fetchData() async {
//     List<Map<String, dynamic>> fetchedSymbols =
//         await AssetService.getassets("allwithdata");

//     fetchedSymbols.sort((a, b) => a['name'].compareTo(b['name']));
//     setState(() {
//       symbols = fetchedSymbols;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: TextField(
//             controller: _searchController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Search Assets',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//             ),
//             onChanged: (value) {
//               setState(() {}); // Trigger a rebuild when the text changes
//             },
//           ),
//         ),
//         backgroundColor: MyColors.btnColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(CupertinoIcons.xmark_circle, color: Colors.white),
//             onPressed: () {
//               _searchController.clear();
//               setState(() {}); // Trigger a rebuild to clear the search results
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: symbols.length,
//         itemBuilder: (context, index) {
//           bool matchesSearch = symbols[index]['name']
//               .toLowerCase()
//               .contains(_searchController.text.toLowerCase());

//           return matchesSearch
//               ? ListTile(
//                   title: Text(
//                     symbols[index]['name'],
//                     style: GoogleFonts.poppins(),
//                   ),
//                   subtitle: Text(
//                     symbols[index]['sector'],
//                     style: GoogleFonts.poppins(),
//                   ),
//                   trailing: Text(
//                     'Rs ${symbols[index]['ltp'] ?? ''}',
//                     style: GoogleFonts.poppins(),
//                   ),
//                 )
//               : Container();
//         },
//       ),

//       bottomNavigationBar: SalomonBottomBar(
//         backgroundColor: MyColors.btnColor,
//         currentIndex: indexBottomBar,
//         onTap: (i) {
//           if (i == 1) {
//             setState(() => indexBottomBar = i);
//           } else if (i == 0) {
//             Navigator.pushNamed(context, AppRoute.dashboardRoute);
//           } else if (i == 4) {
//             Navigator.pushNamed(context, AppRoute.profileRoute);
//           } else if (i == 1) {
//             Navigator.pushNamed(context, AppRoute.searchRoute);
//           } else if (i == 3) {
//             Navigator.pushNamed(context, AppRoute.walletRoute);
//           } else if (i == 2) {
//             Navigator.pushNamed(context, AppRoute.portRoute);
//           } else {
//             setState(() => indexBottomBar = i);
//           }
//         },
//         items: [
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.home),
//             title: const Text("Home"),
//             selectedColor: Colors.white,
//             unselectedColor: Colors.white70,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.global_search),
//             title: const Text("Search"),
//             selectedColor: Colors.white,
//             unselectedColor: Colors.white70,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.document),
//             title: const Text("Portfolio"),
//             selectedColor: Colors.white,
//             unselectedColor: Colors.white70,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.wallet_1),
//             title: const Text("Wallet"),
//             selectedColor: Colors.white,
//             unselectedColor: Colors.white70,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Iconsax.profile_circle),
//             title: const Text("Profile"),
//             selectedColor: Colors.white,
//             unselectedColor: Colors.white70,
//           ),
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: library_private_types_in_public_api

// search_view.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../model/asset_model.dart';
import '../services/asset_services.dart';
import '../view/asset_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchView> {
  int indexBottomBar = 1;
  List<Asset> symbols = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  // Future<void> fetchData() async {
  //   try {
  //     List<Map<String, dynamic>> fetchedSymbolMaps =
  //         await AssetService.getassets("allwithdata");

  //       double? ltp = map['ltp'] != null ? double.tryParse(map['ltp']) : null;

  //     // Convert List<Map<String, dynamic>> to List<Asset>
  //     List<Asset> fetchedSymbols = fetchedSymbolMaps
  //         .map((map) => Asset(
  //               map['symbol'],
  //               map['name'],
  //               map['category'],
  //               map['sector'],
  //               map['eps'],
  //               map['bookvalue'],
  //               map['pe'],
  //               ltp ?? 0.0,
  //               //map['ltp'],
  //               map['percentchange'],
  //               map['totaltradedquantity'],
  //               map['previousclose'],
  //             ))
  //         .toList();

  //     fetchedSymbols.sort((a, b) => a.name.compareTo(b.name));
  //     setState(() {
  //       symbols = fetchedSymbols;
  //     });
  //   } catch (error) {
  //     print('Error fetching symbols: $error');
  //     // Handle the error as needed
  //   }
  // }
  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedSymbolMaps =
          await AssetService.getassets("allwithdata");

      // Convert List<Map<String, dynamic>> to List<Asset>
      List<Asset> fetchedSymbols = fetchedSymbolMaps
          .map((map) => Asset(
                symbol: map['symbol'],
                name: map['name'],
                category: map['category'],
                sector: map['sector'],
                eps: map['eps'],
                bookvalue: map['bookvalue'],
                pe: map['pe'],
                ltp: map[
                    'ltp'], // 'ltp' will be converted to double in the Asset constructor
                percentchange: map['percentchange'],
                totaltradedquantity: map['totaltradedquantity'],
                previousclose: map['previousclose'],
              ))
          .toList();

      fetchedSymbols.sort((a, b) => a.name.compareTo(b.name));

      setState(() {
        symbols = fetchedSymbols;
      });
    } catch (error) {
      print('Error fetching symbols: $error');
    }
  }

  void _onAssetTapped(Asset asset) {
    // Navigate to AssetView screen with the tapped asset data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssetView(assetData: asset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search Assets',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {}); // Trigger a rebuild when the text changes
            },
          ),
        ),
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.xmark_circle, color: Colors.white),
            onPressed: () {
              _searchController.clear();
              setState(() {}); // Trigger a rebuild to clear the search results
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          bool matchesSearch = symbols[index]
                  .name
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              symbols[index]
                  .symbol
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase());

          return matchesSearch
              ? ListTile(
                  title: Text(
                    symbols[index].name,
                    style: GoogleFonts.poppins(),
                  ),
                  subtitle: Text(
                    symbols[index].sector ?? "",
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: Text(
                    'Rs ${symbols[index].ltp ?? ''}',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    _onAssetTapped(symbols[index]);
                  },
                )
              : Container();
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 1) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
          } else if (i == 2) {
            Navigator.pushNamed(context, AppRoute.portRoute);
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
}
