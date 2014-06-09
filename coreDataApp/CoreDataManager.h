//
//  CoreDataManager.h
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (CoreDataManager*)sharedInstance;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;

@end
