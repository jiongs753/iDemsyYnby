//
//  DemsyBbsTable2Controller.h
//  云南白药
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyTableController.h"
#import "DemsyBbs.h"

@interface DemsyBbsReplyTableController : DemsyTableController

@property (retain, nonatomic) DemsyBbs *dataModel;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (void) reload;

@end
