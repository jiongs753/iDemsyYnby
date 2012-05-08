//
//  DemsyProductTableController.h
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemsyProductDetailController.h"
#import "DemsyAsynURLController.h"
#import "DemsyProduct.h"

@interface DemsyProductTableController : DemsyAsynURLController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;

@property (retain, nonatomic) NSDictionary *pageData;

@property (retain, nonatomic) DemsyProductDetailController *detailController;

- (DemsyProduct *) dataModelForRow: (NSInteger) row;
- (void) loadProductCatalog;

@end
