//
//  PCOneLineFetch.m
//  GreenApp
//
//  Created by Joshua Kaden on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PCOneLineFetch.h"

@implementation NSManagedObjectContext(PCOneLineFetch)

// Hats off to Matt Gallagher.
// http://cocoawithlove.com/2008/03/core-data-one-line-fetch.html

// Convenience method to fetch the array of objects for a given Object
// name in the context, optionally limiting by a predicate or by a predicate
// made from a format NSString and variable arguments.
//

/*
 [[self managedObjectContext] fetchObjectsForObjectName:@"Employee" withPredicate:
 @"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
 */

- (NSSet *)fetchObjectsForObjectName:(Class)source
					   withPredicate:(id)stringOrPredicate, ...
{
	NSString *newObjectName = NSStringFromClass((Class)source);
    
    NSEntityDescription *entity = [NSEntityDescription
								   entityForName:newObjectName inManagedObjectContext:self];
	
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
	
    if (stringOrPredicate)
    {
        NSPredicate *predicate;
        if ([stringOrPredicate isKindOfClass:[NSString class]])
        {
            va_list variadicArguments;
            va_start(variadicArguments, stringOrPredicate);
            predicate = [NSPredicate predicateWithFormat:stringOrPredicate
											   arguments:variadicArguments];
            va_end(variadicArguments);
        }
        else
        {
            NSAssert2([stringOrPredicate isKindOfClass:[NSPredicate class]],
					  @"Second parameter passed to %s is of unexpected class %@",
					  sel_getName(_cmd), NSStringFromClass(stringOrPredicate));
            predicate = (NSPredicate *)stringOrPredicate;
        }
        [request setPredicate:predicate];
    }
	
    NSError *error = nil;
    NSArray *results = [self executeFetchRequest:request error:&error];
    if (error != nil)
    {
        [NSException raise:NSGenericException format:@"%@",[error description]];
    }
	
    return [NSSet setWithArray:results];
}

@end
