import 'package:mongo_dart/mongo_dart.dart';

class EntityDb {
  final Db db;
  final bool secure;
  final DbCollection _collection;

  EntityDb(this.db, String collectionName, {this.secure = false})
      : _collection = db.collection(collectionName);

  Future<DbCollection> get collection async {
    if (!db.isConnected) {
      if (db.state == State.OPENING) {
        db.state = State.CLOSED;
      }
      await db.open(secure: secure);
    }
    return _collection;
  }
}
