//
//  DemsyBbsTableController.m
//  云南白药
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyBbsTableController.h"
#import "DemsyUtils.h"

@implementation DemsyBbsTableController

@synthesize detailController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"论坛"; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.detailController = nil;
}

- (void)dealloc
{
    [super dealloc];
    
    [detailController release];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BbsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
    
    if([indexPath row] == ([self.dataRows count])) { 
        if(cell == nil){
            cell = [[[UITableViewCell alloc] initWithFrame: CGRectMake(0, 0, 100, 20)] autorelease]; 
        }
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"显示后20条..."; 
    }else{
        

    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemsyBbsTableCell" owner:self options:nil];
        if([nib count] > 0){
            cell = self.tableViewCell;
        }else{
            NSLog(@"failed to load DemsyBbsTableCell nib file!");
        }
    }
    
    DemsyBbs *dataModel = [self dataModelForRow:[indexPath row]];
    
    if(dataModel == nil)
        return nil;
    
    UILabel *titleLabel = (UILabel *)[self.tableViewCell viewWithTag:1];
    titleLabel.text = [dataModel title];
    
    UILabel *summLabel = (UILabel *)[self.tableViewCell viewWithTag:2];
    summLabel.text = [dataModel summary];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == [self.dataRows count]) { 
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"正在加载..."; 
        [self performSelectorInBackground:@selector(loadMore) withObject:nil]; 
        [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    }else {    

    if(detailController == nil){
        DemsyBbsReplyTableController *controller = [[DemsyBbsReplyTableController alloc] initWithNibName:@"DemsyBbsReplyTableView" bundle:nil];
        
        self.detailController = controller;
        
        [controller release];
    }
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    DemsyBbs *model = [self dataModelForRow:[indexPath row]];
    detailController.dataModel = model;
    detailController.title = [model title];
    [detailController.webView clearsContextBeforeDrawing];
    
    [detailController reload];
        
    }
}

#pragma mark - override methods

- (NSString *) getCachedFileName{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"bbs.plist"];
    
    return path;
}

- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s/%d",DEMSY_WEB_SERVER,DEMSY_URL_BBS_PLIST,pageIndex]];
    
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
