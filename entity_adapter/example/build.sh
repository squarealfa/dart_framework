#!/bin/bash

dart run build_runner build --verbose

rm -rf ./lib/grpc/
mkdir ./lib/grpc
protoc --dart_out=grpc:lib/grpc/ -Ilib/src ./lib/src/*.proto

