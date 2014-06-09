//
//  noteCell.m
//  coreDataApp
//
//  Created by Viktor Shcherban on 09/06/14.
//  Copyright (c) 2014 Viktor Shcherban. All rights reserved.
//

#import "noteCell.h"

@implementation noteCell

- (void)awakeFromNib
{
  self.webView.scrollView.scrollEnabled = NO;
  self.webView.scrollView.bounces = NO;

  self.webView.delegate = self;
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
  if (inType == UIWebViewNavigationTypeLinkClicked) {
    [[UIApplication sharedApplication] openURL:[inRequest URL]];
    return NO;
  }
  return YES;
}

@end
