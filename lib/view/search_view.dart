import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/app/common/drawer_common.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';

import '../app/common/navbar_common.dart';
import '../model/asset_model.dart';
import '../services/asset_services.dart';
import '../view/asset_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  int indexBottomBar = 1;
  int currentPageIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onAssetTapped(Asset asset, aname, comopage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AssetView(assetData: asset, fromCommodityPage: comopage),
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
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
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
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Stocks'),
              Tab(text: 'Commodities'),
              Tab(text: 'Metals'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            FutureBuilder<List<Asset>>(
              future: AssetData.getAssetData(),
              builder: (context, assetSnapshot) {
                if (assetSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: MyColors.btnColor,
                      size: 25.0,
                    ),
                  );
                } else if (assetSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${assetSnapshot.error}'),
                  );
                } else if (assetSnapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: assetSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = assetSnapshot.data![index].name;
                      String sector = assetSnapshot.data![index].sector ?? '';
                      String ltp = assetSnapshot.data![index].ltp ?? '';

                      bool matchesSearch = name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()) ||
                          assetSnapshot.data![index].symbol
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());

                      return matchesSearch
                          ? Column(
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: GoogleFonts.poppins(),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        sector,
                                        style: GoogleFonts.poppins(),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Rs $ltp',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          _buildArrowAndPercentage(assetSnapshot
                                              .data![index].percentchange),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _onAssetTapped(assetSnapshot.data![index],
                                        name, false);
                                  },
                                ),
                                const Divider(
                                  color: MyColors.btnColor,
                                  height: 0.3,
                                  thickness: 0.3,
                                ),
                              ],
                            )
                          : Container();
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),

            // Commodity data
            FutureBuilder<List<Asset>>(
              future: CommodityData.getCommodityData(),
              builder: (context, commoditySnapshot) {
                if (commoditySnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: MyColors.btnColor,
                      size: 25.0,
                    ),
                  );
                } else if (commoditySnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${commoditySnapshot.error}'),
                  );
                } else if (commoditySnapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: commoditySnapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = commoditySnapshot.data![index].name;
                      String sector =
                          commoditySnapshot.data![index].category ?? '';
                      String ltp = commoditySnapshot.data![index].ltp ?? '';

                      bool matchesSearch = name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()) ||
                          commoditySnapshot.data![index].name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());

                      return matchesSearch
                          ? Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    name,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  subtitle: Text(
                                    sector,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  trailing: Text(
                                    'Rs $ltp',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    _onAssetTapped(
                                        commoditySnapshot.data![index],
                                        name,
                                        true);
                                  },
                                ),
                                const Divider(
                                  color: MyColors.btnColor,
                                  height: 0.3,
                                  thickness: 0.3,
                                ),
                              ],
                            )
                          : Container();
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            //
            FutureBuilder<List<Asset>>(
              future: MetalsData.getMetalsData(),
              builder: (context, commoditySnapshot) {
                if (commoditySnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: MyColors.btnColor,
                      size: 25.0,
                    ),
                  );
                } else if (commoditySnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${commoditySnapshot.error}'),
                  );
                } else if (commoditySnapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: commoditySnapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = commoditySnapshot.data![index].name;
                      String sector =
                          commoditySnapshot.data![index].category ?? '';
                      String ltp = commoditySnapshot.data![index].ltp ?? '';

                      bool matchesSearch = name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()) ||
                          commoditySnapshot.data![index].name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());

                      return matchesSearch
                          ? Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    name,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  subtitle: Text(
                                    sector,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  trailing: Text(
                                    'Rs $ltp',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    _onAssetTapped(
                                        commoditySnapshot.data![index],
                                        name,
                                        true);
                                  },
                                ),
                                const Divider(
                                  color: MyColors.btnColor,
                                  height: 0.3,
                                  thickness: 0.3,
                                ),
                              ],
                            )
                          : Container();
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        drawer: const CommonDrawer(),
        bottomNavigationBar: CommonBottomNavigationBar(
          currentIndex: indexBottomBar,
          onTap: (index) {
            if (index == 1) {
              setState(() => indexBottomBar = index);
            } else if (index == 0) {
              Navigator.pushNamed(context, AppRoute.dashboardRoute);
            } else if (index == 4) {
              Navigator.pushNamed(context, AppRoute.profileRoute);
            } else if (index == 1) {
              Navigator.pushNamed(context, AppRoute.searchRoute);
            } else if (index == 3) {
              Navigator.pushNamed(context, AppRoute.wishlistRoute);
            } else if (index == 2) {
              Navigator.pushNamed(context, AppRoute.portRoute);
            } else {
              setState(() => indexBottomBar = index);
            }
          },
        ));
  }
}

Widget _buildArrowAndPercentage(dynamic percentChange) {
  double change = double.tryParse(percentChange.toString()) ?? 0.0;

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
        size: 18,
      ),
      const SizedBox(width: 4),
      Text(
        '$formattedChange%',
        style: GoogleFonts.poppins(
          color: arrowColor,
          fontSize: 15,
        ),
      ),
    ],
  );
}
