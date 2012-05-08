//
//  DemsyAsynURLController.m
//  demsyios
//
//  Created by yongshan ji on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyAsynURLController.h"

@interface DemsyAsynURLController ()

@end

@implementation DemsyAsynURLController

@synthesize connection;
@synthesize asynLoadedData;


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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.connection = nil;
}

- (void) dealloc{
    [super dealloc];
    
    [connection release];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    if (asynLoadedData==nil) {
        asynLoadedData = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [asynLoadedData appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    [connection release];
    connection=nil;
    
    [self processAsynLoadedData];
    
    [asynLoadedData release];
    asynLoadedData=nil;
    
    self.navigationItem.titleView = nil;
}

- (void) asynLoadDataFromUrl :(NSURL*)url { 
    // add progress bar
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];    
    self.navigationItem.titleView = indicatorView;
    [indicatorView setFrame:CGRectMake(150, 12, 20, 20)];
    [indicatorView setHidden:FALSE];

    [indicatorView release];
    
    //request data
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) processAsynLoadedData{
    
}

@end
