abstract class Failure implements Exception {}

class EmptyList extends Failure {}

class InvalidGroupText extends Failure {}

class DataSourceError extends Failure {}
