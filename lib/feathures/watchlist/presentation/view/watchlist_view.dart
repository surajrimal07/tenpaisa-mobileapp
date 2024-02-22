// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/find_stockentity.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/add_stock_watchlist.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/add_watchlist.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/delete_stock_watchlist.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/delete_watchlist.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/rename_watchlist.dart';

class WishlistView extends ConsumerWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistState = ref.watch(watchlistViewModelProvider);
    final stockState = ref.watch(stockViewModelProvider);
    final index = ref.watch(indexViewModelProvider.notifier).state.index;
    final watchlistList =
        ref.watch(watchlistViewModelProvider.notifier).state.watchlist;

    return DefaultTabController(
      length: watchlistList.length,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: watchlistList.isNotEmpty
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(80),
                  child: AppBar(
                      title: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Watchlist ',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextSpan(
                              text:
                                  ' (${PortfolioStrings.asOf}${index[0].date.toString()})',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            _showMenu(context, watchlistList);
                          },
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                      bottom: TabBar(
                        dividerColor: Colors.grey,
                        physics: const BouncingScrollPhysics(),
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: watchlistList
                            .map((watchlist) => Tab(text: watchlist.name))
                            .toList(),
                      )),
                )
              : AppBar(
                  title: const Text('Watchlist'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        _showMenu(context, watchlistList);
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
          body: watchlistState.isLoading || stockState.isLoading
              ? const Center(
                  widthFactor: 5,
                  heightFactor: 7,
                  child: LoadingIndicatorWidget(
                    size: 50,
                    showText: true,
                    text: WatchlistStrings.loadingWatchlist,
                  ))
              : watchlistList.isEmpty
                  ? const Center(
                      child: EmptyPortfolioWidget(
                      name: 'Watchlist',
                    ))
                  : TabBarView(
                      children: watchlistList.map((watchlist) {
                        final stockDetails = watchlist.stocks
                            .map((symbol) => findStockDetails(symbol, ref))
                            .toList();
                        return stockDetails.isEmpty
                            ? const EmptyAssetsWidget()
                            : DataTable(
                                headingRowColor: MaterialStateProperty.all(
                                    AppColors.primaryColor),
                                headingRowHeight: 30,
                                dataRowMinHeight: 10,
                                dataRowMaxHeight: 30,
                                columnSpacing: 10,
                                dividerThickness: 0,
                                columns: const [
                                  DataColumn(
                                    label: Text('Symbol',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DataColumn(
                                    label: Text('LTP',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DataColumn(
                                    label: Text('Change',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DataColumn(
                                    label: Text('Per',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DataColumn(
                                    label: Text('low',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DataColumn(
                                    label: Text('high',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                                rows: stockDetails.map((stockEntity) {
                                  final backgroundColor = stockEntity
                                              .pointChange >
                                          0
                                      ? const Color.fromARGB(255, 123, 228, 126)
                                      : const Color.fromARGB(
                                          255, 248, 144, 144);
                                  return DataRow(
                                    color: MaterialStateProperty.all(
                                        backgroundColor),
                                    cells: [
                                      DataCell(
                                        onTap: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .routeTo(
                                            '/assetview',
                                            arguments: {
                                              'stockEntity': stockEntity
                                            },
                                          );
                                        },
                                        Text(stockEntity.symbol),
                                        onLongPress: () {
                                          showDeleteStockWatchlist(context,
                                              watchlist, stockEntity.symbol);
                                        },
                                      ),
                                      DataCell(
                                        onTap: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .routeTo(
                                            '/assetview',
                                            arguments: {
                                              'stockEntity': stockEntity
                                            },
                                          );
                                        },
                                        Text(stockEntity.ltp.toString()),
                                        onLongPress: () {
                                          showDeleteStockWatchlist(context,
                                              watchlist, stockEntity.symbol);
                                        },
                                      ),
                                      DataCell(onTap: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .routeTo(
                                          '/assetview',
                                          arguments: {
                                            'stockEntity': stockEntity
                                          },
                                        );
                                      }, onLongPress: () {
                                        showDeleteStockWatchlist(context,
                                            watchlist, stockEntity.symbol);
                                      },
                                          Text(stockEntity.pointChange
                                              .toString())),
                                      DataCell(onTap: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .routeTo(
                                          '/assetview',
                                          arguments: {
                                            'stockEntity': stockEntity
                                          },
                                        );
                                      }, onLongPress: () {
                                        showDeleteStockWatchlist(context,
                                            watchlist, stockEntity.symbol);
                                      }, Text("${stockEntity.percentChange}%")),
                                      DataCell(onTap: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .routeTo(
                                          '/assetview',
                                          arguments: {
                                            'stockEntity': stockEntity
                                          },
                                        );
                                      }, onLongPress: () {
                                        showDeleteStockWatchlist(context,
                                            watchlist, stockEntity.symbol);
                                      }, Text(stockEntity.low.toString())),
                                      DataCell(onTap: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .routeTo(
                                          '/assetview',
                                          arguments: {
                                            'stockEntity': stockEntity
                                          },
                                        );
                                      }, onLongPress: () {
                                        showDeleteStockWatchlist(context,
                                            watchlist, stockEntity.symbol);
                                      }, Text(stockEntity.high.toString())),
                                    ],
                                  );
                                }).toList(),
                              );
                      }).toList(),
                    ),
        );
      }),
    );
  }

  void _showMenu(BuildContext context, List<WatchlistEntity> watchlistList) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset(button.size.width, 0), ancestor: overlay);

    final int tabIndex = DefaultTabController.of(context).index;

    final List<PopupMenuEntry<String>> menuItems = [
      PopupMenuItem<String>(
        value: 'createPortfolio',
        onTap: () => showCreateWatchlist(context),
        child: const Text('Create Watchlist'),
      ),
      if (watchlistList.isNotEmpty)
        PopupMenuItem<String>(
          value: 'renameWatchlist',
          onTap: () => showRenameWatchlist(context, watchlistList[tabIndex].id,
              watchlistList[tabIndex].name),
          child: const Text('Rename Watchlist'),
        ),
      if (watchlistList.isNotEmpty)
        PopupMenuItem<String>(
          value: 'deleteWatchlist',
          onTap: () => showDeleteWatchlist(context, watchlistList[tabIndex].id,
              watchlistList[tabIndex].name),
          child: const Text('Delete Watchlist'),
        ),
      if (watchlistList.isNotEmpty)
        PopupMenuItem<String>(
          onTap: () => showAddStockWatchlist(context,
              watchlistList[tabIndex].id, watchlistList[tabIndex].name),
          value: 'addStock',
          child: const Text('Add Stock'),
        ),
    ];

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: menuItems,
    );
  }

  Future<void> showCreateWatchlist(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateWatchlistDialog();
      },
    );
  }

  Future<void> showAddStockWatchlist(
      BuildContext context, String watchlistId, String stock) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStockWatchlistDialog(
          watchlistId: watchlistId,
          watchlistName: stock,
        );
      },
    );
  }

  Future<void> showDeleteWatchlist(
      BuildContext context, String watchlistId, String watchlistName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteWatchlistDialog(
          watchlistId: watchlistId,
          watchlistName: watchlistName,
        );
      },
    );
  }

  Future<void> showDeleteStockWatchlist(
      BuildContext context, WatchlistEntity watchlist, String symbol) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteStockConfirmationDialog(
          watchlist: watchlist,
          symbol: symbol,
        );
      },
    );
  }

  Future<void> showRenameWatchlist(
      BuildContext context, String watchlistId, String watchlistName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RenameWatchlistDialog(
          oldWatchlistName: watchlistName,
          watchlistId: watchlistId,
        );
      },
    );
  }

  // StockEntity _findStockDetails(String symbol, List<StockEntity> stocksList) {
  //   final stockEntity = stocksList.firstWhere(
  //     (stock) => stock.symbol == symbol,
  //     orElse: () => const StockEntity(
  //       symbol: 'Loading...',
  //       ltp: 0,
  //       pointChange: 0,
  //       percentChange: 0,
  //       open: 0,
  //       high: 0,
  //       low: 0,
  //       volume: 0,
  //       previousClose: 0,
  //       name: 'Loading...',
  //       category: 'Loading...',
  //       sector: 'Loading...',
  //     ),
  //   );
  //   return stockEntity;
  // }
}
