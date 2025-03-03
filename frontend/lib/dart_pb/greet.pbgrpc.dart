//
//  Generated code. Do not modify.
//  source: greet.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'greet.pb.dart' as $0;

export 'greet.pb.dart';

@$pb.GrpcServiceName('greet.Greeter')
class GreeterClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/greet.Greeter/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$parrotSaysHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/greet.Greeter/ParrotSaysHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$chattyClientSaysHello = $grpc.ClientMethod<$0.HelloRequest, $0.DelayedReply>(
      '/greet.Greeter/ChattyClientSaysHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DelayedReply.fromBuffer(value));
  static final _$interactingHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/greet.Greeter/InteractingHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));

  GreeterClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseStream<$0.HelloReply> parrotSaysHello($0.HelloRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$parrotSaysHello, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.DelayedReply> chattyClientSaysHello($async.Stream<$0.HelloRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$chattyClientSaysHello, request, options: options).single;
  }

  $grpc.ResponseStream<$0.HelloReply> interactingHello($async.Stream<$0.HelloRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$interactingHello, request, options: options);
  }
}

@$pb.GrpcServiceName('greet.Greeter')
abstract class GreeterServiceBase extends $grpc.Service {
  $core.String get $name => 'greet.Greeter';

  GreeterServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'ParrotSaysHello',
        parrotSaysHello_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.DelayedReply>(
        'ChattyClientSaysHello',
        chattyClientSaysHello,
        true,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.DelayedReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'InteractingHello',
        interactingHello,
        true,
        true,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Stream<$0.HelloReply> parrotSaysHello_Pre($grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async* {
    yield* parrotSaysHello(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello($grpc.ServiceCall call, $0.HelloRequest request);
  $async.Stream<$0.HelloReply> parrotSaysHello($grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.DelayedReply> chattyClientSaysHello($grpc.ServiceCall call, $async.Stream<$0.HelloRequest> request);
  $async.Stream<$0.HelloReply> interactingHello($grpc.ServiceCall call, $async.Stream<$0.HelloRequest> request);
}
