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
#import "DemsyAsynURLController.h"

@interface DemsyWebInfoTableController: DemsyAsynURLController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;@property (retain, nonatomic) NSArray *tableData;

@property (retain, nonatomic) DemsyWebInfoDetailController *detailController;

- (DemsyWebInfo *) dataModelForRow: (NSInteger) row;


@end
