part of simplechat_server;

/**
 * MongoDb database controller
 */
class MongoDatabase extends DatabaseBase
{
  MONGO.Db _mainDb;
  
  String _connectionString;
  
  LocalLogger _localLogger;
  
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
   *      [logger] Logger facility
   */
  MongoDatabase(String serverAddress, String databaseName, {LocalLogger logger:null, String userName:null, String password:null, int dbPort:null}) : super(serverAddress, userName, password, dbPort, databaseName)
  {
    _localLogger = logger;
    
    _connectionString = _createConnectionString(serverAddress, userName, password, dbPort, databaseName);
    
    if (_connectionString.isEmpty == false)
    {
      try
      {
        _mainDb = new MONGO.Db(_connectionString);
        
        if (_localLogger != null)
        {
          _localLogger.LogInfo("MongoDb connected success: $_connectionString");
        }
      }
      catch (exp)
      {
        if (_localLogger != null)
        {
          _localLogger.LogError("Exception occurred while trying to open connection to MongoDb\nConnection string is: $_connectionString \nError is: $exp");
        }
          
        throw exp;
      }
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

