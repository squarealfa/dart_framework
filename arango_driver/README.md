# ArangoDB driver for Dart with null safety

See EXAMPLE tab for example of code and see tests in repository for much more examples.


## Getting Started

First, you need to create a client that represents connections to 

```dart
  var client = ArangoDBClient(
    scheme: 'http',
    host: 'host.where.runned.arangodb.com',
    port: 8529, // <- use your real ArangoDB port
    db: 'blog', // <- the name of database for connect
    // User below must have access for you database:
    user: 'user1', // <- use real username for this database
    pass: 'user1password', // <- use real password for this user
  );

```

Data manipulation and query operations assume the database and the collection already exist. Both can be created from this API. Here's an example of how to create a collection in case it doesn't exist:

```dart
  if (!(await cli.allCollections()).response.any((e) => e.name == 'col1')) {
    await cli.createCollection(name: 'col1');
  }

```

CRUD operations are straightforward:

```dart

  // createDocument receives the name of the collection and a Map<String, dynamic>
  // representing the document
  final createResult = await client.createDocument('posts', // the collection
   // the content of the new document
   {
    'title': 'My new post',
    'public': false, // do not publish it, we want to edit it later
    'content': [
      // let 'content' field is array with a different keys
      {
        // let one of key is 'markdown' with text as it's value:
        'mardown': '__My markdown text__',
      },
    ],
  });
  print(createResult);



  // updateDocument receives the name of the collection, the key of the document
  // and a Map<String, dynamic> the properties to add or update.
  // This method does not remove properties from the original method.
  final updateResult = await client.updateDocument('posts', '62810', {'language': 'en'});
  print(updateResult);


  // replaceDocument receives the name of the collection, the key of the document
  // and a Map<String, dynamic> containing the document to replace the existing
  // one. Unlike updateDocument, this method will remove properties from
  // the previously persisted document if they are not present in the 
  // parameter.
  final replaceResult = await client.replaceDocument('posts', '62810', {
    'title': 'Empty post',
  });
  print(replaceResult);

  // removeDocument receives the name of the collection and the key of the document
  // to be removed.
  final removeResult = await client.removeDocument('posts', '62810');
  print(removeResult);

```


AQL queries can be built and run. Never concatenate input strings
into the query itself, but always use query parameters
that are defined by using addBindVarX methods.
This is very important to prevent AQL injection attacks:

```dart
  // Let collection 'posts' exists in database 'blog'.
  // Read all titles for public posts.
  var titles = await client
      .newQuery()
      // this part of query will be added anyway:
      .addLine('FOR post IN posts')
      // part of query will be added only if readOnlyPublic is true:
      .addLineIfThen(readOnlyPublic, 'FILTER post.public')
      // this line will be added if postKey!=null:
      // Look to @key in this line: this is placeholder for binded value
      // (it will appear later):
      .addLineIfThen(true, 'FILTER post._key=@key')
      .addLine('RETURN post.title')
      // binded variable named as 'key' (accessed in query as '@key')
      // will be inserted to query only if postKey!=null:
      .addBindVarIfThen(true, 'key', postKey)
      // Run query now.
      // Remember that we used 'await' keyword in above of this chain.
      .runAndReturnFutureList(); // <-- result type is Future<List>
  // See also .runAndReturnStream() method.

```

## Transactions

This driver supports streaming transactions. 

To following code examplifies how to work with collections:

```dart

      var answer = await testDbClient.beginTransaction(TransactionOptions(
        writeCollections: [ 'mycollection' ],
        waitForSync: true,
        allowImplicit: true,
      ));
      if (answer.result.error) {
        throw Error();
      }
      final transaction = answer.transaction;

      try {
        
        await testDbClient.createDocument(
          'mycollection',
          {'hello': 'world'},
          transaction: transaction,
        );

      } catch (ex) {
        await testDbClient.abortTransaction(transaction);
      } finally {
        await testDbClient.commitTransaction(transaction);
      }

```

A few notes:
- The lifecycle of the transaction is controlled with the typical 
  ```beginTransaction```, ```abortTransaction``` and ```commitTransaction``` methods.
- ```beginTransaction``` returns a ```Transaction``` object. That object is passed to every other method that interacts with the transaction. In the example, we are passing the transaction to ```createDocument```. Other methods, update, delete may also receive the transaction as a parameter and will use that transaction.
- The best documentation to understand transaction is ArangoDB's documentation at https://www.arangodb.com/docs/stable/http/transaction-stream-transaction.html.
  


## Attribution

This package is a fork of the [dart_arango_min](https://pub.dev/packages/dart_arango_min) package with the purpose of migrating it to null safety and add a lot of extra type-safety.

## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).