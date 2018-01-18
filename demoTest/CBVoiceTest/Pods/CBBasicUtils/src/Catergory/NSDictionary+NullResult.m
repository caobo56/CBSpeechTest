//
//  NSDictionary+NSDictionary_NullResult.m
//  triprice
//
//  Created by MZY on 16/2/21.
//
//

#import "NSDictionary+NullResult.h"

@implementation NSDictionary (NullResult)


-(id)objectForKeyNotNull:(id)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    return nil;
}


@end
