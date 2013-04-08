part of simplechat_server;

/**
 * MongoDb database controller
 */
class MongoDatabase extends DatabaseBase
{
  MONGO.Db _mainDb;
  
  String _connectionString;
  
  /**
   *  Default ctor
   *   
   *  Will try to open connection. If it fails the exception will be thrown
   *  
   *      [serverAddress] Server IP or Host to connect to
   *      [databaseName] Database name
   *      
   *  Other arguments are optional:
   *      [userName] User name to connect with
   *      [password] Password to use
   *      [dbPort] Database port to connect
   */
  MongoDatabase(String serverAddress, String databaseName, [String userName = null, String password = null, int dbPort = null]) : super(serverAddress, userName, password, dbPort, databaseName)
  {
    _connectionString = _createConnectionString(serverAddress, userName, password, dbPort, databaseName);
    
    if (_connectionString.isEmpty == false)
    {
      _mainDb = new MONGO.Db(_connectionString);
    }
    else
    {
      throw new Exception("Database could not opened. Wrong parameters supplied");
    }
  }
  
  /**
   * Generate [valid mongodb URI] (http://www.mongodb.org/display/DOCS/Connections) for MongoDB connection
   */
  String _createConnectionString(String serverAddress, String userName, String password, int dbPort, String databaseName)
  {
    if ((serverAddress == null) || (serverAddress.isEmpty == true))
    {
      return null;
    }
    
    if ((databaseName == null) || (databaseName.isEmpty == true))
    {
      return null;
    }
    
    String _tmpConnectionString = "mongodb://";   // 'mongodb://dart:test@ds037637-a.mongolab.com:37637/objectory_blog'
    
    if ((userName != null) && (userName.isEmpty == false))
    {
      _tmpConnectionString += userName + ":" + password + "@";
    }
    
    _tmpConnectionString += serverAddress + "/" + databaseName;
    
    return _tmpConnectionString;
  }
}

