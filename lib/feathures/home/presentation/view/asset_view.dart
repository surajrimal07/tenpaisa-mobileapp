// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/presentation/view/webview_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolio_dialog.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/remove_stock_from_portfolio.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/addstock_watchlist.dart';
import 'package:paisa/feathures/watchlist/presentation/widget/deletestock_watchlist.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AssetView extends ConsumerStatefulWidget {
  const AssetView({super.key, required this.stockEntity});

  final StockEntity stockEntity;

  @override
  AssetViewState createState() => AssetViewState();
}

bool doesStockExistInWatchlist = false;

class AssetViewState extends ConsumerState<AssetView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockViewModelProvider);
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    final bool connected = connectivityStatus == ConnectivityStatus.isConnected;

    return Scaffold(
        backgroundColor: AppColors.greyPrimaryColor,
        appBar: AppBar(
          title: Hero(
            tag: 'Info',
            child: Text(
                "${widget.stockEntity.symbol} (${widget.stockEntity.ltp} / ${widget.stockEntity.percentChange}%)",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                )),
          ),
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
          child: state.isLoading
              ? const Center(
                  widthFactor: 5,
                  heightFactor: 7,
                  child: LoadingIndicatorWidget(
                      color: Colors.white,
                      size: 50,
                      showText: true,
                      text: StockStrings.loadingWatchlist))
              : _buildAssetDetails(connected),
        ),
        floatingActionButton: _buildPopupMenuButton());
  }

  Widget _buildPopupMenuButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {
          _showPopupMenu(context);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAssetDetails(connected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStockInfo(),
        connected
            ? SizedBox(
                height: Sizes.dynamicHeight(60),
                child: Hero(
                  tag: 'stockInfo_${widget.stockEntity.name}',
                  child: WebView(
                    initialUrl: _getWebViewUrl(widget.stockEntity.symbol),
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
              )
            : const SizedBox(
                child: Text(
                  textAlign: TextAlign.center,
                  'No internet available for the chart',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20, //
                  ),
                ),
              ),
        SizedBox(height: Sizes.dynamicHeight(1)),
        _buildAdvanceChartButton(),
        _buildSectionTitle("Asset's Data"),
        _buildDetailItem('Asset Type', widget.stockEntity.category),
        _buildDetailItem('Price', 'Rs ${widget.stockEntity.ltp}'),
        _buildDetailItem(
            'Turnover', 'Rs ${widget.stockEntity.turnover.toString()}'),
        _buildDetailItem(
            'Volume', '${widget.stockEntity.volume.toString()} Units'),
        _buildDetailItem('Percentage Change',
            '${(widget.stockEntity.percentChange).toStringAsFixed(1)}%'),
        _buildDetailItem(
            'Previous Close', 'Rs ${widget.stockEntity.previousClose}'),
        _buildDetailItem('Open', 'Rs ${widget.stockEntity.open}'),
        _buildDetailItem('High', 'Rs ${widget.stockEntity.high}'),
        _buildDetailItem('Low', 'Rs ${widget.stockEntity.low}'),
        _buildDetailItem('Intraday Volatility',
            'Rs ${widget.stockEntity.high - widget.stockEntity.low}'),
        _buildSectionTitle("Asset's Information"),
        _buildDetailItem('Vwap', 'Rs ${widget.stockEntity.vwap}'),
        _buildDetailItem('120 Day High', 'Rs ${widget.stockEntity.day120}'),
        _buildDetailItem('180 Day High', 'Rs ${widget.stockEntity.day180}'),
        _buildDetailItem('52 Week High', 'Rs ${widget.stockEntity.week52High}'),
        _buildDetailItem('52 Week Low', 'Rs ${widget.stockEntity.week52Low}'),
      ],
    );
  }

  Widget _buildStockInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 0),
          Hero(
            tag: 'stockInfo${widget.stockEntity.name}',
            child: Text(
              '${widget.stockEntity.name} (Rs ${widget.stockEntity.ltp}) (${widget.stockEntity.percentChange}%)',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Hero(
            tag: 'stockSymbol_${widget.stockEntity.name}',
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '(${widget.stockEntity.symbol}) - ',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: widget.stockEntity.sector.length > 23
                            ? '${widget.stockEntity.sector.substring(0, 23)}...'
                            : widget.stockEntity.sector,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    doesStockExistInWatchlist()
                        ? showRemoveStockWatchlist(context)
                        : showAddStockWatchlist(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      doesStockExistInWatchlist()
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: doesStockExistInWatchlist()
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvanceChartButton() {
    return Center(
      child: SizedBox(
        width: 400,
        child: ElevatedButton(
          onPressed: () {
            animatednavigateTo(
                context,
                WebViewPage(
                  url: _getWebViewUrl(widget.stockEntity.symbol),
                  name: widget.stockEntity.symbol,
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
          child: Text(
            'Show Advance Chart',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
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
              title,
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
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _getWebViewUrl(String sym) {
    String baseUrl = UrlStrings.stockChart;
    String query = Uri.encodeComponent(sym);
    return '$baseUrl$query';
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset(0, -button.size.height), ancestor: overlay);

    showMenu(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0)),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        position: RelativeRect.fromLTRB(
          position.dx,
          position.dy,
          overlay.size.width - position.dx,
          overlay.size.height - position.dy,
        ),
        items: [
          PopupMenuItem(
            child: const Text('Add to Portfolio'),
            onTap: () {
              showdAddFromFloating(context);
            },
          ),
          if (doesStockExistInPortfolio(widget.stockEntity.symbol))
            PopupMenuItem(
              child: const Text('Remove from Portfolio'),
              onTap: () {
                removeFromPortfolioFloating(context);
              },
            ),
          PopupMenuItem(
            child: const Text('Add to Watchlist'),
            onTap: () {
              showAddStockWatchlist(context);
            },
          ),
          if (doesStockExistInWatchlist())
            PopupMenuItem(
              child: const Text('Remove from Watchlist'),
              onTap: () {
                showRemoveStockWatchlist(context);
              },
            ),
        ]);
  }

  Future<void> showAddStockWatchlist(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStockWatchlistDialogAsset(
          stockSymbol: widget.stockEntity.symbol,
        );
      },
    );
  }

  Future<void> showRemoveStockWatchlist(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RemStockWatchlistDialog(
          stockSymbol: widget.stockEntity.symbol,
        );
      },
    );
  }

  bool doesStockExistInWatchlist() {
    final watchlist =
        ref.watch(watchlistViewModelProvider.notifier).state.watchlist;

    for (WatchlistEntity portfolio in watchlist) {
      if (portfolio.stocks.any((stock) => stock == widget.stockEntity.symbol)) {
        return true;
      }
    }

    return false;
  }

  bool doesStockExistInPortfolio(String symbol) {
    final portfolios =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;

    for (PortfolioEntity portfolio in portfolios) {
      if (portfolio.stocks != null &&
          portfolio.stocks!.any((stock) => stock.symbol == symbol)) {
        return true;
      }
    }

    return false;
  }

  Future<void> showdAddFromFloating(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStockFloatingDialog(
          symbol: widget.stockEntity.symbol,
        );
      },
    );
  }

  Future<void> removeFromPortfolioFloating(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteStockDialog(
          stockSymbol: widget.stockEntity.symbol,
        );
      },
    );
  }
}
