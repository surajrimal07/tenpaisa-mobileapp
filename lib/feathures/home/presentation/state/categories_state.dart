import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

class CategoriesState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final TopCategoriesEntity categories;
  //final List<TopGainersEntity> gainers;
  // final List<TopLoosersEntity> loosers;
  // final List<TopTurnoverEntity> topTurnover;
  // final List<TopTransactionEntity> toptransaction;
  // final List<TopVolumeEntity> topVolume;

  CategoriesState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.categories,
    //required this.gainers,
    // required this.loosers,
    // required this.topTurnover,
    // required this.toptransaction,
    // required this.topVolume,
  });

  factory CategoriesState.initialState() => CategoriesState(
        isLoading: false,
        error: null,
        showMessage: false,
        categories: const TopCategoriesEntity(
            topGainers: [],
            topLoosers: [],
            topTurnover: [],
            topTrans: [],
            topVolume: []),
        // gainers: [
        //   const TopGainersEntity(
        //       symbol: 'Null',
        //       name: 'Null',
        //       ltp: 0.0,
        //       pointchange: 0.0,
        //       percentchange: 0.0)
        // ],
        // loosers: [
        //   const TopLoosersEntity(
        //       symbol: 'Null',
        //       name: 'Null',
        //       ltp: 0.0,
        //       pointchange: 0.0,
        //       percentchange: 0.0)
        // ],
        // topTurnover: [
        //   const TopTurnoverEntity(
        //       symbol: 'Null', name: 'Null', ltp: 0.0, turnover: 0.0)
        // ],
        // toptransaction: [
        //   const TopTransactionEntity(
        //       symbol: 'Null', name: 'Null', ltp: 0.0, transactions: 0)
        // ],
        // topVolume: [
        //   const TopVolumeEntity(
        //       symbol: 'Null', name: 'Null', ltp: 0.0, volume: 0)
      );

  CategoriesState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    //List<TopGainersEntity>? gainers,
    // List<TopLoosersEntity>? loosers,
    // List<TopTurnoverEntity>? topTurnover,
    // List<TopTransactionEntity>? toptransaction,
    // List<TopVolumeEntity>? topVolume,
    TopCategoriesEntity? categories,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      categories: categories ?? this.categories,
      //gainers: gainers ?? this.gainers,
      // loosers: loosers ?? this.loosers,
      // topTurnover: topTurnover ?? this.topTurnover,
      // toptransaction: toptransaction ?? this.toptransaction,
      // topVolume: topVolume ?? this.topVolume
    );
  }
}
