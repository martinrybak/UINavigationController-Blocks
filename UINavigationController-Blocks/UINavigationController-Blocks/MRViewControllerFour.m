//
//  MRViewControllerFour.m
//  MRNavigationController
//
//  Created by Martin Rybak on 11/23/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRViewControllerFour.h"

@implementation MRViewControllerFour

- (IBAction)popToRoot:(id)sender
{
	[self.delegate popToRoot];
}

- (IBAction)popToVC2:(id)sender
{
	[self.delegate popToVC2];
}

- (IBAction)popToVC3:(id)sender
{
    [self.delegate popToVC3];
}

@end
