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
    
    return cell;
}

#pragma mark - Table view delegate

- (void)reload{
    
    NSString *urlStr=[NSString stringWithFormat:@"%s/%@/1",DEMSY_URL_BBS_REPLY_PLIST ,dataModel.ID];
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%d/%d",DEMSY_URL_BBS_REPLY_PLIST,self.dataModel.ID,pageIndex]];
    
    return url;
}

- (DemsyBbs *) dataModelForRow: (NSInteger) row
{
    DemsyBbs *model = [[[DemsyBbs alloc] init] autorelease];
    
    if (row != 0 && [self.dataRows count] <= row){
        [self loadNextPageFromURL];
    }
    if (row != 0 && [self.dataRows count] <= row){
        return nil;
    }
    
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
