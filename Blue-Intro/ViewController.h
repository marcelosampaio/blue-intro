//
//  ViewController.h
//  Teste-PopAnim1
//
//  Created by Allan Alves on 12/18/14.
//  Copyright (c) 2014 Allan Alves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (nonatomic) UIImageView *imageViewChange;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlIntro;
@property (weak, nonatomic) IBOutlet UIButton *buttonSkip;

@end

