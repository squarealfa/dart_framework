// Put public facing types in this file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arango_driver/arango_driver.dart';
import 'package:arango_driver/src/results/create_database_info.dart';
import 'package:arango_driver/src/results/document_response.dart';
import 'package:arango_driver/src/results/identifier.dart';
import 'package:arango_driver/src/results/key_options.dart';
import 'package:arango_driver/src/results/operation_result.dart';
import 'package:arango_driver/src/results/result.dart';
import 'package:arango_driver/src/transactions/transaction_response.dart';
import 'package:arango_driver/src/transactions/transaction_states.dart';

import 'results/collection_info.dart';
import 'results/collection_properties_response.dart';
import 'results/collection_response.dart';
import 'results/db_info_response.dart';
import 'results/id_response.dart';
import 'results/result_response.dart';
import 'transactions/transaction.dart';
import 'transactions/transaction_options.dart';

class ArangoDBClient {
  final String scheme;
  final String host;
  final int port;
  final String db;
  final String user;
  final String pass;
  final String realm;

  late Uri dbUrl;
  late HttpClientBasicCredentials credentials;
  late HttpClient httpClient;

  ArangoDBClient({
    this.scheme = 'http',
    this.host = 'localhost',
    this.port = 8529,
    this.db = '_system',
    required this.user,
    required this.pass,
    this.realm = '',
  }) {
    ({
      'sheme': scheme,
      'db': db,
      'host': host,
      'port': port,
      'user': user,
      'pass': pass,
      'realm': realm,
    }).forEach((k, v) => ArgumentError.checkNotNull(v, k));

    dbUrl =
        Uri(scheme: scheme, host: host, port: port, pathSegments: ['_db', db]);

    _connect();
  }

  factory ArangoDBClient.fromConnectionString(String connectionString) {
    var scheme = 'http';
    var host = 'localhost';
    var port = 8529;
    var db = '_system';
    var user = '';
    var pass = '';

    final parts = connectionString.split(';');

    for (final part in parts) {
      final subParts = part.split('=');
      if (subParts.length != 2) {
        continue;
      }
      final name = subParts[0];
      final value = subParts[1];
      switch (name) {
        case 'scheme':
          scheme = value;
          break;
        case 'server':
        case 'hostname':
        case 'host':
          host = value;
          break;
        case 'port':
          port = int.tryParse(value) ?? 8529;
          break;
        case 'database':
        case 'db':
          db = value;
          break;
        case 'user':
        case 'username':
          user = value;
          break;
        case 'pass':
        case 'password':
          pass = value;
          break;
      }
    }
    final ret = ArangoDBClient(
      scheme: scheme,
      host: host,
      port: port,
      db: db,
      user: user,
      pass: pass,
    );
    return ret;
  }

  void _connect() {
    credentials = HttpClientBasicCredentials(user, pass);
    httpClient = HttpClient();
    httpClient.addCredentials(dbUrl, realm, credentials);
  }

  /// Retrieves information about the current database
  /// https://www.arangodb.com/docs/devel/http/database-database-management.html#information-of-the-database
  Future<ResultResponse<DbInfoResult>> currentDatabase() async {
    final response = await _httpGet(['_db', db, '_api', 'database', 'current']);
    final ret = _toResultResponse(response, _toDbInfoResult);
    return ret;
  }

  /// List of accessible databases for current user
  /// https://www.arangodb.com/docs/devel/http/database-database-management.html#list-of-accessible-databases
  Future<ResultResponse<List<String>>> userDatabases() async {
    final response = await _httpGet(['_db', db, '_api', 'database', 'user']);
    final result = _toResultResponse(response, _toListResult);
    return result;
  }

  /// Retrieves the list of all existing databases (availabe or not)
  /// https://www.arangodb.com/docs/devel/http/database-database-management.html#list-of-databases
  Future<ResultResponse<List<String>>> existingDatabases() async {
    final response = await _httpGet(['_db', db, '_api', 'database']);
    final result = _toResultResponse(response, _toListResult);
    return result;
  }

