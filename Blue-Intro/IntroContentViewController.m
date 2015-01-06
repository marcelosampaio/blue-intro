//
//  IntroContentViewController.m
//  Teste-PopAnim1
//
//  Created by Allan Alves on 12/18/14.
//  Copyright (c) 2014 Allan Alves. All rights reserved.
//

#import "IntroContentViewController.h"

@interface IntroContentViewController ()

@end

@implementation IntroContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAppearance];
}

- (void) viewWillAppear:(BOOL)animated{
    [self.labelTitle setText:self.titlePage];
}

#pragma mark - Appearance

- (void) setAppearance{
    self.labelTitle.center = self.view.center;
}

@end
