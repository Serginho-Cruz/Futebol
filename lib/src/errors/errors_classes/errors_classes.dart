abstract class Failure implements Exception {}

class EmptyList extends Failure {
  String msg;
  EmptyList(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class NoSelectionsFound extends Failure {
  String msg;
  NoSelectionsFound(this.msg);

  @override
  String toString() => msg;
}

class NoMatchFound extends Failure {
  String msg;
  NoMatchFound(this.msg);

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

class NoMatchsFound extends Failure {
  String msg;
  NoMatchsFound(this.msg);

  @override
  String toString() => msg;
}
