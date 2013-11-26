//
//  MRNavigationControllerDelegate
//  MRNavigationController
//
//  Created by Martin Rybak on 9/3/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

- (id)initWithNavigationController:(UINavigationController*)navigationController rootViewController:(UIViewController*)rootViewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden;
- (void)savePushedController:(UIViewController*)viewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden completion:(void(^)(void))completion back:(void(^)(void))back;
- (void)savePopToViewController:(UIViewController*)viewController completion:(void(^)(void))completion;
- (void)savePopToRootController:(void(^)(void))completion;

@end