  /// Creates a database.
  /// The data with these properties is required:
  ///
  /// name: Has to contain a valid database name.
  /// users: Has to be an array of user objects to
  ///  initially create for the new database.
  ///
  /// User information will not be changed for users that already exist.
  ///   If users is not specified or does not contain any users,
  ///   a default user root will be created with an empty string password.
  ///   This ensures that the new database will be
  ///  accessible after it is created.
  ///   Each user object can contain the following attributes:
  ///
  /// username: Login name of the user to be created
  /// passwd: The user password as a string.
  /// If not specified, it will default to an empty string.
  /// active: A flag indicating whether the user account
  /// should be activated or not.
  ///   The default value is true.
  /// If set to false, the user won’t be able to log into the database.
  /// extra: A JSON object with extra user information.
  ///   The data contained in extra will be stored
  /// for the user but not be interpreted further by ArangoDB.
  /// https://www.arangodb.com/docs/devel/http/database-database-management.html#create-database
  Future<ResultResponse<bool>> createDatabase(
      CreateDatabaseInfo databaseInfo) async {
    final info = {
      'name': databaseInfo.name,
      'users': databaseInfo.databaseUsers
          .map((u) => {
                'username': u.username,
                'passwd': u.password,
              })
          .toList()
    };

    return _toResultResponse(
        await _httpPost(['_db', db, '_api', 'database'], info));
  }

  /// Drops the database along with all data stored in it.
  /// https://www.arangodb.com/docs/devel/http/database-database-management.html#drop-database
  Future<ResultResponse<bool>> dropDatabase(String name) async =>
      _toResultResponse(
          await _httpDelete(['_db', db, '_api', 'database', name]));

  /// Creates a collection
  /// See https://www.arangodb.com/docs/3.4/http/collection-creating.html for details.
  Future<CollectionPropertiesResponse> createCollection({
    required String name,
    bool waitForSync = false,
    CollectionType collectionType = CollectionType.document,
  }) async {
    final answer = await _httpPost([
      '_db',
      db,
      '_api',
      'collection'
    ], {
      'name': name,
      'waitForSync': waitForSync,
      'type': _typeFromCollectionType(collectionType),
    });
    final ret = _toCollectionPropertiesResult(answer);
    return ret;
  }

  /// Creates a collection
  /// See https://www.arangodb.com/docs/devel/http/indexes-working-with.html for details.
  Future<IndexResponse> createPersistentIndex({
    required String collectionName,
    required String indexName,
    required List<String> fields,
    bool unique = false,
    bool deduplicate = false,
    bool sparse = false,
    bool inBackground = false,
  }) async {
    final answer = await _httpPost([
      '_db',
      db,
      '_api',
      'index'
    ], {
      'name': indexName,
      'type': 'persistent',
      'fields': fields,
      'unique': unique,
      'deduplicate': deduplicate,
      'sparse': sparse,
      'inBackground': inBackground,
    }, queryParameters: {
      'collection': collectionName,
    });
    final ret = _toIndexResponse(answer);
    return ret;
  }

  /// Drops a collection
  /// https://www.arangodb.com/docs/stable/http/collection-creating.html#drops-a-collection
  Future<IdResponse> dropCollection(String name,
      {bool isSystem = false}) async {
    final answer = await _httpDelete(['_db', db, '_api', 'collection', name],
        queryParameters: {'isSystem': jsonEncode(isSystem)});
    final ret = _toIdResponse(answer);
    return ret;
  }

  /// Truncates a collection
  Future<CollectionResponse> truncateCollection(
    String name, {
    Transaction? transaction,
  }) async {
    final answer = await _httpPut(
      ['_db', db, '_api', 'collection', name, 'truncate'],
      headers: _addTransactionHeader(transaction),
    );
    final response = _toCollectionResponse(answer);

    return response;
  }

  /// Gets id, name, status of collection
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#return-information-about-a-collection
  Future<CollectionResponse> collectionInfo(String name) async {
    final answer = await _httpGet(['_db', db, '_api', 'collection', name]);
    final response = _toCollectionResponse(answer);
    return response;
  }

