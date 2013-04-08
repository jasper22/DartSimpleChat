
import '../libs/Server.dart';

void main() 
{
  DateTime _localDate = new DateTime.now();
  String _logFileName = "SimpleChatServer" + 
                        "-" + _localDate.day.toString() + 
                        "-" + _localDate.month.toString() + 
                        "-" + _localDate.year.toString() + 
                        "_" + _localDate.hour.toString() + 
                        "-" + _localDate.minute.toString() +
                        "-" + _localDate.second.toString() +
                        ".log";
  
  LocalLogger _localLogger = new LocalLogger(_logFileName, true);
  
  WebServerBase serverBase = new WebSocketServer(logger:_localLogger);
  DatabaseBase databaseBase = new MongoDatabase("127.0.0.1", "simplechat-db", logger:_localLogger);
  
  //
  // Events
  serverBase.onNotification.listen(
      (message) { print("Server message: $message"); 
      });

  
  serverBase.onError.listen(
      (errorData) {
        print("Error occurred in web server. Error is: $errorData");
      });
  
 
  serverBase.MessagesStream.stream.listen((messageReceived) {
    
    print("Message received from user [" + messageReceived.From + "] : " + messageReceived.Text);
    
    serverBase.logger.debug("Message received from user [" + messageReceived.From + "] : " + messageReceived.Text);
    
  });
  
  print("Main() end");
}
