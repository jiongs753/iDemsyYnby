//
//  NewsViewController.m
//  demsy
//
//  Created by yongshan ji on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyWebInfoTableController.h"
#import "DemsyWebInfoDetailController.h"
#import "DemsyUtils.h"
#import "DemsyAsyncImageView.h"

@interface DemsyWebInfoTableController ()

@end

@implementation DemsyWebInfoTableController

@synthesize tableView=_tableView;
@synthesize tableViewCell;

@synthesize tableData;

@synthesize detailController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新闻列表";
    
    // 加载缓存数据
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"webinfodata.plist"]; 

    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.tableData = array;
    [array release];

    // 异步加载最新数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s",DEMSY_URL_WEBINFO_PLIST]];
    [self loadDataFromUrl:url];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableViewCell = nil;
    self.tableData = nil;
    self.detailController = nil;}

- (void)dealloc
{
    [super dealloc];
    
    [_tableView release];
    [tableViewCell release];
    [tableData release];
    [detailController release];}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WebInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemsyWebInfoTableCell" owner:self options:nil];
        if([nib count] > 0){
            cell = self.tableViewCell;
        }else{
            NSLog(@"failed to load DemsyWebInfoTableCell nib file!");
        }
    }
    	
    DemsyWebInfo *dataModel = [self dataModelForRow:[indexPath row]];
        
    UILabel *titleLabel = (UILabel *)[tableViewCell viewWithTag:1];
    titleLabel.text = [dataModel title];
    
    UILabel *summLabel = (UILabel *)[tableViewCell viewWithTag:2];
    summLabel.text = [dataModel summary];
    summLabel.numberOfLines=2;
    
    UIImageView *imageView = (UIImageView *)[tableViewCell viewWithTag:3];
    DemsyAsyncImageView *asyncImage = [[[DemsyAsyncImageView alloc] init] autorelease];
    asyncImage.imageView = imageView;
    NSURL *url = [DemsyUtils url:dataModel.image];
    [asyncImage loadImageFromURL:url];
        
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if(detailController == nil){
        DemsyWebInfoDetailController *controller = [[DemsyWebInfoDetailController alloc] initWithNibName:@"DemsyWebInfoDetailView" bundle:nil];
        
        self.detailController = controller;
        
        [controller release];
    }
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    DemsyWebInfo *model = [self dataModelForRow:[indexPath row]];
    detailController.dataModel = model;
    detailController.title = [model title];
    [detailController.webView clearsContextBeforeDrawing];
    
    [detailController reload];
}

#pragma inner methods
- (DemsyWebInfo *) dataModelForRow: (NSInteger) row
{
    DemsyWebInfo *model = [[[DemsyWebInfo alloc] init] autorelease];
    
    NSDictionary *dic = (NSDictionary *)[tableData objectAtIndex:row];
    model.ID = [dic objectForKey:@"id"];
    model.commentCount = [dic objectForKey: @"comment-count"];
    model.image = [dic objectForKey:@"image"];
    model.title = [dic objectForKey:@"title"];
    model.summary = [dic objectForKey:@"summary"];
    model.updated = [dic objectForKey:@"updated"];
    model.content = [dic objectForKey:@"content"];
    
    return model;
}

- (void)processData{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"webinfodata.plist"]; 
    
    [self.asynLoadedData writeToFile:path atomically:TRUE];
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.tableData = array;
    [array release];
    
    [_tableView reloadData];
}

@end
