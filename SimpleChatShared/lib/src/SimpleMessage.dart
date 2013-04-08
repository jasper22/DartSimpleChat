
part of simplechat_shared;

///
/// Object represent a single 'message'
class SimpleMessage
{
  String _text;
  
  ///
  /// ctor
  SimpleMessage({String text:null})
  {
    this._text = text;
  }
  
  ///
  /// Constructor that serialize [jsonRawMap] map to object
  SimpleMessage.fromJson(Map<String,Object> jsonRawMap)
  {
    if (jsonRawMap.containsKey("text"))
    {
      this._text = jsonRawMap["text"];
    }
    else
    {
      this._text = null;
    }
  }  
  
  ///
  /// Get the text from message
  String get Text
  {
    return _text;
  }
  
  ///
  /// Serialize class to JSON representation
  String toJson()
  {
    Map<String, Object> data = new Map<String, Object>();
    data["text"] = this._text;
    
    return JSON.stringify(data);
  }
}


