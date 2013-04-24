

#import "JE_+Filey.h"

@implementation JE_ (Filey)

#pragma mark - User Folders
+ userFolder:(NSSearchPathDirectory)directory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(directory,
                                                         NSUserDomainMask,
                                                         YES);
    return [paths objectAtIndex:0];
}

+ (NSString*)docs
{
    return [JE_ userFolder:NSDocumentDirectory];
}
+ (NSString*)temp
{
    return NSTemporaryDirectory();
}
+ (NSString*)lib
{
    return [JE_ userFolder:NSLibraryDirectory];
}

+ (NSString*)bundleFile:(NSString*)path
{
    return [[NSBundle mainBundle] pathForResource:[path stringByDeletingPathExtension]
                                           ofType:[path pathExtension]];
}

#pragma mark - File System
+ (NSFileManager*)manager
{
    return [NSFileManager defaultManager];
}

+ (NSArray*)allBundleFileNames
{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = [[NSError alloc] init];
    
    NSArray *directoryAndFileNames = [fm contentsOfDirectoryAtPath:path error:&error];
    return directoryAndFileNames;
}

+ (NSArray*)bundleFileNamesContainingString:(NSString*)s
{
    NSArray* allFileNames = [JE_ allBundleFileNames];
    
    NSString* predicateString = [NSString stringWithFormat:@"SELF contains[c] '%@'", s];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateString];
    
    return [allFileNames filteredArrayUsingPredicate:predicate];
}

+ (BOOL)copyFile:(NSString *)path
              to:(NSString *)newPath
{
    NSError* error = nil;
    [[JE_ manager] copyItemAtPath:path
                           toPath:newPath
                            error:&error];
    if (error){
        NSLog(@"File Copy Failed: %@",
              [error localizedDescription]);
        return NO;
    }
    return YES;
}

+ (BOOL)fileExists:(NSString*)path
{
    return [[JE_ manager] fileExistsAtPath:path];
}

+ (BOOL)isDirectory:(NSString*)path
{
    BOOL isDirectory = NO;
    [[JE_ manager] fileExistsAtPath:path
                        isDirectory:&isDirectory];
    return isDirectory;
}

+ (BOOL)createFolder:(NSString *)path
{
    BOOL isDirectory = NO;
    NSError *error;
    if (![[JE_ manager] fileExistsAtPath:path
                             isDirectory:&isDirectory]) {
        if (!isDirectory) {
            NSLog(@"The path provided points to a file not folder");
            return NO;
        }
        
        [[JE_ manager] createDirectoryAtPath:path
                 withIntermediateDirectories:YES
                                  attributes:nil
                                       error:&error];
        
        if (error) {
            NSLog(@"Create directory failed with error: %@", [error localizedDescription]);
            return NO;
        }
        NSLog(@"File exists already");
        return NO;
    }
    return YES;
}

@end
