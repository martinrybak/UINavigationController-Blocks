//
//  MRNavigationController.m
//  MRNavigationController
//
//  Created by Martin Rybak on 9/3/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRNavigationControllerDelegate.h"
#import "MRViewController.h"
#import "MRStack.h"

@interface MRNavigationControllerDelegate ()

@property (weak, nonatomic) UINavigationController* navigationController;
@property (weak, nonatomic) UIViewController* rootController;
@property (strong, nonatomic) MRStack* controllers;
@property (strong, nonatomic) MRViewController* pushedController;
@property (weak, nonatomic) UIViewController* popToController;
@property (copy, nonatomic) void(^popToControllerCompletion)(void);

@end

@implementation MRNavigationControllerDelegate

#pragma mark - Public

- (id)initWithNavigationController:(UINavigationController*)navigationController rootViewController:(UIViewController*)rootViewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden
{
    if (self = [super init])
    {
        self.controllers = [[MRStack alloc] init];
        self.navigationController = navigationController;
        self.rootController = rootViewController;
        [self savePushedController:rootViewController navigationBarHidden:navigationBarHidden toolBarHidden:toolBarHidden completion:nil back:nil];
    }
    return self;
}

- (void)savePushedController:(UIViewController*)viewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden completion:(void(^)(void))completion back:(void(^)(void))back
{
    self.pushedController = [[MRViewController alloc] init];
	self.pushedController.controller = viewController;
	self.pushedController.navigationBarHidden = navigationBarHidden;
	self.pushedController.toolBarHidden = toolBarHidden;
	self.pushedController.completion = completion;
	self.pushedController.back = back;
}

- (void)savePopToViewController:(UIViewController*)viewController completion:(void(^)(void))completion
{
    self.popToController = viewController;
    self.popToControllerCompletion = completion;
}

- (void)savePopToRootController:(void(^)(void))completion
{
    self.popToController = self.rootController;
    self.popToControllerCompletion = completion;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
	//If this is a push
	if (viewController == self.pushedController.controller)
	{
		[self.navigationController setNavigationBarHidden:self.pushedController.navigationBarHidden animated:animated];
		[self.navigationController setToolbarHidden:self.pushedController.toolBarHidden animated:animated];
        return;
	}
	
	//This is a back button press
	if (!self.popToController)
    {
		MRViewController* controllerToPop = [self.controllers pop];
		if (controllerToPop.back)
			controllerToPop.back();
	}
    
    //This is a pop
    else
    {
		//Kill the other controllers if this is a mult-level pop
        while (((MRViewController*)[self.controllers peek]).controller != self.popToController)
            [self.controllers pop];
    }
	
	//Show the navigation bar and toolbar preferences of the now-topmost controller
    MRViewController* nextController = [self.controllers peek];
    [self.navigationController setNavigationBarHidden:nextController.navigationBarHidden animated:animated];
    [self.navigationController setToolbarHidden:nextController.toolBarHidden animated:animated];
}

- (void)navigationController:(UINavigationController*)navigationController didShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
	//If this is a push
	if (viewController == self.pushedController.controller)
	{
		if (self.pushedController.completion)
			self.pushedController.completion();
		[self.controllers push:self.pushedController];
		self.pushedController = nil;
        return;
	}
    
    //If this is a pop
    if (self.popToController)
    {
        if (self.popToControllerCompletion)
            self.popToControllerCompletion();
        self.popToController = nil;
        self.popToControllerCompletion = nil;
    }
}

@end
