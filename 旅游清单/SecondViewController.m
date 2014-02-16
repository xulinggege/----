//
//  SecondViewController.m
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITabBarControllerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.2 blue:0.9 alpha:1]];
    [self.listItemCheckedTableview setBackgroundColor:[UIColor colorWithRed:0.5 green:0.2 blue:0.9 alpha:1]];
    
    UILabel *tableViewHearder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [tableViewHearder setBackgroundColor:[UIColor colorWithRed:0.3 green:0.8 blue:0.4 alpha:0.5]];
    tableViewHearder.textColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.8];
    tableViewHearder.textAlignment = NSTextAlignmentCenter;
    tableViewHearder.text = @"已确认事宜";
    [self.listItemCheckedTableview setTableHeaderView:tableViewHearder];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.listItemCheckedTableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ListitemLoadAndSaveModel *)listItemModel
{
    if (!_listItemModel) {
        _listItemModel = [ListitemLoadAndSaveModel shared];
    }
    return _listItemModel;
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listItemModel numberOfSection] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listItemModel numberofCountInCheckedTableviewAtSection:section];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.5f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"恢复"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:_listItemCheckedTableview // Used for row height and selection
                                   leftUtilityButtons:rightUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
        
    }
    cell.textLabel.text = [self.listItemModel cellTextInCheckedTableviewAtIndex:indexPath.row InSectionNumber:indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIControl *result = nil;
//    
//    result = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44.0f)];
//    
//    if(section < [self.listItemModel numberOfSection])
//    {
//        UILabel *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] ;
//        viewHeader.text = [self.listItemModel sectionHeaderText:section inTableViewIndex:CHECKEDITEM];
//        viewHeader.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.8 alpha:1];
//        viewHeader.textColor = [UIColor yellowColor];
//        [result addSubview:viewHeader];
//        result.tag = section;
//        [result addTarget:self action:@selector(headerIsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    else
//    {
//        UILabel *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] ;
//        viewHeader.text = @"全部恢复为待确认";
//        viewHeader.textAlignment = NSTextAlignmentCenter;
//        viewHeader.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
//        viewHeader.textColor = [UIColor yellowColor];
//        [result addSubview:viewHeader];
//        result.tag = section;
//        [result addTarget:self action:@selector(reuseAllItem:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return result;
    
    static NSString *HeaderIdentifier = @"header";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    headerView.tag = section;
    headerView.textLabel.textColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewPressed:)];
    [headerView addGestureRecognizer:tapGestureRecognizer];
    
    if (section < [self.listItemModel numberOfSection]) {
        [headerView.textLabel setText:[self.listItemModel sectionHeaderText:section inTableViewIndex:CHECKEDITEM]];
        headerView.contentView.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.8 alpha:1];

    }
    else
    {
        UILabel *viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] ;
        viewLabel.text = @"全部恢复为待确认";
        viewLabel.textAlignment = NSTextAlignmentCenter;
        viewLabel.textColor = [UIColor yellowColor];
        [headerView.contentView addSubview:viewLabel];
        headerView.contentView.backgroundColor = [UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:1];
    }
   
    return headerView;
    
}

- (void)headerViewPressed:(id)sender {
    UITableViewHeaderFooterView * headerView = (UITableViewHeaderFooterView *)[sender view];
    NSInteger sectionIndex = [headerView tag];
    if (sectionIndex < [self.listItemModel numberOfSection]) {
        [self.listItemModel headerIsTapEventInCheckedTableView:sectionIndex];
//        [self.listItemCheckedTableview reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.listItemCheckedTableview reloadData];
    }
    else
    {
        [self reuseAllItem:sender];
    }
    
}

- (void)headerIsTapEvent:(id)sender
{
    NSInteger sectionIndex = [sender tag];
    [self.listItemModel headerIsTapEventInCheckedTableView:sectionIndex];
    [self.listItemCheckedTableview reloadData];
}

- (void)reuseAllItem:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"确认恢复所有为待确认项"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: @"取消",nil];
    alert.tag = 0;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == alertView.tag) {
        if (0 == buttonIndex) {
            [self.listItemModel removeCheckedItemsToUnChekedItems];
            [self.listItemCheckedTableview reloadData];
        }
    }
}

#pragma mark -SWTableViewCellDelegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.listItemCheckedTableview indexPathForCell:cell];
            
            
            [self.listItemModel deleteRowsAtIndexPathsInCheckedTableView:cellIndexPath];
            [self.listItemCheckedTableview deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            UITableViewHeaderFooterView *headerView = [self.listItemCheckedTableview headerViewForSection:cellIndexPath.section];
            headerView.textLabel.text = [self.listItemModel sectionHeaderText:cellIndexPath.section inTableViewIndex:CHECKEDITEM];
            //[self.listItemCheckedTableview reloadSections:[NSIndexSet indexSetWithIndex:cellIndexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
}

@end
