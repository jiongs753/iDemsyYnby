//
//  DemsyProductTableController.h
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemsyProductDetailController.h"
#import "DemsyTableController.h"
#import "DemsyProduct.h"

@interface DemsyProductTableController : DemsyTableController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) DemsyProductDetailController *detailController;

- (DemsyProduct *) dataModelForRow: (NSInteger) row;
- (void) loadProductCatalog;

@end
