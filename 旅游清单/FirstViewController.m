//
//  FirstViewController.m
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.listItemModel setListFileName:@"travelCheck"];
	// Do any additional setup after loading the view, typically from a nib.
    //self.itemsNeedCheckTableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    //self.itemsNeedCheckTableview.tableHeaderView.backgroundColor = [UIColor colorWithRed:0.8 green:0.7 blue:0.6 alpha:0.5];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8 green:0.7 blue:0.6 alpha:1]];
    [self.itemsNeedCheckTableview setBackgroundColor:[UIColor colorWithRed:0.8 green:0.7 blue:0.6 alpha:1]];
    
    UILabel *tableViewHearder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [tableViewHearder setBackgroundColor:[UIColor colorWithRed:0.3 green:0.8 blue:0.4 alpha:0.5]];
    tableViewHearder.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
    tableViewHearder.textAlignment = NSTextAlignmentCenter;
    tableViewHearder.text = @"待确认事宜";
    [self.itemsNeedCheckTableview setTableHeaderView:tableViewHearder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.itemsNeedCheckTableview reloadData];
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
    return [self.listItemModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.listItemModel numberofCountAtSection:section];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];

        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"忽略"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:_itemsNeedCheckTableview // Used for row height and selection
                                   leftUtilityButtons:nil
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
        
    }
    cell.textLabel.text = [self.listItemModel cellTextAtIndex:indexPath.row InSectionNumber:indexPath.section];
    return cell;
    
    // Configure the cell...
    
}
#pragma  mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.listItemModel tableView:tableView didSelectRowAtIndexPath:indexPath];
    UITableViewHeaderFooterView *headerSection = [tableView headerViewForSection:indexPath.section];
    headerSection.textLabel.text = [self.listItemModel sectionHeaderText:indexPath.section inTableViewIndex:UNCHECKEDITEM];
//    UIView *headerView = [tableView headerViewForSection:indexPath.row];
//    UILabel *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    viewHeader.text = [self.listItemModel sectionHeaderText:indexPath.section inTableViewIndex:UNCHECKEDITEM];
//    [headerView addSubview:viewHeader];
    //[tableView]
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}


//- (UIView *)tableView:
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIControl *result = nil;
//    
//    result = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44.0f)];
//    
//    UILabel *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] ;
//    
//    viewHeader.tag = section + 1;
//    
//    viewHeader.text = [self.listItemModel sectionHeaderText:section inTableViewIndex:UNCHECKEDITEM];
//    viewHeader.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1];
//    viewHeader.textColor = [UIColor yellowColor];
//    [result addSubview:viewHeader];
//    result.tag = section;
//    [result addTarget:self action:@selector(headerIsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
//    return result;
    
    static NSString *HeaderIdentifier = @"header";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    headerView.tag = section;
    [headerView.textLabel setText:[self.listItemModel sectionHeaderText:section inTableViewIndex:UNCHECKEDITEM]];
    headerView.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1];
    headerView.textLabel.textColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewPressed:)];
    
    [headerView addGestureRecognizer:tapGestureRecognizer];
    
    return headerView;
}

- (void)headerViewPressed:(id)sender {
    UITableViewHeaderFooterView * headerView = (UITableViewHeaderFooterView *)[sender view];
    NSInteger sectionIndex = [headerView tag];
    [self.listItemModel headerIsTapEvent:sectionIndex];
//    [self.itemsNeedCheckTableview reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.itemsNeedCheckTableview reloadData];
}

- (void)headerIsTapEvent:(id)sender
{
    NSInteger sectionIndex = [sender tag];
    [self.listItemModel headerIsTapEvent:sectionIndex];
    [self.itemsNeedCheckTableview reloadData];
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
            NSIndexPath *cellIndexPath = [self.itemsNeedCheckTableview indexPathForCell:cell];
            [self.listItemModel ignoreRowsAtIndexPaths:cellIndexPath];
           
            [self.itemsNeedCheckTableview deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
           
            UITableViewHeaderFooterView *headerSection = [self.itemsNeedCheckTableview headerViewForSection:cellIndexPath.section];
            headerSection.textLabel.text = [self.listItemModel sectionHeaderText:cellIndexPath.section inTableViewIndex:UNCHECKEDITEM];

            //[self.itemsNeedCheckTableview reloadSections:[NSIndexSet indexSetWithIndex:cellIndexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
}

#pragma mark -UIAppearance
//+ (instancetype)appearance
//{
//   [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setBackgroundColor:[UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1]];
//}
//
//+ (instancetype)appearanceWhenContainedIn:(Class <UIAppearanceContainer>)ContainerClass,...
//{
//    
//}
@end