  /// Get collection properties
  /// See https://www.arangodb.com/docs/3.4/http/collection-getting.html#read-properties-of-a-collection for details
  Future<CollectionPropertiesResponse> collectionProperties(String name) async {
    var answer =
        await _httpGet(['_db', db, '_api', 'collection', name, 'properties']);
    final response = _toCollectionPropertiesResult(answer);
    return response;
  }

  /// Returns number of documents in a collection
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#return-number-of-documents-in-a-collection
  Future<CollectionPropertiesResponse> documentsCount(
    String collectionName, {
    Transaction? transaction,
  }) async {
    final answer = await _httpGet(
      ['_db', db, '_api', 'collection', collectionName, 'count'],
      headers: _addTransactionHeader(transaction),
    );
    final response = _toCollectionPropertiesResult(answer);
    return response;
  }

  /// Returns statistics for a collection
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#return-statistics-for-a-collection
  Future<CollectionPropertiesResponse> collectionStatistics(
      String collectionName) async {
    final answer = await _httpGet(
        ['_db', db, '_api', 'collection', collectionName, 'figures']);
    final response = _toCollectionPropertiesResult(answer);
    return response;
  }

  /// Returns collection revision id
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#return-collection-revision-id
  Future<CollectionPropertiesResponse> collectionRevisionId(
      String collectionName) async {
    final answer = await _httpGet(
        ['_db', db, '_api', 'collection', collectionName, 'revision']);
    final response = _toCollectionPropertiesResult(answer);
    return response;
  }

  /// Returns checksum for the collection
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#return-checksum-for-the-collection
  Future<CollectionResponse> collectionChecksum(String collectionName) async {
    final answer = await _httpGet(
        ['_db', db, '_api', 'collection', collectionName, 'checksum']);
    final response = _toCollectionResponse(answer);
    return response;
  }

  /// Reads all collections
  /// https://www.arangodb.com/docs/3.4/http/collection-getting.html#reads-all-collections
  Future<ResultResponse<List<CollectionInfo>>> allCollections() async {
    final answer = await _httpGet(['_db', db, '_api', 'collection']);
    final result = _toResultResponse(answer, _toCollectionListResponse);
    return result;
  }

  /// Creates document
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#create-document
  Future<OperationResult> createDocument(
    String collectionName,
    Map<String, dynamic> data, {
    Transaction? transaction,
  }) async {
    final answer = await _httpPost(
      ['_db', db, '_api', 'document', collectionName],
      data,
      headers: _addTransactionHeader(transaction),
    ) as Map<String, dynamic>;
    final ret = _toOperationResult(answer);
    return ret;
  }

  Future<List<OperationResult>> createDocuments(
    String collectionName,
    List<Map<String, dynamic>> data, {
    Transaction? transaction,
  }) async {
    var ret = ((await _httpPost(
      ['_db', db, '_api', 'document', collectionName],
      data,
      headers: _addTransactionHeader(transaction),
    )) as List)
        .map((e) => _toOperationResult(e as Map<String, dynamic>))
        .toList();
    return ret;
  }

  /// Reads a single document
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#read-document
  ///
  /// If ifNoneMatchRevision was given
  /// and this revision equals the latest version of found document,
  /// then server will return 304 status code
  /// and this driver will return empty Map.
  ///
  /// If ifMatchRevision was given
  /// and document with this revision was not found,
  /// then not empty Map will returned,
  /// but with code=412 and error=true and corresponding errorMessage.
  Future<DocumentResponse> getDocumentByKey(
    String collection,
    String documentKey, {
    String? ifNoneMatchRevision,
    String? ifMatchRevision,
    Transaction? transaction,
  }) async {
    var result = await _httpGet(
      ['_db', db, '_api', 'document', collection, documentKey],
      headers: _addTransactionHeader(transaction, headers: {
        'accept': 'application/json',
        'If-None-Match': ifNoneMatchRevision,
        'If-Match': ifMatchRevision,
      }),
    );
    if (result == null || result.length == 0) {
      return DocumentResponse(
          result: Result.empty(), document: <String, dynamic>{});
    }
    var ret = DocumentResponse(
      document: result,
      result: _toResult(result),
    );
    return ret;
  }

