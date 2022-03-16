mkdir -p lib/generated_grpc

protoc --dart_out=grpc:lib/generated_grpc --proto_path ../party_protocals/protocols helloworld.proto

protoc --dart_out=grpc:lib/generated_grpc --proto_path ../party_protocals/protocols account_service.proto
