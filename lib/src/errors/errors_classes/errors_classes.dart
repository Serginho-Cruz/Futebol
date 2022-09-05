// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure implements Exception {}

class EmptyList extends Failure {
  String msg;
  EmptyList(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class SelectionError extends Failure {
  String msg;
  SelectionError(this.msg);

  @override
  String toString() => msg;
}

class InvalidSearchText extends Failure {
  String msg;

  InvalidSearchText(this.msg);

  @override
  String toString() => msg;
}

class DataSourceError extends Failure {
  String msg;
  DataSourceError(this.msg);

  @override
  String toString() => msg;
}

class InvalidId extends Failure {
  String msg;
  InvalidId(this.msg);

  @override
  String toString() => msg;
}
