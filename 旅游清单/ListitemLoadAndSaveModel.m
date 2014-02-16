//
//  ListitemLoadAndSaveModel.m
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import "ListitemLoadAndSaveModel.h"

@interface ListitemLoadAndSaveModel()
@property (nonatomic,strong)  NSMutableDictionary *listContent;

@property (strong, nonatomic) NSMutableArray *sectionIsAllShow;
@property (nonatomic,strong)  NSMutableArray *firstSectionArray;
@property (nonatomic,strong)  NSMutableArray *secondSectionArray;
@property (nonatomic,strong)  NSMutableArray *thirdSectionArray;

@property (nonatomic,strong) NSMutableArray *checkedSectionIsAllShow;
@property (nonatomic,strong)  NSMutableArray *checkedFirstSectionArray;
@property (nonatomic,strong)  NSMutableArray *checkedSecondSectionArray;
@property (nonatomic,strong)  NSMutableArray *checkedThirdSectionArray;

@property (nonatomic,strong) NSMutableArray *ignoredSectionIsAllShow;
@property (nonatomic,strong)  NSMutableArray *ignoredFirstSectionArray;
@property (nonatomic,strong)  NSMutableArray *ignoredSecondSectionArray;
@property (nonatomic,strong)  NSMutableArray *ignoredThirdSectionArray;

@property (nonatomic)  NSInteger currentSelectedSection;
@property (nonatomic)  NSInteger currentCheckedSelectSection;
@property (nonatomic)  NSInteger currentIgnoredSelectSection;
@end;


@implementation ListitemLoadAndSaveModel

static ListitemLoadAndSaveModel *shared;
+ (id)shared
{
    if (!shared) {
        shared = [[ListitemLoadAndSaveModel alloc] init];
    }
    return  shared;
}

-(void)toBackGroundSave
{
    NSMutableDictionary *unCheckedItemFirstSection = [NSMutableDictionary dictionary];
    [unCheckedItemFirstSection setValue:self.firstSectionArray forKey:UNCHECKED];
    NSMutableDictionary *CheckedItemFirsetSection = [NSMutableDictionary dictionary];
    [CheckedItemFirsetSection setValue:self.checkedFirstSectionArray forKey:CHECKED];
    NSMutableDictionary *ignoredItemFirstSection = [NSMutableDictionary dictionary];
    [ignoredItemFirstSection setValue:self.ignoredFirstSectionArray forKey:IGNORGE];
    
    NSArray *manyDaysBeforTravel = [NSArray arrayWithObjects:unCheckedItemFirstSection,CheckedItemFirsetSection,ignoredItemFirstSection, nil];
    
    
    NSMutableDictionary *unCheckedItemSecondeSection = [NSMutableDictionary dictionary];
    [unCheckedItemSecondeSection setObject:self.secondSectionArray forKey:UNCHECKED];
    NSMutableDictionary *checkedItemSecondSection = [NSMutableDictionary dictionary];
    [checkedItemSecondSection setValue:self.checkedSecondSectionArray forKey:CHECKED];
    NSMutableDictionary *ignoredItemSecondSection = [NSMutableDictionary dictionary];
    [ignoredItemSecondSection setValue:self.ignoredSecondSectionArray forKey:IGNORGE];
    
    NSArray *oneDayBeforeTravel = [NSArray arrayWithObjects:unCheckedItemSecondeSection,checkedItemSecondSection,ignoredItemSecondSection, nil];
    
    NSMutableDictionary *unCheckedItemThirdSection = [NSMutableDictionary dictionary];
    [unCheckedItemThirdSection setValue:self.thirdSectionArray forKey:UNCHECKED];
    NSMutableDictionary *checkItemThirdSection = [NSMutableDictionary dictionary];
    [checkItemThirdSection setValue:self.checkedThirdSectionArray forKey:CHECKED];
    NSMutableDictionary *ignoredItemThirdSecion = [NSMutableDictionary dictionary];
    [ignoredItemThirdSecion setValue:self.ignoredThirdSectionArray forKey:IGNORGE];
    
    NSArray *secondsBeforeTravel = [NSArray arrayWithObjects:unCheckedItemThirdSection,checkItemThirdSection,ignoredItemThirdSecion,  nil];
    
    
    NSMutableDictionary *totalDictionay = [NSMutableDictionary dictionary];
    [totalDictionay setValue:manyDaysBeforTravel forKey:FIRSTSECTION];
    [totalDictionay setValue:oneDayBeforeTravel forKey:SECONDSECTION];
    [totalDictionay setValue:secondsBeforeTravel forKey:THIRDSECTION];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *storePath = [NSString stringWithFormat:@"%@/travelCheck.plist",documentsDirectory];
    [totalDictionay writeToFile:storePath atomically:YES];
}

