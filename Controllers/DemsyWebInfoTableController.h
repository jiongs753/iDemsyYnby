//
//  NewsViewController.h
//  demsy
//
//  Created by yongshan ji on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemsyWebInfoDetailController.h"
#import "DemsyWebInfo.h"
#import "DemsyTableController.h"

@interface DemsyWebInfoTableController: DemsyTableController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) DemsyWebInfoDetailController *detailController;

- (DemsyWebInfo *) dataModelForRow: (NSInteger) row;


@end
