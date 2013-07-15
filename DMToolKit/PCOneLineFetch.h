//
//  PCOneLineFetch.h
//  GreenApp
//
//  Created by Joshua Kaden on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface NSManagedObjectContext(PCOneLineFetch)

- (NSSet *)fetchObjectsForObjectName:(Class)source
					   withPredicate:(id)stringOrPredicate, ...;
@end
