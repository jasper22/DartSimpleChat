import "dart:html";
import "dart:json" as JSON;
import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;

/**
 * Class will handle login/disconnect from Google+
 */
class GoolgePlusLogin extends WebComponent
{
  GoolgePlusLogin()
  {
    // Load the JS library that renders and handles the Sign-in button
//    ScriptElement script = new ScriptElement();
//    script.async = true;
//    script.type = "text/javascript";
//    script.src = "https://plus.google.com/js/client:plusone.js";
//    document.body.children.add(script);

    /**
     * Calls the method that handles the authentication flow.
    *
     * @param {Object} authResult An Object which contains the access token and
     *   other authentication information.
     */
    js.scoped(() {
      js.context.onSignInCallback =  new js.Callback.many((js.Proxy authResult) {
        Map dartAuthResult = JSON.parse(
            js.context.JSON.stringify(
                authResult,
                new js.Callback.many((key, value) {
                  if (key == "g-oauth-window") {
                    // g-oauth-window is an object returned in the authResult
                    // remove it to prevent errors in JSON.stringify
                    return "";
                  }
                  return value;
                })
            )
        );
        onSignInCallback(dartAuthResult);
      });
    });

  }

  void onSignInCallback(Map authResult)
  {
    query("#authResult").innerHtml = "Auth Result:<br>";
    authResult.forEach((key, value) {
      query("#authResult").appendHtml(" $key: $value<br>");
    });

    if (authResult["access_token"] != null) {
//      query("#authOps").style.display = "block";
//      query("#gConnect").style.display = "none";

//      // Enable Authenticated requested with the granted token in the client libary
//      auth.token = authResult["access_token"];
//      auth.tokenType = authResult["token_type"];
//      plusclient.makeAuthRequests = true;

//      showProfile();
//      showPeople();
    } else if (authResult["error"] != null) {
//      // There was an error, which means the user is not signed in.
//      // As an example, you can handle by writing to the console:
      print("There was an error: ${authResult["error"]}");
//      query("#authResult").appendHtml("Logged out");
//      query("#authOps").style.display = "none";
//      query("#gConnect").style.display = "block";
    }
    print("authResult $authResult");
  }
}