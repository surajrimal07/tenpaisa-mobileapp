// Mocks generated by Mockito 5.4.4 from annotations
// in paisa/test/unit_test/portfolio_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:paisa/core/common/cache/portfolio_cache.dart' as _i4;
import 'package:paisa/core/failure/failure.dart' as _i8;
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart' as _i3;
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart'
    as _i9;
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart'
    as _i2;
import 'package:paisa/feathures/portfolio/domain/usecase/addstock_portfolio.dart'
    as _i13;
import 'package:paisa/feathures/portfolio/domain/usecase/create_portfolio_usecase.dart'
    as _i10;
import 'package:paisa/feathures/portfolio/domain/usecase/delete_portfolio_usecase.dart'
    as _i11;
import 'package:paisa/feathures/portfolio/domain/usecase/deletestockfrom_portfolio_usecase.dart'
    as _i14;
import 'package:paisa/feathures/portfolio/domain/usecase/get_portfolio_usecase.dart'
    as _i6;
import 'package:paisa/feathures/portfolio/domain/usecase/rename_portfolio_usecase.dart'
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

class _FakeIPortfolioRepository_0 extends _i1.SmartFake
    implements _i2.IPortfolioRepository {
  _FakeIPortfolioRepository_0(
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

class _FakePortfolioCache_2 extends _i1.SmartFake
    implements _i4.PortfolioCache {
  _FakePortfolioCache_2(
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

/// A class which mocks [GetPortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPortfolioUseCase extends _i1.Mock
    implements _i6.GetPortfolioUseCase {
  @override
  _i2.IPortfolioRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IPortfolioRepository);

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
  _i4.PortfolioCache get portfolioCache => (super.noSuchMethod(
        Invocation.getter(#portfolioCache),
        returnValue: _FakePortfolioCache_2(
          this,
          Invocation.getter(#portfolioCache),
        ),
        returnValueForMissingStub: _FakePortfolioCache_2(
          this,
          Invocation.getter(#portfolioCache),
        ),
      ) as _i4.PortfolioCache);

  @override
  _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>> getportfolio() =>
      (super.noSuchMethod(
        Invocation.method(
          #getportfolio,
          [],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #getportfolio,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #getportfolio,
            [],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}

/// A class which mocks [AddPortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddPortfolioUseCase extends _i1.Mock
    implements _i10.AddPortfolioUseCase {
  @override
  _i2.IPortfolioRepository get portfoliorepository => (super.noSuchMethod(
        Invocation.getter(#portfoliorepository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
      ) as _i2.IPortfolioRepository);

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
  _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>> createPortfolio(
    String? name,
    String? goal,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPortfolio,
          [
            name,
            goal,
          ],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #createPortfolio,
            [
              name,
              goal,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #createPortfolio,
            [
              name,
              goal,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}

/// A class which mocks [DeletePortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeletePortfolioUseCase extends _i1.Mock
    implements _i11.DeletePortfolioUseCase {
  @override
  _i2.IPortfolioRepository get portfoliorepository => (super.noSuchMethod(
        Invocation.getter(#portfoliorepository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
      ) as _i2.IPortfolioRepository);

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
  _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>> deletePortfolio(
          String? portfolioId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deletePortfolio,
          [portfolioId],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #deletePortfolio,
            [portfolioId],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #deletePortfolio,
            [portfolioId],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}

/// A class which mocks [RenamePortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRenamePortfolioUseCase extends _i1.Mock
    implements _i12.RenamePortfolioUseCase {
  @override
  _i2.IPortfolioRepository get portfoliorepository => (super.noSuchMethod(
        Invocation.getter(#portfoliorepository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
      ) as _i2.IPortfolioRepository);

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
  _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>> renamePortfolio(
    String? id,
    String? newName,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #renamePortfolio,
          [
            id,
            newName,
          ],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #renamePortfolio,
            [
              id,
              newName,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #renamePortfolio,
            [
              id,
              newName,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}

/// A class which mocks [AddStockToPortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddStockToPortfolioUseCase extends _i1.Mock
    implements _i13.AddStockToPortfolioUseCase {
  @override
  _i2.IPortfolioRepository get portfoliorepository => (super.noSuchMethod(
        Invocation.getter(#portfoliorepository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
      ) as _i2.IPortfolioRepository);

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
  _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>> addStockPortfolio(
    String? id,
    String? symbol,
    int? quantity,
    double? price,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addStockPortfolio,
          [
            id,
            symbol,
            quantity,
            price,
          ],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #addStockPortfolio,
            [
              id,
              symbol,
              quantity,
              price,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #addStockPortfolio,
            [
              id,
              symbol,
              quantity,
              price,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}

/// A class which mocks [RemoveStockToPortfolioUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveStockToPortfolioUseCase extends _i1.Mock
    implements _i14.RemoveStockToPortfolioUseCase {
  @override
  _i2.IPortfolioRepository get portfoliorepository => (super.noSuchMethod(
        Invocation.getter(#portfoliorepository),
        returnValue: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
        returnValueForMissingStub: _FakeIPortfolioRepository_0(
          this,
          Invocation.getter(#portfoliorepository),
        ),
      ) as _i2.IPortfolioRepository);

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
      _i5.Either<_i8.Failure, _i9.PortfolioCombined>> removeStockPortfolio(
    String? id,
    String? symbol,
    int? quantity,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeStockPortfolio,
          [
            id,
            symbol,
            quantity,
          ],
        ),
        returnValue:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #removeStockPortfolio,
            [
              id,
              symbol,
              quantity,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>.value(
                _FakeEither_3<_i8.Failure, _i9.PortfolioCombined>(
          this,
          Invocation.method(
            #removeStockPortfolio,
            [
              id,
              symbol,
              quantity,
            ],
          ),
        )),
      ) as _i7.Future<_i5.Either<_i8.Failure, _i9.PortfolioCombined>>);
}
