//
//  MRViewControllerTwo.m
//  MRNavigationController
//
//  Created by Martin Rybak on 11/23/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRViewControllerTwo.h"

@implementation MRViewControllerTwo

- (IBAction)showVC3:(id)sender
{
	[self.delegate showVC3];
}

- (IBAction)popToVC1:(id)sender
{
    [self.delegate popToVC1];
}

@end
