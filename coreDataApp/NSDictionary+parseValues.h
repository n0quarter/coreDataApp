//
//  NSDictionary+parseValues.h
//  MegaGeoGame
//
//  Created by Viktor Shcherban on 07/06/14.
//  Copyright (c) 2014 asdCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (parseValues)

- (NSString*)stringForKey:(NSString*)key;
- (NSNumber*)numberForKey:(NSString*)key;


@end
