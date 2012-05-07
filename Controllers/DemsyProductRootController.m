//
//  DemsyProductRootController.m
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyProductRootController.h"
#import "DemsyProductTableController.h"

@interface DemsyProductRootController ()

@end

@implementation DemsyProductRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DemsyProductTableController *tableController = [[DemsyProductTableController alloc] initWithNibName:@"DemsyProductTableView" bundle:nil];
    
    [self pushViewController:tableController animated:TRUE];
    
    [tableController release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
