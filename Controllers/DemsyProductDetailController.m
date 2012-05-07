//
//  DemsyProductDetailController.m
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyProductDetailController.h"
#import "DemsyUtils.h"

@implementation DemsyProductDetailController

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
    
    // add product buy button
    UIBarButtonItem *buyButton = [[UIBarButtonItem alloc] initWithTitle:@"购买" style:UIBarButtonItemStyleBordered target:self action:@selector(buy)];
    self.navigationItem.rightBarButtonItem = buyButton;
    [buyButton release];
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
    
    NSString *urlStr=[NSString stringWithFormat:@"%s/%@",DEMSY_URL_PRODUCT_DETAIL ,dataModel.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self loadDataFromUrl:url];
}

- (void) processData{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s",DEMSY_WEB_SERVER]];
    
    [self.webView loadData:[self asynLoadedData] MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
}

- (void) buy{
    
}

@end