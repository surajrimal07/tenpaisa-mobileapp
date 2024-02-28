// Mocks generated by Mockito 5.4.4 from annotations
// in paisa/test/unit_test/commodity_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:paisa/core/common/cache/commodity_cache.dart' as _i3;
import 'package:paisa/core/failure/failure.dart' as _i7;
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart'
    as _i8;
import 'package:paisa/feathures/home/domain/repository/commodity_repository.dart'
    as _i2;
import 'package:paisa/feathures/home/domain/usecase/commodity_usecase.dart'
    as _i5;

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

class _FakeICommodityRepository_0 extends _i1.SmartFake
    implements _i2.ICommodityRepository {
  _FakeICommodityRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCommodityCache_1 extends _i1.SmartFake
    implements _i3.CommodityCache {
  _FakeCommodityCache_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CommodityUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommodityUseCase extends _i1.Mock implements _i5.CommodityUseCase {
  @override
  _i2.ICommodityRepository get commodityRepository => (super.noSuchMethod(
        Invocation.getter(#commodityRepository),
        returnValue: _FakeICommodityRepository_0(
          this,
          Invocation.getter(#commodityRepository),
        ),
        returnValueForMissingStub: _FakeICommodityRepository_0(
          this,
          Invocation.getter(#commodityRepository),
        ),
      ) as _i2.ICommodityRepository);

  @override
  _i3.CommodityCache get commodityCache => (super.noSuchMethod(
        Invocation.getter(#commodityCache),
        returnValue: _FakeCommodityCache_1(
          this,
          Invocation.getter(#commodityCache),
        ),
        returnValueForMissingStub: _FakeCommodityCache_1(
          this,
          Invocation.getter(#commodityCache),
        ),
      ) as _i3.CommodityCache);

  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i8.CommodityEntity>>>
      getCommodity() => (super.noSuchMethod(
            Invocation.method(
              #getCommodity,
              [],
            ),
            returnValue: _i6.Future<
                    _i4.Either<_i7.Failure, List<_i8.CommodityEntity>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.CommodityEntity>>(
              this,
              Invocation.method(
                #getCommodity,
                [],
              ),
            )),
            returnValueForMissingStub: _i6.Future<
                    _i4.Either<_i7.Failure, List<_i8.CommodityEntity>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.CommodityEntity>>(
              this,
              Invocation.method(
                #getCommodity,
                [],
              ),
            )),
          ) as _i6.Future<_i4.Either<_i7.Failure, List<_i8.CommodityEntity>>>);
}
