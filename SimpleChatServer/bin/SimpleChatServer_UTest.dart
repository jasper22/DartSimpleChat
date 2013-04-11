
import 'dart:async';
import '../../SimpleChatClient/packages/unittest/unittest.dart';
import '../libs/Server.dart';

void main()
{

  group('database group',(){
    setUp( () {
      // Setup
    });

    tearDown((){
      // TearDown
    });

    test('open connection to local database', (){
      DatabaseBase database = null;

      expect(database = new MongoDatabase("127.0.0.8", "simplechat-db"), isNotNull);

//      database.AddMessage(null).then(
//            (e)
//            {
//                expectAsync1(e) {
//                // All ok
//                }
//            }
//          ,
//          onError: (err)
//                    {
//                      expectAsync1(bb)
//                      {
//                        fail('error !');
//                      }
//                    }
//          );

      database.AddMessage(null).then(
          expectAsync1((value) { /* Check the value in here if you want. */ }),
          onError: (err) {
            // It's enough to just fail!
            fail('error !');
          }
      );

    });


  });
}


