//
//  MasterViewController.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "MasterViewController.h"
#import "CoreDataManager.h"
#import "Note.h"
#import "noteCell.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *notes;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.notes = [[CoreDataManager sharedInstance] loadAllNotes];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.notes.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  noteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell"];

  if (indexPath.row < self.notes.count) {
    Note *note = self.notes[indexPath.row];
    
//    NSLog(@"[%@], '%@'", [note valueForKey:@"text"], [note valueForKey:@"id"]);
    
    cell.noteTextLabel.text = [[note valueForKey:@"text"] description];
    cell.idLabel.text = [[note valueForKey:@"noteId"] description];
  }
  return cell;
}

#pragma mark - Helper


@end
