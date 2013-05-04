//
//  DemsyUtils.h
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

#ifndef DEMSY_CONSTS
#define DEMSY_CONSTS

//#define DEMSY_TEST 1

#define DEMSY_PAGE_SIZE 20

#ifdef DEMSY_TEST

#define DEMSY_WEB_SERVER "http://192.168.1.10:9090"
#define DEMSY_URL_WEBINFO_PLIST "/ui/iphone/plistWebInfo/70/55"
#define DEMSY_URL_WEBINFO_DETAIL "/ui/iphone/detailWebInfo"
#define DEMSY_URL_PRODUCT_PLIST "/ui/iphone/plistProduct/55/55"
#define DEMSY_URL_PRODUCT_DETAIL "/ui/iphone/detailProduct"
#define DEMSY_URL_BBS_PLIST "/ui/iphone/plistBbs"
#define DEMSY_URL_BBS_DETAIL "/ui/iphone/detailBbs"
#define DEMSY_URL_BBS_REPLY_PLIST "/ui/iphone/plistBbsReply"
#define DEMSY_URL_BBS_REPLY_DETAIL "/ui/iphone/detailBbsReply"

#endif

#ifndef DEMSY_TEST

#define DEMSY_WEB_SERVER "http://www.yunnanbaiyao.com.cn"
#define DEMSY_URL_WEBINFO_PLIST "/ui/iphone/plistWebInfo/70/55"
#define DEMSY_URL_WEBINFO_DETAIL "/ui/iphone/detailWebInfo"
#define DEMSY_URL_PRODUCT_PLIST "/ui/iphone/plistProduct/55/55"
#define DEMSY_URL_PRODUCT_DETAIL "/ui/iphone/detailProduct"
#define DEMSY_URL_BBS_PLIST "/ui/iphone/plistBbs"
#define DEMSY_URL_BBS_DETAIL "/ui/iphone/detailBbs"
#define DEMSY_URL_BBS_REPLY_PLIST "/ui/iphone/plistBbsReply"
#define DEMSY_URL_BBS_REPLY_DETAIL "/ui/iphone/detailBbsReply"
#endif

#endif

@interface DemsyUtils : NSObject

+ (NSURL *) url:(NSString *)relativePath;

@end
