abstract class Failure implements Exception {}

class EmptyList extends Failure {
  String msg;

  EmptyList(this.msg);

  @override
  String toString() => msg;
}
