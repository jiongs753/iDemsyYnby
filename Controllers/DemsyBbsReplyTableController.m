//
//  DemsyBbsTable2Controller.m
//  云南白药
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyBbsReplyTableController.h"
#import "DemsyUtils.h"

@implementation DemsyBbsReplyTableController

@synthesize dataModel;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.dataModel = nil;
    self.webView = nil;
}

- (void)dealloc{
    [super dealloc];
    
    [dataModel release];
    [webView release];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BbsReplyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
    
    if([indexPath row] == ([self.dataRows count])) { 
        if(cell == nil){
            cell = [[[UITableViewCell alloc] initWithFrame: CGRectMake(0, 0, 100, 20)] autorelease]; 
        }
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        //自动加载分页数据
        if(!self.noMore){
            cell.textLabel.text=[NSString stringWithFormat: @"正在加载第 %d 页...", self.pageIndex + 1]; 
            [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        }else {
            cell.textLabel.text = [NSString stringWithFormat: @"共 %d 条记录!", self.dataRows.count]; 
        }
    }else{
        

    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemsyBbsTableCell" owner:self options:nil];
        if([nib count] > 0){
            cell = self.tableViewCell;
        }else{
            NSLog(@"failed to load DemsyBbsTableCell nib file!");
        }
    }
    
    DemsyBbs *model = [self dataModelForRow:[indexPath row]];
    
    if(model == nil)
        return nil;
    
    UILabel *titleLabel = (UILabel *)[self.tableViewCell viewWithTag:1];
    titleLabel.text = [model title];
    
    UILabel *summLabel = (UILabel *)[self.tableViewCell viewWithTag:2];
    summLabel.text = [model summary];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)reload{
    
    NSString *urlStr=[NSString stringWithFormat:@"%s%s/%@/1",DEMSY_WEB_SERVER, DEMSY_URL_BBS_REPLY_PLIST ,dataModel.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self asynLoadDataFromUrl:url];
}

- (NSString *) getCachedFileName{
    NSString *documentsDirectory =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"bbsreply.plist"];
    
    return path;
}

- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s/%d/%d",DEMSY_WEB_SERVER,DEMSY_URL_BBS_REPLY_PLIST,self.dataModel.ID,pageIndex]];
    
    return url;
}

- (DemsyBbs *) dataModelForRow: (NSInteger) row
{
    DemsyBbs *model = [[[DemsyBbs alloc] init] autorelease];
    
    NSDictionary *dataRow = (NSDictionary *)[self.dataRows objectAtIndex:row];
    model.ID = [dataRow objectForKey:@"id"];
    model.commentCount = [dataRow objectForKey: @"comment-count"];
    model.image = [dataRow objectForKey:@"image"];
    model.title = [dataRow objectForKey:@"title"];
    model.summary = [dataRow objectForKey:@"summary"];
    model.updated = [dataRow objectForKey:@"updated"];
    model.content = [dataRow objectForKey:@"content"];
    
    return model;
}

@end
