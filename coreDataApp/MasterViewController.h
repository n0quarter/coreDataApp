//
//  MasterViewController.h
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
