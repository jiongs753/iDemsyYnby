//
//  NewsDetailViewController.h
//  demsy
//
//  Created by yongshan ji on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemsyWebInfo.h"
#import "DemsyAsynURLController.h"

@interface DemsyWebInfoDetailController : DemsyAsynURLController<UIWebViewDelegate>

@property (retain, nonatomic) DemsyWebInfo *dataModel;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (void) reload;

@end
