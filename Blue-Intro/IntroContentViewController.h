//
//  IntroContentViewController.h
//  Teste-PopAnim1
//
//  Created by Allan Alves on 12/18/14.
//  Copyright (c) 2014 Allan Alves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroContentViewController : UIViewController

@property (nonatomic) NSInteger indexPage;
@property (nonatomic) NSString *titlePage;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
