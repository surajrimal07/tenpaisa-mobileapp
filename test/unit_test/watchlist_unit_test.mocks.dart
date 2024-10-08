// Mocks generated by Mockito 5.4.4 from annotations
// in paisa/test/unit_test/watchlist_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:paisa/core/common/cache/watchlist_cache.dart' as _i4;
import 'package:paisa/core/failure/failure.dart' as _i8;
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart' as _i3;
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart'
    as _i9;
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart'
    as _i2;
import 'package:paisa/feathures/watchlist/domain/usecase/addstock_watchlist_usecase.dart'
    as _i13;
import 'package:paisa/feathures/watchlist/domain/usecase/create_watchlist_usecase.dart'
    as _i10;
import 'package:paisa/feathures/watchlist/domain/usecase/delete_watchlist_usecase.dart'
    as _i11;
import 'package:paisa/feathures/watchlist/domain/usecase/get_watchlist_usecase.dart'
    as _i6;
import 'package:paisa/feathures/watchlist/domain/usecase/removestock_wathlist_usecase.dart'
    as _i14;
import 'package:paisa/feathures/watchlist/domain/usecase/rename_watchlist_usecase.dart'
    as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIWatchListRepository_0 extends _i1.SmartFake
    implements _i2.IWatchListRepository {
  _FakeIWatchListRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserSharedPrefs_1 extends _i1.SmartFake
    implements _i3.UserSharedPrefs {
  _FakeUserSharedPrefs_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistCache_2 extends _i1.SmartFake
    implements _i4.WatchlistCache {
  _FakeWatchlistCache_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_3<L, R> extends _i1.SmartFake implements _i5.Either<L, R> {
  _FakeEither_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchlistUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistUsecase extends _i1.Mock
    implements _i6.GetWatchlistUsecase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i4.WatchlistCache get watchlistCache => (super.noSuchMethod(
        Invocation.getter(#watchlistCache),
        returnValue: _FakeWatchlistCache_2(
          this,
          Invocation.getter(#watchlistCache),
        ),
        returnValueForMissingStub: _FakeWatchlistCache_2(
          this,
          Invocation.getter(#watchlistCache),
        ),
      ) as _i4.WatchlistCache);

  @override
  _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>
      getWatchlist() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlist,
              [],
            ),
            returnValue: _i7.Future<
                    _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
                _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
              this,
              Invocation.method(
                #getWatchlist,
                [],
              ),
            )),
            returnValueForMissingStub: _i7.Future<
                    _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
                _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
              this,
              Invocation.method(
                #getWatchlist,
                [],
              ),
            )),
          ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}

/// A class which mocks [CreateWatchlistUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateWatchlistUsecase extends _i1.Mock
    implements _i10.CreateWatchlistUsecase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i7.Future<
      _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>> createWatchlist(
          String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #createWatchlist,
          [name],
        ),
        returnValue: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #createWatchlist,
            [name],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #createWatchlist,
            [name],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}

/// A class which mocks [DeleteWatchlistUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteWatchlistUsecase extends _i1.Mock
    implements _i11.DeleteWatchlistUsecase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i7.Future<
      _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>> deleteWatchList(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWatchList,
          [id],
        ),
        returnValue: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #deleteWatchList,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #deleteWatchList,
            [id],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}

/// A class which mocks [RenameWatchlistUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRenameWatchlistUsecase extends _i1.Mock
    implements _i12.RenameWatchlistUsecase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i7.Future<
      _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>> renameWatchList(
    String? id,
    String? name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #renameWatchList,
          [
            id,
            name,
          ],
        ),
        returnValue: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #renameWatchList,
            [
              id,
              name,
            ],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #renameWatchList,
            [
              id,
              name,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}

/// A class which mocks [AddStockWatchlistUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddStockWatchlistUsecase extends _i1.Mock
    implements _i13.AddStockWatchlistUsecase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i7.Future<
      _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>> addStockWatchList(
    String? id,
    String? stock,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addStockWatchList,
          [
            id,
            stock,
          ],
        ),
        returnValue: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #addStockWatchList,
            [
              id,
              stock,
            ],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #addStockWatchList,
            [
              id,
              stock,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}

/// A class which mocks [RemoveStockWatchlistUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveStockWatchlistUseCase extends _i1.Mock
    implements _i14.RemoveStockWatchlistUseCase {
  @override
  _i2.IWatchListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIWatchListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IWatchListRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i7.Future<
      _i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>> removeStockWatchList(
    String? id,
    String? stock,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeStockWatchList,
          [
            id,
            stock,
          ],
        ),
        returnValue: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #removeStockWatchList,
            [
              id,
              stock,
            ],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>.value(
            _FakeEither_3<_i8.Failure, List<_i9.WatchlistEntity>>(
          this,
          Invocation.method(
            #removeStockWatchList,
            [
              id,
              stock,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, List<_i9.WatchlistEntity>>>);
}
