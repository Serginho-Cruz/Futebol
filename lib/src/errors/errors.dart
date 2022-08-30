// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure implements Exception {}

class EmptyList extends Failure {
  String? msg;
  EmptyList([
    this.msg,
  ]);

  @override
  String toString() {
    return msg == null ? "Error: Empty List" : "Error: $msg";
  }
}

class SelecaoError extends Failure {
  String msg;
  SelecaoError(
    this.msg,
  );

  @override
  String toString() => "Error: $msg";
}

class InvalidSearchText extends Failure {
  String msg;

  InvalidSearchText(this.msg);

  @override
  String toString() => "Error: $msg";
}

class DataSourceError extends Failure {
  String? msg;
  DataSourceError([this.msg]);

  @override
  String toString() {
    return msg == null ? "Error: An Unexpected Error occured" : "Error: $msg";
  }
}

class InvalidId extends Failure {}
