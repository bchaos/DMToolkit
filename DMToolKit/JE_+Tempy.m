
//

#import "JE_+Tempy.h"

@implementation JE_ (Tempy)

+ (NSString*)tempFileTemplateWithName:(NSString*)tempFileName
{
    return [tempFileName stringByAppendingString:@".XXXXXX"];
}

+ (char*)stringToCString:(NSString*)string
{
    const char* constCString = [string fileSystemRepresentation];
    char* cString = (char*)malloc(strlen(constCString) + 1);
    strcpy(cString, constCString);
    return cString;
}

+ (NSString*)cStringToString:(char*)cString
{
    return [[JE_ manager] stringWithFileSystemRepresentation:cString length:strlen(cString)];
}

+ (NSArray*)createTempFile
{
    NSString* temporaryPath = [JE_ temp];
    NSString* tempFileName = @"temp";
    NSString* tempFileTemplate = [JE_ tempFileTemplateWithName:tempFileName];
    
    char* cTempFileAbsolutepath = [JE_ stringToCString:[temporaryPath stringByAppendingString:tempFileTemplate]];
    
    int fileDescriptor = mkstemp(cTempFileAbsolutepath);
    
    if (fileDescriptor == MAKE_TEMP_FILE_FAILED) {
        NSLog(@"Creation of temp file failed");
    }
    
    NSString* tempFileAbsolutePath = [self cStringToString:cTempFileAbsolutepath];
    NSFileHandle* tempFileHandle = [[NSFileHandle alloc] initWithFileDescriptor:fileDescriptor];
    
    NSArray* arr = [[NSArray alloc] initWithObjects:tempFileAbsolutePath, tempFileHandle, nil];
    return arr;
}
@end
