//
//  DemsyUtils.h
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifndef DEMSY_CONSTS
#define DEMSY_CONSTS

//网站服务器地址 192.168.1.10:9090
#define DEMSY_WEB_SERVER "http://192.168.1.10:9090"

// web info list url, suffix: /imageWidth/imageHeight
#define DEMSY_URL_WEBINFO_PLIST "http://192.168.1.10:9090/ui/iphone/plistWebInfo/70/55"

// web info detail url, suffix: /webInfoID
#define DEMSY_URL_WEBINFO_DETAIL "http://192.168.1.10:9090/ui/iphone/detailWebInfo"

// product list url, suffix: /imageWidth/imageHeight
#define DEMSY_URL_PRODUCT_PLIST "http://192.168.1.10:9090/ui/iphone/plistProduct/50/55"

// product detail url, suffix: /productID
#define DEMSY_URL_PRODUCT_DETAIL "http://192.168.1.10:9090/ui/iphone/detailProduct"

#endif

@interface DemsyUtils : NSObject

+ (NSURL *) url:(NSString *)relativePath;

@end
