// Import dart_arango_min package:
import 'dart:io';

import 'package:arango_driver/arango_driver.dart';

void main() async {
// First, create client for database:
  var client = ArangoDBClient(
    scheme: 'http',
    host: 'localhost',
    port: 8529, // <- use your real ArangoDB port
    db: 'blog', // <- the name of database for connect
    // User below must have access for you database:
    user: 'root', // <- use real username for this database
    pass: 'Numer678_', // <- use real password for this user
  );

  // Lets, we have some condition which blog documents to read:
  var readOnlyPublic = true;
  var postKey = '1234567';

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

  for (var title in titles) {
    print(title);
  }

  // Let's create a new post:
  var createResult = await client.createDocument('posts', {
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

  // See ArangoDB answer documentation for answer structure:
  // https://www.arangodb.com/docs/3.5/http/document-working-with-documents.html#create-document
  if (createResult.result.error) {
    print('Somewhat wrong: $createResult');
    exit(2);
  }

  var newPostKey = createResult.identifier.key;

  // Let's update post:
  // ignore: unused_local_variable
  var updatedPost = await client.updateDocument(
      'posts', newPostKey, {'public': true},
      // use 'returnNew' query paramener if you want to have
      // a copy of new post:
      // (see ArangoDB documentation for known more about query parameters)
      // https://www.arangodb.com/docs/3.5/http/document-working-with-documents.html#update-document
      queryParams: {'returnNew': 'true'});

  // delete post:
  await client.removeDocument('posts', newPostKey);

  // Another, less convenient way to create query.
  // Here is an example of hardcoded query.
  // Any variants should be composed by hand.
  // ignore: unused_local_variable
  var titlesAnotherWay = await client.queryToList({
    // See alse client.queryToStream().
    'query': '''
    FOR post IN posts
    FILTER post.public
    FILTER post._key=@key
    RETURN post.title
    ''',
    'bindVars': {
      'key': postKey,
    }
  });
}
