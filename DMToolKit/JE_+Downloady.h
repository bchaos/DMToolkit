

#import "JE_.h"

@interface JE_ (Downloady)
+ (NSString*)makeUrlSafe:(NSString*)url;

+ (void)getDataFromURL:(NSString*)url
               onBegin:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))begin
            onProgress:(void (^)(NSURLConnection* connection, NSData* currentData, float percentDone))progress
                 onEnd:(void (^)(NSURLConnection* connection, NSData* finalData, NSError* error))end;

+ (void)downloadFileWithUrl:(NSString*)url
                    onBegin:(void (^)(NSURLConnection*))begin 
                 onResponse:(void (^)(NSURLConnection*, NSURLResponse*))response
             onDataReceived:(void (^)(NSURLConnection*, NSData*))received
                      onEnd:(void (^)(NSURLConnection*))end
                onChallenge:(void (^)(NSURLConnection*, NSURLAuthenticationChallenge*))challenge
                     onFail:(void (^)(NSURLConnection*, NSError*))fail;

+ (void)postJSON:(NSDictionary*)json
             url:(NSString*)urlString
         onBegin:(void (^)(NSURLConnection* connection))begin
      onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
  onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
     onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
           onEnd:(void (^)(NSURLConnection* connection))end
          onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail;

+ (void)postJSONString:(NSString*)json
                   url:(NSString*)urlString
               onBegin:(void (^)(NSURLConnection* connection))begin
            onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
        onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
           onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
                 onEnd:(void (^)(NSURLConnection* connection))end
                onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail;

+ (void)postDictionary:(NSDictionary*)dict
                   url:(NSString*)urlString
               onBegin:(void (^)(NSURLConnection* connection))begin
            onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
        onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
           onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
                 onEnd:(void (^)(NSURLConnection* connection))end
                onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail;

+ (void)requestURL:(NSString*)urlString
          complete:(void (^)(NSURLResponse* response, NSData* data, NSError* error))complete;
@end
