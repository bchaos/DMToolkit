//
//  ObjectBase.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "ObjectBase.h"

@implementation ObjectBase
-(NSString * )getDocsDirectory{
    return  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}


-(NSString *)myFilePath{
    if(self.filePath==nil){
        self.filePath = [[self getDocsDirectory]stringByAppendingString:self.fileToLoad];
    }
    return self.filePath;
}
-(void)load{
    if(self.loadedData ==nil && [[NSFileManager defaultManager]fileExistsAtPath: [self myFilePath]]){
       self.loadedData = [NSDictionary dictionaryWithContentsOfFile:[self myFilePath]];
    }
}

-(void)unload{
    [self save];
    self.loadedData=nil;
}

-(void)save{
    if(self.loadedData !=nil){
        [self.loadedData writeToFile:[self myFilePath] atomically:YES];
    }
}
@end
