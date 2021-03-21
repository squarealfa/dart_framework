/// Represents an exception ocurred at the database engine
/// when trying to perform an operation.
class DbException {
  /// The message of the exception
  final String? message;

  // A database-engine specific error code.
  final String? code;

  // A database-engine specific error number.
  final String? number;

  DbException({
    this.message,
    this.code,
    this.number,
  });
}
