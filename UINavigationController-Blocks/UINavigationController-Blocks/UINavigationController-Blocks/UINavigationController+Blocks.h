//
//  UINavigationController+Blocks.h
//  MRNavigationController
//
//  Created by Martin Rybak on 11/24/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRNavigationControllerDelegate.h"

@interface UINavigationController (Blocks)

@property (strong, nonatomic) MRNavigationControllerDelegate* navigationControllerDelegate;
- (id)initWithRootViewController:(UIViewController*)rootViewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden;
- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden completion:(void(^)(void))completion back:(void(^)(void))back;
- (UIViewController*)popViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

@end
