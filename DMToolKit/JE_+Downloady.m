
#import "JE_+Downloady.h"

#pragma mark - Private Download Delegate Support Class

typedef void (^BeginBlock)(NSURLConnection*);
typedef void (^ResponseBlock)(NSURLConnection*, NSURLResponse*);
typedef void (^DataReceivedBlock)(NSURLConnection*, NSData*);
typedef void (^EndBlock)(NSURLConnection*);
typedef void (^ChallengeBlock)(NSURLConnection*, NSURLAuthenticationChallenge*);
typedef void (^FailBlock)(NSURLConnection*, NSError*);

@interface __DownloadySupport : NSObject <NSURLConnectionDelegate, 
                                          NSURLConnectionDataDelegate,
                                          NSURLAuthenticationChallengeSender>
{
    NSString* _url;
    BeginBlock _begin;
    ResponseBlock _response;
    DataReceivedBlock _received;
    EndBlock _end;
    ChallengeBlock _challenge;
    FailBlock _fail;
}

- (id)initWithUrl:(NSString*)url
          onBegin:(void (^)(NSURLConnection*))begin 
       onResponse:(void (^)(NSURLConnection*, NSURLResponse*))response
   onDataReceived:(void (^)(NSURLConnection*, NSData*))received
            onEnd:(void (^)(NSURLConnection*))end
      onChallenge:(void (^)(NSURLConnection*, NSURLAuthenticationChallenge*))challenge
           onFail:(void (^)(NSURLConnection*, NSError*))fail;

@end

@implementation __DownloadySupport

- (id)initWithUrl:(NSString*)url
          onBegin:(void (^)(NSURLConnection*))begin 
       onResponse:(void (^)(NSURLConnection*, NSURLResponse*))response
   onDataReceived:(void (^)(NSURLConnection*, NSData*))received
            onEnd:(void (^)(NSURLConnection*))end
      onChallenge:(void (^)(NSURLConnection*, NSURLAuthenticationChallenge*))challenge
           onFail:(void (^)(NSURLConnection*, NSError*))fail
{
    self = [super init];
    if (self) {
        _url = url;
        _begin = begin;
        _response = response;
        _received = received;
        _end = end;
        _challenge = challenge;
        _fail = fail;
    }
    return self;
}

- (NSURLConnection*)generateConnectionWithURLString:(NSString *)urlString
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    return [[NSURLConnection alloc] initWithRequest:request 
                                           delegate:self];
}

#pragma mark - Begin
- (void)beginDownload
{
    NSURLConnection* connection = [self generateConnectionWithURLString:_url];
    if(connection){
        _begin(connection);
    }
}

- (void)beginDownloadWithRequest:(NSURLRequest*)request
{
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    if (connection) {
        _begin(connection);
    }
}

#pragma mark - Response
- (void)connection:(NSURLConnection *)connection 
didReceiveResponse:(NSURLResponse *)response
{
    _response(connection, response);
}

#pragma mark - Received Data
- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)data
{
    _received(connection, data);
}

#pragma mark - Finished
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _end(connection);
}

#pragma mark - Failed
- (void)connection:(NSURLConnection *)connection 
  didFailWithError:(NSError *)error
{
    _fail(connection, error);
}

//#pragma mark - Authentication Challenge
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    _challenge(connection, challenge);
//}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"yes");
    _challenge(connection, challenge);
//    NSURLCredential* credentials = [[NSURLCredential alloc] initWithUser:@"jesse"
//                                                                password:@"earle"
//                                                             persistence:NSURLCredentialPersistenceForSession];
//    [[challenge sender] useCredential:credentials forAuthenticationChallenge:challenge];
}
@end

#pragma mark - Download Support 2 Class

typedef void (^BeginBlock2)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge);
typedef void (^ProgressBlock)(NSURLConnection* connection, NSData* currentData, float percentDone);
typedef void (^EndBlock2)(NSURLConnection* connection, NSData* finalData, NSError* error);

@interface __DownloadySupport2 : NSObject <NSURLConnectionDelegate,
NSURLConnectionDataDelegate,
NSURLAuthenticationChallengeSender>
{
    NSString* _url;
    BeginBlock2 _begin;
    ProgressBlock _progress;
    EndBlock2 _end;
    float _percentDone;
    NSMutableData* _downloadedData;
}
@end


@implementation __DownloadySupport2

- (id)initWithURL:(NSString*)url onBegin:(BeginBlock2)begin onProgress:(ProgressBlock)progress onEnd:(EndBlock2)end
{
    self = [super init];
    if (self) {
        _begin = begin;
        _progress = progress;
        _end = end;
        _percentDone = 0.0f;
        _url = url;
    }
    return self;
}

#pragma mark - Private Methods
- (NSURLConnection*)generateConnectionWithURLString:(NSString *)urlString
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    return [[NSURLConnection alloc] initWithRequest:request
                                           delegate:self];
}

#pragma mark - Public Methods
- (void)beginDownload
{
    NSURLConnection* connection = [self generateConnectionWithURLString:_url];
    if(!connection){
        _end(connection, _downloadedData, [NSError errorWithDomain:@"Failed to create NSURLConnection in beginDownload." code:0 userInfo:nil]);
    }
}

