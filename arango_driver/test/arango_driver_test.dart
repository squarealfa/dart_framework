import 'package:arango_driver/arango_driver.dart';
import 'package:test/test.dart';

import 'test_conf.dart';

void main() {
  group('Client can:', () {
    final sch = dbscheme;
    final h = dbhost;
    final p = dbport;
    const systemDb = '_system';
    const testDb = 'test_temp_db';
    const testCollection = 'test_temp_collection';
    late String testDocumentKey;
    String testDocumentRev;
    var testMultipleDocumentsKeys = <String>[];
    final u = dbuser;
    final ps = dbpass;
    const realm = '';

    var clientSystemDb = ArangoDBClient(
        scheme: sch,
        host: h,
        port: p,
        db: systemDb,
        user: u,
        pass: ps,
        realm: realm);

    test('Get current db info', () async {
      var answer = await clientSystemDb.currentDatabase();
      if (answer.result.error) {
        print(answer);
      }

      expect(answer.response!.name, equals(systemDb));
      expect(answer.response!.isSystem, equals(true));
    });

    test('List of accessible databases', () async {
      var answer = await clientSystemDb.userDatabases();
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, equals(false));
      expect(answer.response, contains(systemDb));
    });

    test('List of all existing databases', () async {
      var answer = await clientSystemDb.existingDatabases();
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, equals(false));
      expect(answer.response, contains(systemDb));
    });

    test('Create a database', () async {
      // first, ask about all databases
      var databases = await clientSystemDb.existingDatabases();
      // skip test if test database already exists
      if (databases.response!.contains(testDb)) {
        print(
            // ignore: lines_longer_than_80_chars
            'Skip test for creating database because database $testDb already exists.');
        return;
      }
      // creating the test database
      var result = await clientSystemDb.createDatabase(
          CreateDatabaseInfo(testDb, [DatabaseUser('u', 'ps')]));

      expect(result.result.error, equals(false));
      expect(result.response, equals(true));
    });

    // changing current database
    var testDbClient = ArangoDBClient(
        scheme: sch,
        host: h,
        port: p,
        db: testDb,
        user: u,
        pass: ps,
        realm: realm);

    test('create collection', () async {
      var allCollectionsAnsw = await testDbClient.allCollections();
      var alreadyExists = allCollectionsAnsw.response!
          .any((coll) => coll.name == testCollection);
      if (alreadyExists) {
        print('Skip creating collection $testCollection bexause it is exists');
      } else {
        var answer = await testDbClient.createCollection(
          name: testCollection,
        );
        if (answer.result.error == true) {
          print(answer);
        }
        expect(answer.result.error, false);
        expect(answer.collectionInfo.name, testCollection);
      }
    });

    test('truncate collection', () async {
      var answer = await testDbClient.truncateCollection(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
      expect(answer.collectionInfo.name, testCollection);
    });

    test('get collection info', () async {
      var answer = await testDbClient.collectionInfo(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
      expect(answer.collectionInfo.name, testCollection);
    });

    test('get collection properties', () async {
      var answer = await testDbClient.collectionProperties(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('get count of documents in collection', () async {
      var answer = await testDbClient.documentsCount(testCollection);
      if (answer.result.error == true) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('get statistics for a collection', () async {
      var answer = await testDbClient.collectionStatistics(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('get collection revision id', () async {
      var answer = await testDbClient.collectionRevisionId(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('get collection checksum', () async {
      var answer = await testDbClient.collectionChecksum(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('get all collections', () async {
      var answer = await testDbClient.allCollections();
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    test('create document', () async {
      var answer =
          await testDbClient.createDocument(testCollection, {'Hello': 'World'});
      if (answer.result.error) {
        print(answer);
      }
      // save document key for next test:
      testDocumentKey = answer.identifier.key;
    });
    test('getDocumentByKey returns Map with _key', () async {
      var answer =
          await testDbClient.getDocumentByKey(testCollection, testDocumentKey);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.document, contains('_key'));
    });

    test('getDocumentByKey can require document revision', () async {
      // first get the doc:
      var answer =
          await testDbClient.getDocumentByKey(testCollection, testDocumentKey);
      // get its revision:
      expect(answer.document, contains('_rev'));
      if (answer.result.error) {
        print(answer);
      }
      // save its revision:
      testDocumentRev = answer.document['_rev'] as String;

      // now try to get the document with not matched revision:
      var emptyAnswer = await testDbClient.getDocumentByKey(
          testCollection, testDocumentKey,
          ifNoneMatchRevision: testDocumentRev);

      // because last revision equals ${testDocumentRev}
      // server answer will empty:
      expect(emptyAnswer.document, equals({}));

      // get document only required revision:
      var answerWithRevision = await testDbClient.getDocumentByKey(
          testCollection, testDocumentKey,
          ifMatchRevision: testDocumentRev);

      expect(answerWithRevision.document, contains('_rev'));
      if (answerWithRevision.result.error) {
        print(answerWithRevision);
      }
      expect(answerWithRevision.document['_rev'], equals(testDocumentRev));

      // try get doc with noexists revision:
      var notExistAnswer = await testDbClient.getDocumentByKey(
          testCollection, testDocumentKey,
          ifMatchRevision: 'my_wrong_rev');

      // we will get error responce:
      expect(notExistAnswer.result.error, equals(true));
      expect(notExistAnswer.result.code, equals(412));
    });

    test('update document', () async {
      // update document with returnNew:
      var updateAnswer = await testDbClient.updateDocument(
          testCollection, testDocumentKey, {'Hello': 'University'},
          queryParams: {'returnNew': 'true'});

      if (updateAnswer.map['new']['Hello'] != 'University') print(updateAnswer);

      expect(updateAnswer.map['new']['Hello'], 'University');

      // save revision:
      testDocumentRev = updateAnswer.map['_rev'] as String;

      var matchedUpdateAnswer = await testDbClient.updateDocument(
          testCollection, testDocumentKey, {'Hello': 'Underground'},
          ifMatchRevision: testDocumentRev);

      // document was updated:
      expect(matchedUpdateAnswer.oldRev, equals(testDocumentRev));

      // try to update not matched revision:
      var notMatchedUpdateAnswer = await testDbClient.updateDocument(
          testCollection,
          testDocumentKey,
          {'Bad trying': 'because bad revision'},
          ifMatchRevision: 'my_bad_rev');

      // we will get error in answer:
      expect(notMatchedUpdateAnswer.result.error, equals(true));
      expect(notMatchedUpdateAnswer.result.code, equals(412));
    });

    test('replace document', () async {
      // replace document with returnNew:
      var replaceAnswer = await testDbClient.replaceDocument(
          testCollection, testDocumentKey, {'Goodby': 'Moon'},
          queryParams: {'returnNew': 'true'});

      if (replaceAnswer.map['new']['Goodby'] != 'Moon') print(replaceAnswer);

      expect(replaceAnswer.map['new']['Goodby'], 'Moon');

      // save revision:
      testDocumentRev = replaceAnswer.map['_rev'] as String;

      var matchedReplaceAnswer = await testDbClient.replaceDocument(
          testCollection, testDocumentKey, {'Hello': 'Undeground'},
          ifMatchRevision: testDocumentRev);

      // document was updated:
      expect(matchedReplaceAnswer.oldRev, equals(testDocumentRev));

      // try to update not matched revision:
      var notMatchedReplaceAnswer = await testDbClient.replaceDocument(
          testCollection,
          testDocumentKey,
          {'Bad trying': 'because bad revision'},
          ifMatchRevision: 'my_bad_rev');

      // we will get error in answer:
      expect(notMatchedReplaceAnswer.result.error, equals(true));
      expect(notMatchedReplaceAnswer.result.code, equals(412));
    });

    test('replace multiple documents', () async {
      var replaceAnswer = await testDbClient.replaceDocuments(testCollection, [
        {'_key': testDocumentKey, 'Good evening': 'Jupiter'}
      ], queryParams: {
        'returnNew': 'true'
      });

      if (replaceAnswer[0].map['new']['_key'] != testDocumentKey) {
        print(replaceAnswer);
      }

      expect(replaceAnswer[0].map['new']['_key'], testDocumentKey);
    });

    test('remove document', () async {
      var answer = await testDbClient.removeDocument(
          testCollection, testDocumentKey,
          queryParams: {'returnOld': 'true'});

      if (answer.result.error) {
        print(answer);
      }

      expect(answer.map,
          allOf(contains('_id'), contains('_key'), contains('_rev')));

      if (!answer.map.containsKey('old')) print(answer);

      if (answer.map['old']['Good evening'] != 'Jupiter') print(answer);

      expect(answer.map['old']['Good evening'], 'Jupiter');

      // After this test document with `testDocumentKey` should be deleted.
    });

    test('create multiple documents', () async {
      var answer = await testDbClient.createDocuments(testCollection, [
        {'Hello': 'Earth'},
        {'Hello': 'Venus'}
      ]);
      // 2 documents was inserted:
      expect((answer).length, equals(2));
      // about first document:
      expect(answer[0].map,
          allOf(contains('_id'), contains('_key'), contains('_rev')));

      // save documents keys for later tests:
      for (var doc in answer) {
        testMultipleDocumentsKeys.add(doc.identifier.key);
      }
    });

    test('remove multiple documents', () async {
      var answer = await testDbClient.removeDocuments(testCollection, [
        // data should contain list of map with _key or _id attributes
        // for each document to remove
        {
          '_key': testMultipleDocumentsKeys[0],
        },
        {
          '_key': testMultipleDocumentsKeys[1],
        },
      ]);

      // print('----------> ${answer}');
      expect((answer).length, equals(2));

      // first of removed documents has the same key as in request body:
      expect((answer)[0].map['_key'], equals(testMultipleDocumentsKeys[0]));
    });

    test('create transaction', () async {
      var answer =
          await testDbClient.createDocument(testCollection, {'Hello': 'World'});
      if (answer.result.error) {
        print(answer);
      }
      // save document key for next test:
      testDocumentKey = answer.identifier.key;
    });

    test('drop collection', () async {
      var answer = await testDbClient.dropCollection(testCollection);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.result.error, false);
    });

    // back to _system db
    test('drop test database', () async {
      var answer = await clientSystemDb.dropDatabase(testDb);
      if (answer.result.error) {
        print(answer);
      }
      expect(answer.response, equals(true));
    });
  });
}
