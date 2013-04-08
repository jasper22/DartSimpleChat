
import '../libs/Server.dart';

void main() 
{
  WebServerBase serverBase = new WebSocketServer();
  
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
    print("Message received from user: " + messageReceived.Text);
    
  });
  
  print("Main() end");
}
