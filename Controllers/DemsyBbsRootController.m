//
//  DemsyBbsRootController.m
//  云南白药
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyBbsRootController.h"
#import "DemsyBbsTableController.h"

@interface DemsyBbsRootController ()

@end

@implementation DemsyBbsRootController

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
    
    DemsyBbsTableController *tableController = [[DemsyBbsTableController alloc] initWithNibName:@"DemsyBbsTableView" bundle:nil];
    
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
