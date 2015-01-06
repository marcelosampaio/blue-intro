//
//  ViewController.m
//  Teste-PopAnim1
//
//  Created by Allan Alves on 12/18/14.
//  Copyright (c) 2014 Allan Alves. All rights reserved.
//

#define transitionSpeed 0.3

#import "ViewController.h"
#import "IntroContentViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *arrayDescriptions;
    NSArray *arrayColors;
    NSInteger prevIndexPage;
}

- (void) viewDidLoad{
    NSLog(@"starting");
    //Descricoes das telas
    arrayDescriptions = @[@"Seja bem vindo ao melhor sistema de estacionamento rotativo do Brasil, o Blue!",
                          @"Cadastre-se através do aplicativo, procurando um de nossos Agentes de Estacionamento ou acesse nosso site",
                          @"Utilize o mapa, estacione na Zona Azul ou Verde e escolha o tipo da vaga e o tempo que deseja utilizar",
                          @"Compre créditos através do Celular, Pontos de Vendas ou com nossos Agentes de Estacionamento"];
    
    //Cores das telas
//    arrayColors = @[[UIColor colorWithRed:45.0/255.0 green:100.0/255.0 blue:165.0/255.0 alpha:1],
//                    [UIColor colorWithRed:40.0/255.0 green:80.0/255.0 blue:120.0/255.0 alpha:1],
//                    [UIColor colorWithRed:35.0/255.0 green:55.0/255.0 blue:85.0/255.0 alpha:1],
//                    [UIColor colorWithRed:30.0/255.0 green:45.0/255.0 blue:60.0/255.0 alpha:1]];

    arrayColors = @[[UIColor colorWithRed:208.0/255.0 green:32.0/255.0 blue:144.0/255.0 alpha:1],
                    [UIColor colorWithRed:255.0/255.0 green:165.0/255.0 blue:0 alpha:1],
                    [UIColor colorWithRed:67.0/255.0 green:205.0/255.0 blue:128.0/255.0 alpha:1],
                    [UIColor colorWithRed:45.0/255.0 green:100.0/255.0 blue:165.0/255.0 alpha:1]];
    
    //Instanciar Page View Controller tipo scroll horizontal
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    
    //Delegate e datasource
    [self.pageViewController setDelegate:self];
    [self.pageViewController setDataSource:self];
    
    //Iniciar com a primeira tela e configurar direcao
    [self.pageViewController setViewControllers:@[[self viewControllerWithIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    //Adicionar Page View Controller a este View Controller
    [self addChildViewController:self.pageViewController];
    [self didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    [self.view bringSubviewToFront:self.buttonSkip];

    //Ajustar Frames
    [self setAppearance];
    
    //Atualizar cor e descricao da pagina
    [self refreshPage];
}

- (void) viewDidAppear:(BOOL)animated{
    //Atualizar aparencia dos pontos da Page Control
    [self refreshDots];
}

#pragma mark - Refreshes

- (void) refreshPage{
    NSNumber *indexPage = [NSNumber numberWithInteger:[[self.pageViewController.viewControllers lastObject] indexPage]];
    
    [self.imageViewIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%@.png", indexPage]]];
    [self.view setBackgroundColor:[arrayColors objectAtIndex:indexPage.integerValue]];
}

- (void) refreshDots{
    for (UIView *view in self.pageControlIntro.subviews) {
        view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }
}

#pragma mark - Page View Controller

- (UIViewController*) viewControllerWithIndex:(NSInteger)index{
    if (arrayDescriptions.count == 0 || index >= arrayDescriptions.count) {
        return nil;
    }
    IntroContentViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroContentViewController"];
    
    viewController.indexPage = index;
    viewController.titlePage = [NSString stringWithFormat:@"%@", [arrayDescriptions objectAtIndex:index]];
    
    return viewController;
}

- (void) pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    IntroContentViewController *viewController = [pageViewController.viewControllers lastObject];
    prevIndexPage = viewController.indexPage;
    self.imageViewChange = [[UIImageView alloc] initWithFrame:self.imageViewIcon.frame];
    [self.imageViewChange setImage:self.imageViewIcon.image];
    [self.view addSubview:self.imageViewChange];
    self.imageViewIcon.alpha = 0;
    self.imageViewIcon.transform = CGAffineTransformMakeRotation(-3.1415);
}

- (void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    NSInteger index = [(IntroContentViewController*)[[pageViewController viewControllers] lastObject] indexPage];
    NSInteger direction = index-prevIndexPage;
    
    [UIView animateWithDuration:transitionSpeed animations:^{
        self.imageViewChange.alpha = 0;
        self.imageViewIcon.alpha = 1;
    }];
    self.imageViewChange.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:transitionSpeed animations:^{
        self.imageViewChange.transform = CGAffineTransformMakeRotation(3.1415*direction);
        self.imageViewIcon.transform = CGAffineTransformMakeRotation(3.1415*2*direction);
    }];
    [self refreshPage];
    
    IntroContentViewController *viewController = [self.pageViewController.viewControllers lastObject];
    [self.pageControlIntro setCurrentPage:viewController.indexPage];
    
    //Button skip title
    [UIView animateWithDuration:0.3 animations:^{
        if (viewController.indexPage == arrayDescriptions.count-1) {
            [self.buttonSkip setTitle:@"Continuar" forState:UIControlStateNormal];
        } else {
            [self.buttonSkip setTitle:@"Pular apresentação" forState:UIControlStateNormal];
        }
    }];
    [self refreshDots];
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [(IntroContentViewController*)viewController indexPage];
    if (index == arrayDescriptions.count) {
        return nil;
    }
    index++;
    return [self viewControllerWithIndex:index];
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [(IntroContentViewController*)viewController indexPage];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerWithIndex:index];
}

#pragma mark - Actions

- (IBAction)buttonSkipPressed:(id)sender {
    NSLog(@"BUTTON SKIP PRESSED");
}

#pragma mark - Appearance

- (void) setAppearance{
    [self.pageViewController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.imageViewIcon setFrame:CGRectMake(0, self.imageViewIcon.frame.origin.y, 100, 100)];
    self.imageViewIcon.center = CGPointMake(self.view.center.x, self.imageViewIcon.center.y);
    [self.pageControlIntro setFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 40)];
    [self.buttonSkip setFrame:CGRectMake(0, self.view.frame.size.height-16-self.buttonSkip.frame.size.height, self.view.frame.size.width, self.buttonSkip.frame.size.height)];
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