  /// Replaces document
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#replace-document
  Future<OperationResult> replaceDocument(
    String collectionName,
    String documentKey,
    Map<String, dynamic> data, {
    String? ifMatchRevision,
    Map<String, dynamic> queryParams = const {},
    Transaction? transaction,
  }) async {
    final answer = await _httpPut(
      ['_db', db, '_api', 'document', collectionName, documentKey],
      postData: data,
      queryParameters: queryParams,
      headers: _addTransactionHeader(
        transaction,
        headers: {'If-Match': ifMatchRevision},
      ),
    );
    final ret = _toOperationResult(answer);
    return ret;
  }

  /// Replaces multiple documents
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#replace-documents
  Future<List<OperationResult>> replaceDocuments(
    String collectionName,
    List<Map<String, dynamic>> data, {
    Map<String, dynamic> queryParams = const {},
    Transaction? transaction,
  }) async {
    final answer = ((await _httpPut(
      ['_db', db, '_api', 'document', collectionName],
      postData: data,
      queryParameters: queryParams,
      headers: _addTransactionHeader(transaction),
    )) as List)
        .map((e) => _toOperationResult(e as Map<String, dynamic>))
        .toList();
    return answer;
  }

  /// Updates a document
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#update-document
  Future<OperationResult> updateDocument(
    String collectionName,
    String documentKey,
    Map<String, dynamic> data, {
    String? ifMatchRevision,
    Map<String, dynamic> queryParams = const {},
    Transaction? transaction,
  }) async {
    final answer = await _httpPatch(
      ['_db', db, '_api', 'document', collectionName, documentKey],
      data,
      queryParameters: queryParams,
      headers: _addTransactionHeader(
        transaction,
        headers: {'If-Match': ifMatchRevision},
      ),
    );
    final ret = _toOperationResult(answer);
    return ret;
  }

  // td: updates multiple documents
  // https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#update-documents

  /// Removes a document
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#removes-a-document
  Future<OperationResult> removeDocument(
    String collectionName,
    String documentKey, {
    String? ifMatchRevision,
    Map<String, dynamic> queryParams = const {},
    Transaction? transaction,
  }) async {
    final answer = await _httpDelete(
      ['_db', db, '_api', 'document', collectionName, documentKey],
      queryParameters: queryParams,
      headers: _addTransactionHeader(
        transaction,
        headers: {'If-Match': ifMatchRevision},
      ),
    );
    var ret = _toOperationResult(answer);
    return ret;
  }

  /// td: Removes multiple documents
  /// https://www.arangodb.com/docs/3.4/http/document-working-with-documents.html#removes-multiple-documents
  Future<List<OperationResult>> removeDocuments(
    String collectionName,
    List<Map<String, dynamic>> data, {
    Map<String, dynamic> queryParams = const {},
    Transaction? transaction,
  }) async {
    final answer = (await _httpDelete(
      ['_db', db, '_api', 'document', collectionName],
      postData: data,
      queryParameters: queryParams,
      headers: _addTransactionHeader(transaction),
    ) as List)
        .map((e) => _toOperationResult(e as Map<String, dynamic>))
        .toList();
    return answer;
  }

  /// Begins a transaction
  /// https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html#begin-a-transaction
  Future<TransactionResponse> beginTransaction(
      TransactionOptions options) async {
    var data = _getTransactionOptionsData(options);

    final answer =
        await _httpPost(['_db', db, '_api', 'transaction', 'begin'], data)
            as Map<String, dynamic>;
    final ret = _toTransactionResponse(answer);
    return ret;
  }

  /// Gets a transaction status
  /// https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html#get-transaction-status
  Future<TransactionResponse> getTransaction(String id) async {
    final answer = await _httpGet(['_db', db, '_api', 'transaction', id])
        as Map<String, dynamic>;
    final ret = _toTransactionResponse(answer);
    return ret;
  }

