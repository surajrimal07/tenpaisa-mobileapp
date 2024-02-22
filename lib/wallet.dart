// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/themes/app_themes.dart';
// import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/commodity_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/metals_viewmodel.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/topgainers_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/toploosers_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/toptransaction_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/topturnover_view_model.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/topvolume_view_model.dart';
// import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
// import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

// final buttonTextProvider = StateNotifierProvider<TextNotifier, String>((ref) {
//   return TextNotifier();
// });

// class TextNotifier extends StateNotifier<String> {
//   TextNotifier() : super('');

//   void updateText(String text) {
//     state = text;
//   }
// }

// class WalletView extends ConsumerWidget {
//   const WalletView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //working
//     //final port = ref.watch(portfolioViewModelProvider);
//     final metal = ref.watch(metalsViewModelProvider);
//     final stock = ref.watch(stockViewModelProvider);
//     final commodity = ref.watch(commodityViewModelProvider);
//     final index = ref.watch(indexViewModelProvider);
//     final auth = ref.watch(
//         authEntityProvider); //don't use this c//-- working -- fix needed, convert it
//     //final port = ref.watch(portfolioViewModelProvider);
//     final gainers = ref.watch(topGainersViewModelProvider);
//     final loosers = ref.watch(topLoosersViewModelProvider);
//     final turnover = ref.watch(topTurnoverViewModelProvider);
//     final trans = ref.watch(topTransactionViewModelProvider);
//     final volume = ref.watch(topVolumeViewModelProvider);
//     final watchlist = ref.watch(watchlistViewModelProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primaryColor,
//         iconTheme: const IconThemeData(color: Colors.black),
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               auth.name ?? 'No Image',
//               style: const TextStyle(fontSize: 18, color: Colors.black),
//             ),
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     await ref
//             //         .read(portfolioViewModelProvider.notifier)
//             //         .getPortfolio();

//             //     ref
//             //         .read(buttonTextProvider.notifier)
//             //         .updateText(port.portfolios[0].userEmail);
//             //   },
//             //   child: port.isLoading
//             //       ? const CircularProgressIndicator(
//             //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             //         )
//             //       : const Text('Button portfolio'),
//             // ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref.read(metalsViewModelProvider.notifier).getMetals();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(metal.metals[2].name);

//                 //_updateText(ref, 'Text for Button 2');
//               },
//               child: const Text('Button metals'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref.read(stockViewModelProvider.notifier).getStocks();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(stock.stocks[0].name);

//                 // _updateText(ref, 'Text for Button 3');
//               },
//               child: const Text('Button stocks'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref
//                     .read(commodityViewModelProvider.notifier)
//                     .getCommodity();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(commodity.commodity[2].name);

//                 // _updateText(ref, 'Text commodity');
//               },
//               child: const Text('Button commodity '),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref
//                     .read(topGainersViewModelProvider.notifier)
//                     .getGainers();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(gainers.topgainers[0].ltp.toString());
//                 //_updateText(ref, 'Text categories');
//               },
//               child: const Text('Button gainers'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref
//                     .read(topLoosersViewModelProvider.notifier)
//                     .getLoosers();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(volume.topvolume[0].ltp.toString());
//                 //_updateText(ref, 'Text categories');
//               },
//               child: const Text('Button looseers'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     await ref
//             //         .read(portfolioViewModelProvider.notifier)
//             //         .getPortfolio();

//             //     ref.read(buttonTextProvider.notifier).updateText(
//             //         port.portfoliosEntity[0].stocks[0].symbol.toString());
//             //     //_updateText(ref, 'Text categories');
//             //   },
//             //   child: const Text('Button portfolio'),
//             // ),
//             ElevatedButton(
//               onPressed: () async {
//                 await ref.watch(indexViewModelProvider.notifier).getIndex();

//                 ref
//                     .read(buttonTextProvider.notifier)
//                     .updateText(index.index[0].date.toString());
//               },
//               child: const Text('Button index'),
//             ),
//             Text(
//               ref.watch(buttonTextProvider), // Use the provider to get the text
//               style: const TextStyle(fontSize: 18, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _updateText(WidgetRef ref, String text) async {
//     // final port = ref.watch(portfolioEntityProvider);
//     await ref.read(portfolioViewModelProvider.notifier).getPortfolio();

//     ref.read(buttonTextProvider.notifier).updateText("hello");
//   }
// }
