//
//  DemsyWebInfoRootController.m
//  demsyios
//
//  Created by yongshan ji on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyWebInfoRootController.h"
#import "DemsyWebInfoTableController.h"

@interface DemsyWebInfoRootController ()

@end

@implementation DemsyWebInfoRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    DemsyWebInfoTableController *tableController = [[DemsyWebInfoTableController alloc] initWithNibName:@"DemsyWebInfoTableView" bundle:nil];
    
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
