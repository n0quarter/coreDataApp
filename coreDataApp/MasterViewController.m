//
//  MasterViewController.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];  
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)fetchedResultsController
//{
//  if (_fetchedResultsController != nil) {
//    return _fetchedResultsController;
//  }
//
//  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//  // Edit the entity name as appropriate.
//  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
//  [fetchRequest setEntity:entity];
//
//  // Set the batch size to a suitable number.
//  [fetchRequest setFetchBatchSize:20];
//
//  // Edit the sort key as appropriate.
//  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
//  NSArray *sortDescriptors = @[sortDescriptor];
//
//  [fetchRequest setSortDescriptors:sortDescriptors];
//
//  // Edit the section name key path and cache name if appropriate.
//  // nil for section name key path means "no sections".
//  NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
//  aFetchedResultsController.delegate = self;
//  self.fetchedResultsController = aFetchedResultsController;
//
//	NSError *error = nil;
//	if (![self.fetchedResultsController performFetch:&error]) {
//    // Replace this implementation with code to handle the error appropriately.
//    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//    abort();
//	}
//
//  return _fetchedResultsController;
//}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


@end
