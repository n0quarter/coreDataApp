//
//  CoreDataManager.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "CoreDataManager.h"

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

- (id)init {
  self = [super init];
  if (self) {
    NSLog(@"CoreDataManager init. drop table");
//    [self dropAllData];
  }
  return self;
}



# pragma mark - Methods

- (void)populateCoreDataWithArray:(NSArray *)notes
{
  NSLog(@"populateCoreDataWithDictionary = %@", notes);
  
  NSManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                        inManagedObjectContext:self.managedObjectContext];
  // just test, to be sure core data works
  [note setValue:@11 forKey:@"id"];
  [note setValue:@"text123" forKey:@"text"];
  
  [self saveContext];
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
  NSArray *allUsers = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
  
  for(NSManagedObject *user in allUsers){
    NSString *note_id = [user valueForKey:@"id"];
    NSString *text    = [user valueForKey:@"text"];
    NSLog(@"[%@] = '%@'", note_id, text);
  }
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
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
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

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"coreDataApp" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
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
