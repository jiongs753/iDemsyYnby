//
//  DemsyTableController.h
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemsyAsynURLController.h"
#import "EGORefreshTableHeaderView.h"

@interface DemsyTableController : DemsyAsynURLController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>


@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;

// paging data
@property NSInteger pageIndex;
@property (retain, nonatomic) NSMutableArray *dataRows;

// scroll refresh
@property (retain, nonatomic) EGORefreshTableHeaderView *refreshHeaderView;
@property BOOL reloading;
@property BOOL noMore;

- (void) loadDataRowsFromCachedFile;
- (void) loadNextPageFromURL;
- (NSString *) getCachedFileName: (NSString *) fileName;

- (NSString *) getCachedFileName;
- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex;

// scroll refresh
- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;

@end
