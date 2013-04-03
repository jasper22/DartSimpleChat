
part of simplechat_server;


class WebSocketServer extends WebServerBase
{
  HttpServer _mainServerInstance;
  
  ///
  /// ctor
  WebSocketServer({String address:"127.0.0.1", int port:8080}) : super(address, port)
  {
     Future<HttpServer> tmpServer = HttpServer.bind(address, port)
        .then( (HttpServer createdServer) {
          _mainServerInstance = createdServer;
          
        },
        onError: (AsyncError e){});
  }
}