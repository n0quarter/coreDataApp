//
//  NSDictionary+parseValues.m
//  MegaGeoGame
//
//  Created by Viktor Shcherban on 07/06/14.
//  Copyright (c) 2014 asdCode. All rights reserved.
//

#import "NSDictionary+parseValues.h"

@implementation NSDictionary (parseValues)

- (NSString*)stringForKey:(NSString*)key
{
	id value = [self valueForKey:key];
  
  BOOL isValueOfExpectedType  = [value isKindOfClass:[NSString class]];
  BOOL isValueANumber         = [value isKindOfClass:[NSNumber class]];
  
  if( isValueOfExpectedType) {
    return value;
  }
  else if( isValueANumber) {
    return [NSString stringWithFormat:@"%@", value];
  }
  else {
    return nil;
  }
}


- (NSNumber*)numberForKey:(NSString*)key
{
  NSNumber *value = [self valueForKey:key];
  
  BOOL isValueOfExpectedType  = [value isKindOfClass:[NSNumber class]];
  
  return isValueOfExpectedType ? value : nil;
}


@end
