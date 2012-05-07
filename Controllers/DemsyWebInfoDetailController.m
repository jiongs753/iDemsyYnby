//
//  NewsDetailViewController.m
//  demsy
//
//  Created by yongshan ji on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyWebInfoDetailController.h"
#import "DemsyUtils.h"

@implementation DemsyWebInfoDetailController

@synthesize dataModel;
@synthesize webView;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.dataModel = nil;
    self.webView = nil;
}

- (void)dealloc{
    [super dealloc];
    
    [dataModel release];
    [webView release];
}


- (void)reload{
    
    NSString *urlStr=[NSString stringWithFormat:@"%s/%@",DEMSY_URL_WEBINFO_DETAIL ,dataModel.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self loadDataFromUrl:url];
}

- (void) processData{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s",DEMSY_WEB_SERVER]];

    [self.webView loadData:[self asynLoadedData] MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
}

@end