-(NSMutableDictionary *)listContent
{
    if (!_listContent) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *storePath = [NSString stringWithFormat:@"%@/travelCheck.plist",documentsDirectory];
        _listContent = [[NSMutableDictionary alloc] initWithContentsOfFile:storePath];
    }
   
    return _listContent;
}

-(NSInteger)numberOfSection
{
    return [[self.listContent allKeys] count];
}

-(NSInteger)numberofCountAtSection:(NSInteger)sectionNum
{
    NSInteger numberCount = 0;
    switch (sectionNum) {
        case 0:
        {
            numberCount = [[self.sectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.firstSectionArray count] : 0;
            break;
        }
        case 1:
        {
            numberCount = [[self.sectionIsAllShow objectAtIndex:sectionNum] boolValue]? [self.secondSectionArray count] : 0;
            break;
        }
        case 2:
        {
            numberCount = [[self.sectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.thirdSectionArray count]  : 0;
            break;
        }
        default:
            break;
    }
    return numberCount ;
}

-(NSInteger)numberofCountInCheckedTableviewAtSection:(NSInteger)sectionNum
{
    NSInteger numberCount = 0;
    switch (sectionNum) {
        case 0:
        {
            numberCount = [[self.checkedSectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.checkedFirstSectionArray count] : 0;
            break;
        }
        case 1:
        {
            numberCount = [[self.checkedSectionIsAllShow objectAtIndex:sectionNum] boolValue]? [self.checkedSecondSectionArray count] : 0;
            break;
        }
        case 2:
        {
            numberCount = [[self.checkedSectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.checkedThirdSectionArray count]  : 0;
            break;
        }
        default:
            break;
    }
    return numberCount ;
}


-(NSInteger)numberofCountInIgnoredTableViewAtSection:(NSInteger)sectionNum
{
    NSInteger numberCount = 0;
    switch (sectionNum) {
        case 0:
        {
            numberCount = [[self.ignoredSectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.ignoredFirstSectionArray count] : 0 ;
            break;
        }
        case 1:
        {
            numberCount = [[self.ignoredSectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.ignoredSecondSectionArray count] : 0;
            break;
        }
        case 2:
        {
            numberCount = [[self.ignoredSectionIsAllShow objectAtIndex:sectionNum] boolValue] ? [self.ignoredThirdSectionArray count] : 0;
            break;
        }
        default:
            break;
    }
    return  numberCount;
}

-(NSString *)cellTextAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum
{
    NSString * cellText;
    switch (sectionNum) {
        case 0:
        {
            cellText = [self.firstSectionArray objectAtIndex:index] ;
            break;
        }
        case 1:
        {
            cellText = [self.secondSectionArray objectAtIndex:index] ;
            break;
        }
        case 2:
        {
            cellText = [self.thirdSectionArray objectAtIndex:index ] ;
            break;
        }
        default:
            break;
    }
    return cellText ;
}

-(NSString *)cellTextInCheckedTableviewAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum
{
    NSString * cellText;
    switch (sectionNum) {
        case 0:
        {
            cellText = [self.checkedFirstSectionArray objectAtIndex:index] ;
            break;
        }
        case 1:
        {
            cellText = [self.checkedSecondSectionArray objectAtIndex:index] ;
            break;
        }
        case 2:
        {
            cellText = [self.checkedThirdSectionArray objectAtIndex:index ] ;
            break;
        }
        default:
            break;
    }
    return cellText ;
}

-(NSString *)cellTextInIgnoredTableViewAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum
{
    NSString *cellText;
    switch (sectionNum) {
        case 0:
        {
            cellText = [self.ignoredFirstSectionArray objectAtIndex:index];
            break;
        }
        case 1:
        {
            cellText = [self.ignoredSecondSectionArray objectAtIndex:index];
            break;
        }
        case 2:
        {
            cellText = [self.ignoredThirdSectionArray objectAtIndex:index];
            break;
        }
        default:
            break;
    }
    return cellText;
}

-(NSString *)sectionHeaderText:(NSUInteger)sectionNum inTableViewIndex:(tableViewType)tableViewIndex
{
    NSString *sectionHeaderText;
    switch (sectionNum) {
        case 0:
        {
            if (UNCHECKEDITEM == tableViewIndex) {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",FIRSTSECTION, [self.firstSectionArray count]];
            }
            else if (CHECKEDITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",FIRSTSECTION, [self.checkedFirstSectionArray count]];
            }
            else if(IGNORGEITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",FIRSTSECTION, [self.ignoredFirstSectionArray count]];
            }
            break;
        }
        case 1:
        {
            if (UNCHECKEDITEM == tableViewIndex) {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",SECONDSECTION, [self.secondSectionArray count]];
            }
            else if (CHECKEDITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",SECONDSECTION, [self.checkedSecondSectionArray count]];
            }
            else if(IGNORGEITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%u)",SECONDSECTION, [self.ignoredSecondSectionArray count]];
            }
            break;
        }
        case 2:
        {
            if (UNCHECKEDITEM == tableViewIndex) {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%d)",THIRDSECTION, [self.thirdSectionArray count]];
            }
            else if (CHECKEDITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%d)",THIRDSECTION, [self.checkedThirdSectionArray count]];
            }
            else if(IGNORGEITEM == tableViewIndex)
            {
                sectionHeaderText = [NSString stringWithFormat:@"%@  (%d)",THIRDSECTION, [self.ignoredThirdSectionArray count]];
            }
            break;
        }
        default:
        {
            break;
        }
    }
    return sectionHeaderText;
}

- (void)headerIsTapEvent:(NSInteger)sectionIndex
{
    if (sectionIndex != self.currentSelectedSection)
    {
        [self.sectionIsAllShow replaceObjectAtIndex:self.currentSelectedSection withObject:[NSNumber numberWithBool:NO]];
        self.currentSelectedSection = sectionIndex;

    }
    BOOL isShowCheck = [[self.sectionIsAllShow objectAtIndex:sectionIndex] boolValue];
    [self.sectionIsAllShow replaceObjectAtIndex:sectionIndex withObject:[NSNumber numberWithBool:!isShowCheck]];
}

- (void)headerIsTapEventInCheckedTableView:(NSInteger)sectionIndex
{
    if (sectionIndex != self.currentCheckedSelectSection)
    {
        [self.checkedSectionIsAllShow replaceObjectAtIndex:self.currentCheckedSelectSection withObject:[NSNumber numberWithBool:NO]];
        self.currentCheckedSelectSection = sectionIndex;
        
    }
    BOOL isShowCheck = [[self.checkedSectionIsAllShow objectAtIndex:sectionIndex] boolValue];
    [self.checkedSectionIsAllShow replaceObjectAtIndex:sectionIndex withObject:[NSNumber numberWithBool:!isShowCheck]];
}

- (void)headerIsTapEventInIgnoredTableView:(NSInteger)sectionIndex
{
    if (sectionIndex != self.currentIgnoredSelectSection) {
        [self.ignoredSectionIsAllShow replaceObjectAtIndex:self.currentIgnoredSelectSection withObject:[NSNumber numberWithBool:NO]];
        self.currentIgnoredSelectSection = sectionIndex;
    }
    BOOL isShowCheck = [[self.ignoredSectionIsAllShow objectAtIndex:sectionIndex] boolValue];
    [self.ignoredSectionIsAllShow replaceObjectAtIndex:sectionIndex withObject:[NSNumber numberWithBool:!isShowCheck]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteRowsAtIndexPaths:indexPath];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    NSIndexPath * headerIndexPath = [NSIndexPath indexPathForRow:NSNotFound inSection:indexPath.section];
//    [tableView reloadRowsAtIndexPaths:@[headerIndexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
}

- (void)deleteRowsAtIndexPaths:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self.checkedFirstSectionArray addObject:[self.firstSectionArray objectAtIndex:indexPath.row]];
            [self.firstSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            [self.checkedSecondSectionArray addObject:[self.secondSectionArray objectAtIndex:indexPath.row]];
            [self.secondSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            [self.checkedThirdSectionArray addObject:[self.thirdSectionArray objectAtIndex:indexPath.row]];
            [self.thirdSectionArray removeObjectAtIndex:indexPath.row];
        }
        default:
            break;
    }
}

- (void)ignoreRowsAtIndexPaths:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self.ignoredFirstSectionArray addObject:[self.firstSectionArray objectAtIndex:indexPath.row]];
            [self.firstSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            [self.ignoredSecondSectionArray addObject:[self.secondSectionArray objectAtIndex:indexPath.row]];
            [self.secondSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            [self.ignoredThirdSectionArray addObject:[self.thirdSectionArray objectAtIndex:indexPath.row]];
            [self.thirdSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
}

-(void)deleteRowsAtIndexPathsInCheckedTableView:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self.firstSectionArray addObject:[self.checkedFirstSectionArray objectAtIndex:indexPath.row]];
            [self.checkedFirstSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            [self.secondSectionArray addObject:[self.checkedSecondSectionArray objectAtIndex:indexPath.row]];
            [self.checkedSecondSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            [self.thirdSectionArray addObject:[self.checkedThirdSectionArray objectAtIndex:indexPath.row]];
            [self.checkedThirdSectionArray removeObjectAtIndex:indexPath.row];
        }
        default:
            break;
    }
}

