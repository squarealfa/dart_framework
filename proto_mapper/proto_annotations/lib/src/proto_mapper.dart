abstract class ProtoMapper<TEntity, TProto> {
  TEntity fromProto(TProto proto);
  TProto toProto(TEntity entity);
}
