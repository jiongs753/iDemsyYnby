//
//  DemsyAsynURLController.h
//  demsyios
//
//  Created by yongshan ji on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemsyAsynURLController : UIViewController

// URL连接用于异步加载表视图
@property (retain, nonatomic) NSURLConnection  *connection;
// 异步加载的数据
@property (retain, nonatomic) NSMutableData *asynLoadedData;

- (void) asynLoadDataFromUrl :(NSURL*)url;
- (void) processAsynLoadedData;

@end
