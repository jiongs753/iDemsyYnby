//
//  DemsyBbsTableController.h
//  云南白药
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyTableController.h"
#import "DemsyBbsReplyTableController.h"
#import "DemsyBbs.h"

@interface DemsyBbsTableController : DemsyTableController

@property (retain, nonatomic) DemsyBbsReplyTableController *detailController;

- (DemsyBbs *) dataModelForRow: (NSInteger) row;

@end
