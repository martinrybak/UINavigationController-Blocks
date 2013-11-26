//
//  MRAppDelegate.m
//  MRNavigationController
//
//  Created by Martin Rybak on 11/23/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRAppDelegate.h"
#import "UINavigationController+Blocks.h"
#import "MRViewControllerOne.h"
#import "MRViewControllerTwo.h"
#import "MRViewControllerThree.h"
#import "MRViewControllerFour.h"

@interface MRAppDelegate ()

@property (strong, nonatomic) UINavigationController* nav;
@property (strong, nonatomic) MRViewControllerOne* vc1;
@property (strong, nonatomic) MRViewControllerTwo* vc2;
@property (strong, nonatomic) MRViewControllerThree* vc3;
@property (strong, nonatomic) MRViewControllerFour* vc4;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation MRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.vc1 = [[MRViewControllerOne alloc] init];
	self.vc1.title = @"Root";
	self.vc1.delegate = self;
	self.nav = [[UINavigationController alloc] initWithRootViewController:self.vc1 navigationBarHidden:YES toolBarHidden:YES];
	self.window.rootViewController = self.nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
    //Uncomment to see confirm that view controllers are set to nil over time
	//self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ping) userInfo:nil repeats:YES];

    return YES;
}

#pragma mark - MRViewControllerOneDelegate

- (void)showVC2
{
	self.vc2 = [[MRViewControllerTwo alloc] init];
	self.vc2.delegate = self;
	self.vc2.title = @"View Controller 2";
	[self.nav pushViewController:self.vc2 animated:YES navigationBarHidden:NO toolBarHidden:NO completion:^{
		NSLog(@"VC1 pushed VC2");
	} onBack:^{
		NSLog(@"VC2 back pressed");
		self.vc2 = nil;
	}];
}

#pragma mark - MRViewControllerTwoDelegate

- (void)showVC3
{
	self.vc3 = [[MRViewControllerThree alloc] init];
	self.vc3.delegate = self;
	self.vc3.title = @"View Controller 3";
	[self.nav pushViewController:self.vc3 animated:YES navigationBarHidden:NO toolBarHidden:YES completion:^{
		NSLog(@"VC2 pushed VC3");
	} onBack:^{
		NSLog(@"VC3 back pressed");
		self.vc3 = nil;
	}];
}

#pragma mark - MRViewControllerThreeDelegate

- (void)popToVC1
{
	[self.nav popViewControllerAnimated:YES completion:^{
        NSLog(@"VC2 popped to VC1");
		self.vc2 = nil;
    }];
}

- (void)showVC4
{
	self.vc4 = [[MRViewControllerFour alloc] init];
	self.vc4.delegate = self;
	self.vc4.title = @"View Controller 4";
	[self.nav pushViewController:self.vc4 animated:YES navigationBarHidden:NO toolBarHidden:NO completion:^{
		NSLog(@"VC3 pushed VC4");
	} onBack:^{
		NSLog(@"VC4 back pressed");
		self.vc4 = nil;
	}];
}

#pragma mark - MRViewControllerFourDelegate

- (void)popToRoot
{
	[self.nav popToRootViewControllerAnimated:YES completion:^{
        NSLog(@"VC4 popped to Root");
		self.vc1 = nil;
		self.vc2 = nil;
		self.vc3 = nil;
		self.vc4 = nil;
    }];
}

- (void)popToVC3
{
	[self.nav popToViewController:self.vc3 animated:YES completion:^{
		NSLog(@"VC4 popped to VC3");
		self.vc4 = nil;
    }];
}

- (void)popToVC2
{
    [self.nav popToViewController:self.vc2 animated:YES completion:^{
        NSLog(@"VC4 popped to VC2");
		self.vc3 = nil;
    }];
}

#pragma mark - Private

- (void)ping
{
	NSLog(@"VC1 = %@", self.vc1.title);
	NSLog(@"VC2 = %@", self.vc2.title);
	NSLog(@"VC3 = %@", self.vc3.title);
	NSLog(@"VC4 = %@", self.vc4.title);
}

@end
