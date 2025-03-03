from concurrent import futures
import time
import grpc

import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), 'python_pb'))
from python_pb import greet_pb2_grpc, greet_pb2


class GreeterServicer(greet_pb2_grpc.GreeterServicer):
    # サービスへのHelloリクエストを受け取り、その内容を表示
    def SayHello(self, request, context):
        print("SayHello Request Made:")
        print(request)
        # レスポンスメッセージを作成
        hello_reply = greet_pb2.HelloReply()
        hello_reply.message = f"{request.greeting} {request.name}"

        return hello_reply

    def ParrotSaysHello(self, request, context):
        # ParrotSaysHelloリクエストを受け取り、その内容を表示
        print("ParrotSaysHello Request Made:")
        print(request)
        # 3回のループを通じて、連続したレスポンスメッセージを生成
        for i in range(3):
            hello_reply = greet_pb2.HelloReply()
            hello_reply.message = f"{request.greeting} {request.name} {i + 1}"
            yield hello_reply
            time.sleep(3)

    def ChattyClientSaysHello(self, request_iterator, context):
        # ChattyClientSaysHelloリクエストを受け取り、その内容を表示
        delayed_reply = greet_pb2.DelayedReply()
        for request in request_iterator:
            print("ChattyClientSaysHello Request Made:")
            print(request)
            # リクエストをDelayedReplyのリストに追加
            delayed_reply.request.append(request)

        delayed_reply.message = f"You have sent {len(delayed_reply.request)} messages. Please expect a delayed response."
        return delayed_reply

    def InteractingHello(self, request_iterator, context):
        # InteractingHelloリクエストを受け取り、その内容を表示
        for request in request_iterator:
            print("InteractingHello Request Made:")
            print(request)
            # レスポンスメッセージを生成してイテレーターで返す
            hello_reply = greet_pb2.HelloReply()
            hello_reply.message = f"{request.greeting} {request.name}"

            yield hello_reply

def serve():
    # gRPCサーバーの設定
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    greet_pb2_grpc.add_GreeterServicer_to_server(GreeterServicer(), server)
    server.add_insecure_port("localhost:50051")
    # サーバーの起動
    server.start()
    server.wait_for_termination()

if __name__ == "__main__":
    # サーバーを起動
    serve()