import 'dart:isolate';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class ServicesHost<TDbClient> {
  final HostParameters parameters;
  final AppSettings appSettings;
  ServicesHost(this.parameters) : appSettings = parameters.appSettings;

  ServiceCollection getServiceCollection(
    CreateRepositoryFunction createRepository,
    UserRepository userRepository,
    JsonWebTokenHandler tokenHandler,
  );

  Map<Type, String> get collectionMap;
  TDbClient createDbConnection(String connectionString);
  UserRepository createUserRepository(TDbClient db);
  Repository<TEntity> createRepository<TEntity>(
      TDbClient db, String collectionName);

  void onDbConnected(TDbClient client) {}

  Future run() async {
    final db = createDbConnection(appSettings.dbConnectionString);
    final userRepository = createUserRepository(db);

    onDbConnected(db);

    final tokenHandler = JsonWebTokenHandler(appSettings.jwtKey);

    final repositoryCreator = <TEntity>() {
      final collectionName = collectionMap[TEntity] ?? TEntity.toString();
      final repository = createRepository<TEntity>(db, collectionName);
      return repository;
    };

    final serviceCollection =
        getServiceCollection(repositoryCreator, userRepository, tokenHandler);

    final services = serviceCollection.services;

    var server = Server([
      ...services,
    ], [
      (call, method) async {
        await call.authenticate(tokenHandler, userRepository);
      }
    ]);

    await server.serve(
      port: appSettings.port,
      shared: true,
    );

    print(
        'Isolate ${Isolate.current.hashCode} serving at port ${appSettings.port}. Will try to open connection to database.');
  }
}
