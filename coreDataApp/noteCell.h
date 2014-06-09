//
//  noteCell.h
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel* idLabel;
@property (nonatomic, weak) IBOutlet UIWebView* webView;

@end
