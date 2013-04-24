

#import "JE_.h"

@interface JE_ (Array)
+ (NSArray*)filterArray:(NSArray*)array
      usingSearchString:(NSString*)searchString
             onProperty:(NSString*)propertyName;

+ (NSArray*)filterArray:(NSArray*)array
     usingSearchStrings:(NSArray*)searchStrings
           onProperties:(NSArray*)propertyNames;
@end
