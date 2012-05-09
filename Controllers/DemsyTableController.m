//
//  DemsyTableController.m
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyTableController.h"
#import "EGORefreshTableHeaderView.h"
#import "DemsyUtils.h"

@implementation DemsyTableController

@synthesize tableView=_tableView;
@synthesize tableViewCell;
@synthesize pageIndex;
@synthesize dataRows;

// scroll refresh
@synthesize refreshHeaderView;
@synthesize reloading;
@synthesize noMore;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataRows = [[NSMutableArray alloc] init];
    
    // 加载缓存数据
    [self loadDataRowsFromCachedFile];
    
    // 异步加载最新数据
    [self asynLoadDataFromUrl:[self getURLForPageIndex:1]];
    
    // scroll refresh
    if (refreshHeaderView == nil) { 
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		refreshHeaderView = view;
		[view release];
    } 
    [refreshHeaderView refreshLastUpdatedDate]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableViewCell = nil;
    self.dataRows = nil;
    self.refreshHeaderView = nil;
}

- (void)dealloc
{
    [super dealloc];
    
    [_tableView release];
    [tableViewCell release];
    [dataRows release];
    [refreshHeaderView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataRows.count < DEMSY_PAGE_SIZE){
        return dataRows.count;
    }
    
    return dataRows.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 69;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
}
#pragma mark - abstract methods will be override

- (NSString *) getCachedFileName{
    return nil;
}

- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex
{
    return nil;
}

- (NSString *) getCachedFileName: (NSString *) fileName{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,[fileName stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
    
    return path;
}

- (void)processAsynLoadedData{
    [self.asynLoadedData writeToFile:[self getCachedFileName] atomically:TRUE];
    
    [self.dataRows removeAllObjects];
    [self loadDataRowsFromCachedFile];
    
    [_tableView reloadData];
}

- (void) loadDataRowsFromCachedFile{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getCachedFileName]];
    
    [self appendDataRows:dic];
    
    [dic release];
}

#pragma mark - load next page data

-(void)loadMore 
{ 
    [self loadNextPageFromURL];
    
    [self performSelectorOnMainThread:@selector(appendTableWith) withObject:nil waitUntilDone:NO];
} 

- (void) loadNextPageFromURL{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:[self getURLForPageIndex: pageIndex+1]];
    
    [self appendDataRows:dic];
    
    [dic release];  
}

-(void) appendDataRows: (NSDictionary *) result{
    NSArray *rows = [result objectForKey:@"rows"];
    
    //delete more row
    if(rows.count < DEMSY_PAGE_SIZE){
        self.noMore = TRUE;
    }
    
    [dataRows addObjectsFromArray:rows];
    self.pageIndex = [[result objectForKey: @"pageIndex"] integerValue];

}

-(void) appendTableWith
{ 
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:20]; 
    for (int row = (pageIndex-1) * DEMSY_PAGE_SIZE; row < [self.dataRows count]; row++) { 
        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:row inSection:0]; 
        [insertIndexPaths addObject:newPath]; 
    } 
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone]; 
} 

#pragma mark - scroll refresh data
#pragma mark – 
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:[self getURLForPageIndex: 1]];
    
    [self.dataRows removeAllObjects];
    self.noMore = FALSE;
    
    [self appendDataRows:dic];
    
    [dic release];  
    
    [self.tableView reloadData];
    
    reloading = YES; 
}

- (void)doneLoadingTableViewData{ 
    reloading = NO; 
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView]; 
} 
#pragma mark – 
#pragma mark UIScrollViewDelegate Methods 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView]; 
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ 
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView]; 
} 
#pragma mark – 
#pragma mark EGORefreshTableHeaderDelegate Methods 
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource]; 
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0]; 
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return reloading; 
} 

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];     
} 

@end
