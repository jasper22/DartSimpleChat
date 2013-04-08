
part of simplechat_shared;

/**
 *  Object represent a single 'message'
 */
class SimpleMessage
{
  String _text;
  String _to;
  String _from;
  
  /**
   * Default ctor
   *     [from] is current user
   *     [to] the 'taget' user (optional - default is to 'server')
   *     [text] message to send (optional)
   */
  SimpleMessage(String from, {String to:null, String text:null})
  {
    this._to = to;
    this._from = from;
    this._text = text;
  }
  
  /**
   *  Constructor that serialize [jsonRawMap] map to object
   */
  SimpleMessage.fromJson(Map<String,Object> jsonRawMap)
  {
    if (jsonRawMap != null)
    {
      this._from = jsonRawMap["from"];
      this._to = jsonRawMap["to"];
      this._text = jsonRawMap["text"];      
    }
  }  
  
  /**
   *  Get the user ID of the sender
   */
  String get From
  {
    return this._from;
  }
  
  /**
   *  Get the user ID of 'target' user
   */
  String get To
  {
    return this._to;
  }
  
  /**
   *  Get the text from message
   */
  String get Text
  {
    return _text;
  }
  
  /**
   *  Serialize class to JSON representation
   */
  String toJson()
  {
    Map<String, Object> data = new Map<String, Object>();
    
    data["from"] = this._from;
    data["to"] = this._to;
    data["text"] = this._text;
    
    return JSON.stringify(data);
  }
}