#pragma mark - Connection Delegate Methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _end(connection, _downloadedData, error);
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential* credentials = [[NSURLCredential alloc] initWithUser:nil
                                                                password:nil
                                                             persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credentials
           forAuthenticationChallenge:challenge];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _end(connection, _downloadedData, nil);
}

#pragma mark - Connection Data Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (_downloadedData == nil) {
        _downloadedData = [[NSMutableData alloc] init];
    }
    [_downloadedData appendData:data];
    _progress(connection, _downloadedData, _percentDone);
}


@end

#pragma mark - Public Method

@implementation JE_ (Downloady)

+ (NSString*)makeUrlSafe:(NSString*)url
{

    return [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}

+ (void)getDataFromURL:(NSString*)url
               onBegin:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))begin
            onProgress:(void (^)(NSURLConnection* connection, NSData* currentData, float percentDone))progress
                 onEnd:(void (^)(NSURLConnection* connection, NSData* finalData, NSError* error))end
{
    __DownloadySupport2* downloadSupport = [[__DownloadySupport2 alloc] initWithURL:url
                                                                            onBegin:begin
                                                                         onProgress:progress
                                                                              onEnd:end];
    [downloadSupport beginDownload];
}

+ (void)downloadFileWithUrl:(NSString*)url
                    onBegin:(void (^)(NSURLConnection*))begin 
                 onResponse:(void (^)(NSURLConnection*, NSURLResponse*))response
             onDataReceived:(void (^)(NSURLConnection*, NSData*))received
                      onEnd:(void (^)(NSURLConnection*))end
                onChallenge:(void (^)(NSURLConnection*, NSURLAuthenticationChallenge*))challenge
                     onFail:(void (^)(NSURLConnection*, NSError*))fail
{
    __DownloadySupport* downloadSupport = [[__DownloadySupport alloc] initWithUrl:url 
                                                                          onBegin:begin 
                                                                       onResponse:response 
                                                                   onDataReceived:received 
                                                                            onEnd:end 
                                                                      onChallenge:challenge 
                                                                           onFail:fail];
    [downloadSupport beginDownload];
}

+ (void)postJSONString:(NSString*)json
                   url:(NSString*)urlString
               onBegin:(void (^)(NSURLConnection* connection))begin
            onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
        onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
           onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
                 onEnd:(void (^)(NSURLConnection* connection))end
                onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSData* requestBody = [NSData dataWithBytes:[json UTF8String]
                                  length:[json length]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"application/x-www-form-urlencode"
   forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [requestBody length]]
   forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:requestBody];
    
    __DownloadySupport* downloadSupport = [[__DownloadySupport alloc] initWithUrl:urlString
                                                                          onBegin:begin
                                                                       onResponse:response
                                                                   onDataReceived:received
                                                                            onEnd:end
                                                                      onChallenge:challenge
                                                                           onFail:fail];
    [downloadSupport beginDownloadWithRequest:request];
}

+ (void)postJSON:(NSDictionary*)json
                   url:(NSString*)urlString
               onBegin:(void (^)(NSURLConnection* connection))begin
            onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
        onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
           onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
                 onEnd:(void (^)(NSURLConnection* connection))end
                onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail
{
    NSString* bodyString = [JE_ dictionaryToQueryString:json];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [bodyString length]]
   forHTTPHeaderField:@"Content-Length"];
    
   
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    __DownloadySupport* downloadSupport = [[__DownloadySupport alloc] initWithUrl:urlString
                                                                          onBegin:begin
                                                                       onResponse:response
                                                                   onDataReceived:received
                                                                            onEnd:end
                                                                      onChallenge:challenge
                                                                           onFail:fail];
    [downloadSupport beginDownloadWithRequest:request];
}

//var xmlhttp = new XMLHttpRequest()
//xmlhttp.open("POST","/orders/submit",true);
//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded; charset=UTF-8");
//xmlhttp.send("fname=Henry&lname=Ford");
+ (void)postDictionary:(NSDictionary*)dict
                   url:(NSString*)urlString
               onBegin:(void (^)(NSURLConnection* connection))begin
            onResponse:(void (^)(NSURLConnection* connection, NSURLResponse* response))response
        onDataReceived:(void (^)(NSURLConnection* connection, NSData* data))received
           onChallenge:(void (^)(NSURLConnection* connection, NSURLAuthenticationChallenge* challenge))challenge
                 onEnd:(void (^)(NSURLConnection* connection))end
                onFail:(void (^)(NSURLConnection* connection, NSError* fail))fail
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlString, [JE_ dictionaryToQueryString:dict]]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencode; charset=UTF-8"
   forHTTPHeaderField:@"Content-Type"];
    
    __DownloadySupport* downloadSupport = [[__DownloadySupport alloc] initWithUrl:urlString
                                                                          onBegin:begin
                                                                       onResponse:response
                                                                   onDataReceived:received
                                                                            onEnd:end
                                                                      onChallenge:challenge
                                                                           onFail:fail];
    [downloadSupport beginDownloadWithRequest:request];
}

+ (void)requestURL:(NSString*)urlString
          complete:(void (^)(NSURLResponse* response, NSData* data, NSError* error))complete
{
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:nil
                           completionHandler:complete];
}
@end
