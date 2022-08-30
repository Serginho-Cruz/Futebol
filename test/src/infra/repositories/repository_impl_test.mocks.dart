// Mocks generated by Mockito 5.3.0 from annotations
// in futebol/test/src/infra/repositories/repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:futebol/src/domain/selecao_entity.dart' as _i6;
import 'package:futebol/src/errors/errors.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

import 'repository_impl_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [DataSourceMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataSourceMock extends _i1.Mock implements _i3.DataSourceMock {
  MockDataSourceMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>> getAllSelecoes() =>
      (super.noSuchMethod(Invocation.method(#getAllSelecoes, []),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.Selecao>>(
                          this, Invocation.method(#getAllSelecoes, []))))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>> getSelecaoByGroup(
          String? group) =>
      (super.noSuchMethod(Invocation.method(#getSelecaoByGroup, [group]),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.Selecao>>(this,
                          Invocation.method(#getSelecaoByGroup, [group]))))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Selecao>> getSelecaoById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getSelecaoById, [id]),
          returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Selecao>>.value(
              _FakeEither_0<_i5.Failure, _i6.Selecao>(
                  this, Invocation.method(#getSelecaoById, [id])))) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.Selecao>>);
}