#!/bin/bash
dart run build_runner build

# recreate proto_generated
rm -rf ./proto
mkdir ./proto
 


# move generated proto files to proto_generated
mv ./lib/src/*.proto ./proto/

# recreate grpc directory
rm -rf ./lib/grpc
mkdir ./lib/grpc


# generate dart grpc business model files
protoc --dart_out=grpc:lib/grpc/ -Iproto/ ./proto/*.proto