  /// Commits a transaction
  /// https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html#commit-transaction
  Future<TransactionResponse> commitTransaction(Transaction transaction) async {
    final answer =
        await _httpPut(['_db', db, '_api', 'transaction', transaction.id])
            as Map<String, dynamic>;
    final ret = _toTransactionResponse(answer);
    return ret;
  }

  /// Aborts a transaction
  /// https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html#abort-transaction
  Future<TransactionResponse> abortTransaction(Transaction transaction) async {
    final answer =
        await _httpDelete(['_db', db, '_api', 'transaction', transaction.id])
            as Map<String, dynamic>;
    final ret = _toTransactionResponse(answer);
    return ret;
  }

  /// Gets currently running transactions
  /// https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html#list-currently-ongoing-transactions
  Future<List<Transaction>> transactions() async {
    final answer = await _httpGet(['_db', db, '_api', 'transaction'])
        as Map<String, dynamic>;
    final trxs = answer['transactions'] as List<Map<String, dynamic>>;
    final lst = trxs.map((e) => _getTransaction(e)).toList();
    return lst;
  }

  Stream<Map<String, dynamic>> queryToStream(
    Map<String, Object> data, {
    Transaction? transaction,
  }) async* {
    var streamStream = _queryToStreamStream(
      data,
      transaction: transaction,
    );
    await for (var batch in streamStream) {
      var items = batch['result'];
      for (var item in items) {
        yield item as Map<String, dynamic>;
      }
    }
  }

  static Future _toMap(HttpClientRequest req) async {
    var resp = await req.close();
    var text = await resp.transform(utf8.decoder).join();

    if (text.isEmpty) {
      return {};
    }
    try {
      return json.decode(text);
    } catch (e) {
      throw {
        'message': "Can't decode HTTP response as json",
        'error': e,
        'response text': text,
        //  "request": await _toMap(req),
      };
    }
  }

  Future _queryFirstBatch(
    Map<String, Object> data, {
    Transaction? transaction,
  }) async {
    return _httpPost(
      ['_db', db, '_api', 'cursor'],
      data,
      headers: _addTransactionHeader(transaction),
    );
  }

  Future _fetchNextBatch(
    int cursorId, {
    Transaction? transaction,
  }) async {
    return _httpPut(
      ['_db', db, '_api', 'cursor', cursorId.toString()],
      headers: _addTransactionHeader(transaction),
    );
  }

  /// Makes query to ArangoDB batabase.
  Stream _queryToStreamStream(
    Map<String, Object> data, {
    Transaction? transaction,
  }) async* {
    var resultData = await _queryFirstBatch(data, transaction: transaction);
    yield resultData;
    while (resultData.containsKey('id') &&
        resultData.containsKey('hasMore') &&
        resultData['hasMore'] as bool == true) {
      var cursorId = int.parse(resultData['id'] as String);
      resultData = await _fetchNextBatch(cursorId, transaction: transaction);
      yield resultData;
    }
  }

  /// Makes query to ArangoDB batabase,
  /// collect results in memory and return as List.
  /// If result has error - throws error.
  Future<List<Map<String, dynamic>>> queryToList(
    Map<String, Object> data, {
    Transaction? transaction,
  }) async {
    var result = <Map<String, dynamic>>[];

    await for (var batch in _queryToStreamStream(
      data,
      transaction: transaction,
    )) {
      if (batch['error']) {
        throw batch;
      }
      var records = batch['result'] as List;
      for (var record in records) {
        result.add(record);
      }
    }
    return result;
  }

  Future _httpGet(Iterable<String> pathSegments,
          {Map<String, dynamic> queryParameters = const {},
          Map<String, dynamic> headers = const {}}) async =>
      _http('GET', pathSegments,
          queryParameters: queryParameters, headers: headers);

