// Mocks generated by Mockito 5.3.0 from annotations
// in futebol/test/src/data/usecases/SoccerMatchUC/get_matchs_by_type_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:futebol/src/domain/entities/Match/match_entity.dart' as _i7;
import 'package:futebol/src/domain/entities/Selection/selection_entity.dart'
    as _i6;
import 'package:futebol/src/errors/errors_classes/errors_classes.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

import 'SoccerMatchUC/get_matchs_by_type_impl_test.dart' as _i3;

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

/// A class which mocks [SoccerMatchMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepositoryMock extends _i1.Mock implements _i3.SoccerMatchMock {
  MockSoccerMatchMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>> getAllSelections() =>
      (super.noSuchMethod(Invocation.method(#getAllSelections, []),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.Selecao>>(
                          this, Invocation.method(#getAllSelections, []))))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>> getSelectionsByGroup(
          String? group) =>
      (super.noSuchMethod(Invocation.method(#getSelectionsByGroup, [group]),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.Selecao>>(this,
                          Invocation.method(#getSelectionsByGroup, [group]))))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Selecao>> getSelection(int? id) =>
      (super.noSuchMethod(Invocation.method(#getSelection, [id]),
          returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Selecao>>.value(
              _FakeEither_0<_i5.Failure, _i6.Selecao>(
                  this, Invocation.method(#getSelection, [id])))) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.Selecao>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>> getMatchsByType(
          int? type) =>
      (super.noSuchMethod(Invocation.method(#getMatchsByType, [type]),
          returnValue:
              _i4.Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i7.SoccerMatch>>(this,
                      Invocation.method(#getMatchsByType, [type])))) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>> getMatchsByGroup(
          String? group) =>
      (super.noSuchMethod(Invocation.method(#getMatchsByGroup, [group]),
          returnValue:
              _i4.Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i7.SoccerMatch>>(this,
                      Invocation.method(#getMatchsByGroup, [group])))) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i7.SoccerMatch>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.SoccerMatch>> getMatchById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMatchById, [id]),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, _i7.SoccerMatch>>.value(
                      _FakeEither_0<_i5.Failure, _i7.SoccerMatch>(
                          this, Invocation.method(#getMatchById, [id]))))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.SoccerMatch>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>> getSelectionByIds(
          int? id, int? id2) =>
      (super.noSuchMethod(Invocation.method(#getSelectionByIds, [id, id2]),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.Selecao>>(this,
                          Invocation.method(#getSelectionByIds, [id, id2]))))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Selecao>>>);
}
