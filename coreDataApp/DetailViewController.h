//
//  DetailViewController.h
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