  Future _httpDelete(Iterable<String> pathSegments,
          {postData,
          Map<String, dynamic> queryParameters = const {},
          Map<String, dynamic> headers = const {}}) async =>
      _http('DELETE', pathSegments,
          queryParameters: queryParameters,
          headers: headers,
          postData: postData);

  Future _httpPut(Iterable<String> pathSegments,
          {postData,
          Map<String, dynamic> queryParameters = const {},
          Map<String, dynamic> headers = const {}}) async =>
      _http('PUT', pathSegments,
          queryParameters: queryParameters,
          headers: headers,
          postData: postData);

  Future _httpPost(Iterable<String> pathSegments, postData,
          {Map<String, dynamic> queryParameters = const {},
          Map<String, dynamic> headers = const {}}) async =>
      await _http('POST', pathSegments,
          queryParameters: queryParameters,
          headers: headers,
          postData: postData);

  Future _httpPatch(Iterable<String> pathSegments, postData,
          {Map<String, dynamic> queryParameters = const {},
          Map<String, dynamic> headers = const {}}) async =>
      await _http('PATCH', pathSegments,
          queryParameters: queryParameters,
          headers: headers,
          postData: postData);

  Future _http(
    String method,
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
    postData,
  }) async {
    var url = dbUrl.replace(pathSegments: pathSegments);

    if (queryParameters.isNotEmpty) {
      url = url.replace(queryParameters: queryParameters);
    }

    var req = await httpClient.openUrl(method, url);

    for (var headerName in headers.keys) {
      if (headers[headerName] == null) continue;
      req.headers.add(headerName, headers[headerName]);
    }

    if (postData != null) {
      var json = jsonEncode(postData);
      req.headers.contentType = ContentType.json;
      req.headers.contentLength = utf8.encode(json).length;
      req.write(json);
    }

    return await _toMap(req);
  }

  static ResultResponse<T> _toResultResponse<T>(
    Map<String, dynamic> map, [
    T Function(dynamic map)? convert,
  ]) =>
      ResultResponse<T>(
        result: _toResult(map),
        response: map['result'] == null
            ? null
            : convert == null
                ? map['result']
                : convert(map['result']),
      );

  static DbInfoResult _toDbInfoResult(dynamic map) {
    return DbInfoResult(
      id: map['id'],
      isSystem: map['isSystem'],
      name: map['name'],
      path: map['path'],
    );
  }

  static List<String> _toListResult(dynamic map) {
    return (map as List).map((e) => e as String).toList();
  }

  static List<CollectionInfo> _toCollectionListResponse(dynamic map) {
    var ret = (map as List).map((e) => _toCollectionInfo(e)).toList();

    return ret;
  }

  static Result _toResult(Map<String, dynamic>? map) => Result(
        error: (map ??= {})['error'] ?? false,
        code: map['code'] ?? 0,
        errorMessage: map['errorMessage'],
        errorNum: map['errorNum'],
      );

  static IdResponse _toIdResponse(Map<String, dynamic> map) => IdResponse(
        result: _toResult(map),
        id: map['id'],
      );

  static TransactionResponse _toTransactionResponse(Map<String, dynamic> map) {
    final transaction = _getTransaction(map['result'] ?? {});
    final ret = TransactionResponse(
      result: _toResult(map),
      transaction: transaction,
    );
    return ret;
  }

  static Transaction _getTransaction(Map<String, dynamic> map) {
    final id = map['id']?.toString() ?? '';
    final state = _getTransactionState(map['status']?.toString() ?? '');
    final transaction = Transaction(
      id: id,
      state: state,
    );
    return transaction;
  }

  static TransactionStates _getTransactionState(String strState) {
    switch (strState) {
      case 'running':
        return TransactionStates.running;
      case 'committed':
        return TransactionStates.committed;
      case 'aborted':
        return TransactionStates.aborted;
      default:
        return TransactionStates.unknown;
    }
  }

  static CollectionInfo _toCollectionInfo(Map<String, dynamic> map) =>
      CollectionInfo(
        type: map['type'],
        isSystem: map['isSystem'],
        id: map['id'],
        globallyUniqueId: map['globallyUniqueId'],
        name: map['name'],
        status: map['status'],
        count: map['count'],
      );

  static CollectionResponse _toCollectionResponse(Map<String, dynamic> map) =>
      CollectionResponse(
        result: _toResult(map),
        collectionInfo: _toCollectionInfo(map),
      );

  static CollectionPropertiesResponse _toCollectionPropertiesResult(
      Map<String, dynamic> map) {
    return CollectionPropertiesResponse(
      result: _toResult(map),
      collectionInfo: _toCollectionInfo(map),
      writeConcern: map['writeConcern'],
      waitForSync: map['waitForSync'],
      tempObjectId: map['tempObjectId'],
      cacheEnabled: map['cacheEnabled'],
      isSmartChild: map['isSmartChild'],
      objectId: map['objectId'],
      schema: map['schema'],
      keyOptions: KeyOptions(
        allowUserKeys: map['keyOptions']['allowUserKeys'],
        type: map['keyOptions']['type'],
        lastValue: map['keyOptions']['lastValue'],
      ),
      isDisjoint: map['isDisjoint'],
      statusString: map['statusString'],
    );
  }

  static IndexResponse _toIndexResponse(Map<String, dynamic> map) {
    return IndexResponse(
      result: _toResult(map),
      indexInfo: IndexInfo(
        id: map['id'],
        name: map['name'],
        isNewlyCreated: map['isNewlyCreated'],
        fields: List<String>.from(map['fields']),
        type: _indexTypeFromString(map['type']),
        unique: map['unique'],
        deduplicate: map['deduplicate'],
        sparse: map['sparse'],
        selectivityEstimate: map['selectivityEstimate'],
      ),
    );
  }

  static Identifier _toIdentifier(Map<String, dynamic>? map) => Identifier(
        id: (map ??= {})['_id'] ?? '',
        key: map['_key'] ?? '',
        rev: map['_rev'] ?? '',
      );

  static OperationResult _toOperationResult(Map<String, dynamic>? map) =>
      OperationResult(
        map: map ??= {},
        result: _toResult(map),
        identifier: _toIdentifier(map),
        oldRev: map['_oldRev'] ?? '',
      );

  static Map<String, dynamic> _getTransactionOptionsData(
      TransactionOptions options) {
    final collections = {};
    if (options.readCollections.isNotEmpty) {
      collections['read'] = options.readCollections;
    }
    if (options.writeCollections.isNotEmpty) {
      collections['write'] = options.writeCollections;
    }
    if (options.exclusiveCollections.isNotEmpty) {
      collections['exclusive'] = options.exclusiveCollections;
    }
    final data = <String, dynamic>{'collections': collections};
    if (options.waitForSync != null) {
      data['waitForSync'] = options.waitForSync.toString();
    }
    if (options.allowImplicit != null) {
      data['allowImplicit'] = options.allowImplicit.toString();
    }
    if (options.lockTimeoutSeconds != null) {
      data['lockTimeout'] = options.lockTimeoutSeconds.toString();
    }
    if (options.maxTransactionSizeBytes != null) {
      data['maxTransactionSize'] = options.maxTransactionSizeBytes.toString();
    }
    return data;
  }

  static Map<String, dynamic> _addTransactionHeader(
    Transaction? transaction, {
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) {
    if (transaction == null) {
      return headers;
    }
    final ret = {...headers, 'x-arango-trx-id': transaction.id};
    return ret;
  }

  static int _typeFromCollectionType(CollectionType collectionType) {
    switch (collectionType) {
      case CollectionType.document:
        return 2;
      case CollectionType.edge:
        return 3;
      default:
        throw UnimplementedError();
    }
  }

  static IndexType _indexTypeFromString(String type) {
    switch (type) {
      case 'persistent':
        return IndexType.persistent;
      case 'geo':
        return IndexType.geo;
      case 'fulltext':
        return IndexType.fulltext;
      case 'ttl':
        return IndexType.ttl;
      default:
        throw UnimplementedError();
    }
  }
}
