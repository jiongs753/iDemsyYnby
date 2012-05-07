//
//  DemsyProductDetailController.h
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemsyProduct.h"
#import "DemsyAsynURLController.h"

@interface DemsyProductDetailController : DemsyAsynURLController<UIWebViewDelegate>

@property (retain, nonatomic) DemsyProduct *dataModel;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (void) reload;
- (void) buy;


@end
