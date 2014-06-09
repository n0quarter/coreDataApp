//
//  CoreDataManager.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

static CoreDataManager *s_sharedInstance = nil;

+ (CoreDataManager*)sharedInstance
{
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    s_sharedInstance = [[CoreDataManager alloc] init];
  });
  
  return s_sharedInstance;
}

- (id)init {
  self = [super init];
  if (self) {
    NSLog(@"CoreDataManager init");
  }
  return self;
}




- (void)saveContext
{
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}


@end
