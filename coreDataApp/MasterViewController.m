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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Note *note = self.notes[indexPath.row];
  NSString *text = [note valueForKey:@"text"];
  CGFloat height = [self findHeightForText:text havingWidth:250 andFont:[UIFont systemFontOfSize:16.0]];
  return height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  noteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell"];
  
  Note *note = self.notes[indexPath.row];
  
  NSLog(@"[%@], '%@'", [note valueForKey:@"text"], [note valueForKey:@"noteId"]);
  
  cell.noteTextLabel.text = [[note valueForKey:@"text"] description];
  cell.idLabel.text = [[note valueForKey:@"noteId"] description];
  
  return cell;
}

#pragma mark - Helper

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
  CGFloat result = font.pointSize+4;
  if (text) {
    CGSize size;
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil];
    size = CGSizeMake(frame.size.width, frame.size.height+1);
    result = MAX(size.height, result); //At least one row
  }
  return result;
}

@end
