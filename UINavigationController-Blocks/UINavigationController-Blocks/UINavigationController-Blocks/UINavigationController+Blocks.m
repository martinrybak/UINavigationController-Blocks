//
//  UINavigationController+Blocks.m
//  MRNavigationController
//
//  Created by Martin Rybak on 11/24/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "UINavigationController+Blocks.h"
#import "MRNavigationControllerDelegate.h"
#import <objc/runtime.h>

static char* const navigationControllerDelegateKey = "MRNavigationControllerDelegate";

@implementation UINavigationController (Back)

#pragma mark - Associated References

@dynamic navigationControllerDelegate;

- (MRNavigationControllerDelegate*)navigationControllerDelegate
{
    return objc_getAssociatedObject(self, navigationControllerDelegateKey);
}

- (void)setNavigationControllerDelegate:(MRNavigationControllerDelegate*)navigationControllerDelegate
{
    objc_setAssociatedObject(self, navigationControllerDelegateKey, navigationControllerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (id)initWithRootViewController:(UIViewController*)rootViewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden
{
	if (self = [self initWithRootViewController:rootViewController])
	{
        self.navigationControllerDelegate = [[MRNavigationControllerDelegate alloc] initWithNavigationController:self rootViewController:rootViewController navigationBarHidden:navigationBarHidden toolBarHidden:toolBarHidden];
        self.delegate = self.navigationControllerDelegate;
    }
	return self;
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden completion:(void(^)(void))completion onBack:(void(^)(void))onBack
{
    [self.navigationControllerDelegate savePushedController:viewController navigationBarHidden:navigationBarHidden toolBarHidden:toolBarHidden completion:completion onBack:onBack];
    [self pushViewController:viewController animated:animated];
}

- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion
{
    [self.navigationControllerDelegate savePopToRootController:completion];
	return [self popToRootViewControllerAnimated:animated];
}

- (NSArray*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void(^)(void))completion
{
    [self.navigationControllerDelegate savePopToViewController:viewController completion:completion];
	return [self popToViewController:viewController animated:animated];
}

@end
