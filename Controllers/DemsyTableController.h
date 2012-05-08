//
//  DemsyTableController.h
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemsyAsynURLController.h"

@interface DemsyTableController : DemsyAsynURLController<UITableViewDelegate,UITableViewDataSource>


@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@property NSInteger totalRecords;
@property NSInteger pageIndex;
@property (retain, nonatomic) NSMutableArray *dataRows;

- (void) loadDataRowsFromCachedFile;
- (void) loadNextPageFromURL;
- (NSString *) getCachedFileName: (NSString *) fileName;

- (NSString *) getCachedFileName;
- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex;

@end
