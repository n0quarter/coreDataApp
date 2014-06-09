//
//  noteCell.h
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* noteTextLabel;
@property (nonatomic, weak) IBOutlet UILabel* idLabel;

@end
