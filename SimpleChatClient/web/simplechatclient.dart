import 'dart:html';

import 'dart:json' as JSON;

// import 'package:web_ui/web_ui.dart';
import 'package:DartSimpleChat_Shared/SimpleChatShared.dart';
import 'package:uuid/uuid.dart';

// initial value for click-counter
int startingCount = 5;

//
// Actual websocket 
WebSocket ws = null;

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
  
  ws = new WebSocket('ws://127.0.0.1:8080/ws');
   
//  ButtonElement btnSend = query('#btnSendToServer') as ButtonElement;
//  btnSend.text = "Click to send to server";
  
  DivElement btnSend = query('#btnSendToServer') as DivElement;
  
  btnSend.onClick.listen(
      (data)
      {
        SendTestData();
      },
      onError: (ex)
                { print("Error occurred $ex"); }, 
      onDone: ()
              {
                print("Done");
              }
      );
}


void SendTestData()
{
  print("Gonna send test data");
  
  if (ws.readyState == WebSocket.OPEN)
  {
    var generator = new Uuid();
    String localFrom = generator.v1().toString();
    String localTo = generator.v1().toString();
    
    SimpleMessage msg = new SimpleMessage(localFrom, to:localTo, text:"Hello from client");
    ws.send(JSON.stringify(msg));
  }
  else
  {
    print("Could not send because WebSocket is not 'Open'");
  }
}