-(void)deleteRowsAtIndexPathsInIgnoredTableView:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self.firstSectionArray addObject:[self.ignoredFirstSectionArray objectAtIndex:indexPath.row]];
            [self.ignoredFirstSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            [self.secondSectionArray addObject:[self.ignoredSecondSectionArray objectAtIndex:indexPath.row]];
            [self.ignoredSecondSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            [self.thirdSectionArray addObject:[self.ignoredThirdSectionArray objectAtIndex:indexPath.row]];
            [self.ignoredThirdSectionArray removeObjectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
}

-(void)removeIgnorItemsToUnCheckedItems
{
    [self.firstSectionArray addObjectsFromArray:self.ignoredFirstSectionArray];
    [self.ignoredFirstSectionArray removeAllObjects];
    
    [self.secondSectionArray addObjectsFromArray:self.ignoredSecondSectionArray];
    [self.ignoredSecondSectionArray removeAllObjects];
    
    [self.thirdSectionArray addObjectsFromArray:self.ignoredThirdSectionArray];
    [self.ignoredThirdSectionArray removeAllObjects];
}

-(void)removeCheckedItemsToUnChekedItems
{
    [self.firstSectionArray addObjectsFromArray:self.checkedFirstSectionArray];
    [self.checkedFirstSectionArray removeAllObjects];
    
    [self.secondSectionArray addObjectsFromArray:self.checkedSecondSectionArray];
    [self.checkedSecondSectionArray removeAllObjects];
    
    [self.thirdSectionArray addObjectsFromArray:self.checkedThirdSectionArray];
    [self.checkedThirdSectionArray removeAllObjects];
}
#pragma mark -getter of unchecked item
-(NSMutableArray *)sectionIsAllShow
{
    if (!_sectionIsAllShow) {
        _sectionIsAllShow = [NSMutableArray array];
        NSInteger sectionNum = [self numberOfSection];
        for (NSInteger i = 0; i < sectionNum; i ++) {
            [_sectionIsAllShow addObject:[NSNumber numberWithBool:NO]];
        }
    }
    return _sectionIsAllShow;
}

-(NSMutableArray *)firstSectionArray
{
    if (!_firstSectionArray) {
        NSDictionary *firstUncheckedDictionary = [[self.listContent objectForKey:FIRSTSECTION] objectAtIndex:0];
        _firstSectionArray = [firstUncheckedDictionary objectForKey:UNCHECKED];
    }
    return _firstSectionArray;
}

-(NSMutableArray *)secondSectionArray
{
    if (!_secondSectionArray) {
        NSDictionary *secondUncheckedDictionary = [[self.listContent objectForKey:SECONDSECTION] objectAtIndex:0];
        _secondSectionArray = [secondUncheckedDictionary objectForKey:UNCHECKED];
    }
    return _secondSectionArray;
}

-(NSMutableArray *)thirdSectionArray
{
    if (!_thirdSectionArray) {
        NSDictionary *thirdUncheckedDictionary = [[self.listContent objectForKey:THIRDSECTION] objectAtIndex:0];
        _thirdSectionArray = [thirdUncheckedDictionary objectForKey:UNCHECKED];
    }
    return _thirdSectionArray;
}

#pragma mark -getter of checked item
-(NSMutableArray *)checkedSectionIsAllShow
{
    if (!_checkedSectionIsAllShow) {
        _checkedSectionIsAllShow = [NSMutableArray array];
        NSInteger sectionNum = [self numberOfSection];
        for (NSInteger i = 0; i < sectionNum; i ++) {
            [_checkedSectionIsAllShow addObject:[NSNumber numberWithBool:NO]];
        }
    }
    return _checkedSectionIsAllShow;
}

-(NSMutableArray *)checkedFirstSectionArray
{
    if (!_checkedFirstSectionArray) {
        NSDictionary *firstCheckedDictionary = [[self.listContent objectForKey:FIRSTSECTION] objectAtIndex:1];
        _checkedFirstSectionArray = [firstCheckedDictionary objectForKey:CHECKED];
    }
    return _checkedFirstSectionArray;
}

-(NSMutableArray *)checkedSecondSectionArray
{
    if (!_checkedSecondSectionArray) {
        NSDictionary *secondCheckedDictionary = [[self.listContent objectForKey:SECONDSECTION] objectAtIndex:1];
        _checkedSecondSectionArray = [secondCheckedDictionary objectForKey:CHECKED];
    }
    return _checkedSecondSectionArray;
}

-(NSMutableArray *)checkedThirdSectionArray
{
    if (!_checkedThirdSectionArray) {
        NSDictionary *thirdCheckedDictionary = [[self.listContent objectForKey:THIRDSECTION] objectAtIndex:1];
        _checkedThirdSectionArray = [thirdCheckedDictionary objectForKey:CHECKED];
    }
    return _checkedThirdSectionArray;
}

//#pragma mark -getter of ignored item
-(NSMutableArray *)ignoredSectionIsAllShow
{
    if (!_ignoredSectionIsAllShow) {
        _ignoredSectionIsAllShow = [NSMutableArray array];
        NSInteger sectionNum = [self numberOfSection];
        for (NSInteger i = 0; i < sectionNum; i ++) {
            [_ignoredSectionIsAllShow addObject:[NSNumber numberWithBool:NO]];
        }
    }
    return _ignoredSectionIsAllShow;
}

-(NSMutableArray *)ignoredFirstSectionArray
{
    if (!_ignoredFirstSectionArray) {
        NSDictionary *ignoredFirstDiationary = [[self.listContent objectForKey:FIRSTSECTION] objectAtIndex:2];
        _ignoredFirstSectionArray = [ignoredFirstDiationary objectForKey:IGNORGE];
    }
    return _ignoredFirstSectionArray;
}

-(NSMutableArray *)ignoredSecondSectionArray
{
    if (!_ignoredSecondSectionArray) {
        NSDictionary *ignoredSecondDiationary = [[self.listContent objectForKey:SECONDSECTION] objectAtIndex:2];
        _ignoredSecondSectionArray = [ignoredSecondDiationary objectForKey:IGNORGE];

    }
    return _ignoredSecondSectionArray;
}

-(NSMutableArray *)ignoredThirdSectionArray
{
    if (!_ignoredThirdSectionArray) {
        NSDictionary *ignoredThirdSecontionDictionary = [[self.listContent objectForKey:THIRDSECTION] objectAtIndex:2];
        _ignoredThirdSectionArray = [ignoredThirdSecontionDictionary objectForKey:IGNORGE];
    }
    return _ignoredThirdSectionArray;
}
@end
