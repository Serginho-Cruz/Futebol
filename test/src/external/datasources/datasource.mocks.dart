// Mocks generated by Mockito 5.3.0 from annotations
// in futebol/test/src/external/datasources/sqlite_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:futebol/src/domain/selecao_entity.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

import 'sqlite_datasource_test.dart' as _i2;

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

/// A class which mocks [DBMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBMock extends _i1.Mock implements _i2.DBMock {
  MockDBMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.Selecao> get selecoes =>
      (super.noSuchMethod(Invocation.getter(#selecoes),
          returnValue: <_i3.Selecao>[]) as List<_i3.Selecao>);
  @override
  set selecoes(List<_i3.Selecao>? _selecoes) =>
      super.noSuchMethod(Invocation.setter(#selecoes, _selecoes),
          returnValueForMissingStub: null);
  @override
  _i4.Future<List<Map<String, dynamic>>> getAll() => (super.noSuchMethod(
      Invocation.method(#getAll, []),
      returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
          <Map<String, dynamic>>[])) as _i4.Future<List<Map<String, dynamic>>>);
  @override
  _i4.Future<List<Map<String, dynamic>>> getByGroup(String? group) =>
      (super.noSuchMethod(Invocation.method(#getByGroup, [group]),
              returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i4.Future<List<Map<String, dynamic>>>);
  @override
  _i4.Future<Map<String, dynamic>> getSelecaoById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getSelecaoById, [id]),
              returnValue:
                  _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i4.Future<Map<String, dynamic>>);
}