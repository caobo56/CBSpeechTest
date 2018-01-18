//
//  NSDictionary+NSDictionary_NullResult.h
//  triprice
//
//  Created by MZY on 16/2/21.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullResult)


/**
 *  objectForKeyNotNull
 *
 *  @param key key
 *
 *  @return return valueNotNull
 */
-(id)objectForKeyNotNull:(id)key;

@end
