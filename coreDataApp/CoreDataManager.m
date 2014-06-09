//
//  CoreDataManager.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "CoreDataManager.h"
#import "NSDictionary+parseValues.h"
#import "Note.h"

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static CoreDataManager *s_sharedInstance = nil;

# pragma mark - INIT

+ (CoreDataManager*)sharedInstance
{
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    s_sharedInstance = [[CoreDataManager alloc] init];
  });
  
  return s_sharedInstance;
}



# pragma mark - Methods

- (NSArray *)loadAllNotes
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
  NSArray *allNotes = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

  // for debug
//  for(NSManagedObject *note in allNotes){
//    if ([[note valueForKey:@"noteId"] isKindOfClass:[NSNumber class]] && [[note valueForKey:@"text"] isKindOfClass:[NSString class]]) {
//      NSLog(@"[read] id = %@, text = %@", [note valueForKey:@"noteId"], [note valueForKey:@"text"]);
//    }
//  }
  
  NSLog(@"-------------------- read: count = %d", [allNotes count]);
  return allNotes;
}

- (void)populateCoreDataWithArray:(NSArray *)notes
{
  NSLog(@"-------------------- populateCoreDataWithDictionary. write: count = %d", [notes count]);

//  NSLog(@"populateCoreDataWithDictionary = %@", notes);
  
  [notes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
    NSDictionary *dict;
    [obj isKindOfClass:[NSDictionary class]] ? dict = (NSDictionary *)obj : nil;
    
    NSManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                          inManagedObjectContext:self.managedObjectContext];
    
//    NSLog(@"[write] id = %@, text = %@", [dict numberForKey:@"id"], [dict stringForKey:@"text"]);
    
    [note setValue:[dict numberForKey:@"id"] forKey:@"noteId"];
    [note setValue:[dict stringForKey:@"text"] forKey:@"text"];
  }];
  
  [self saveContext];
  
}

- (void)dropAllData
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
  NSArray *allNotes = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
  
  for(NSManagedObject *note in allNotes){
    [self.managedObjectContext deleteObject:note];
  }
  [[CoreDataManager sharedInstance] saveContext];
}

- (void)saveContext
{
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}




#pragma mark - Core Data stuff

- (NSManagedObjectContext *)managedObjectContext
{
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"coreDataApp" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coreDataApp.sqlite"];
  
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
