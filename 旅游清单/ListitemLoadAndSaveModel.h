//
//  ListitemLoadAndSaveModel.h
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kAppInfoFileType @"plist"

#define FIRSTSECTION @"出行前准备"
#define SECONDSECTION @"出行前一天"
#define THIRDSECTION @"出行前一刻"

#define UNCHECKED @"unchecked"
#define CHECKED @"cheched"
#define IGNORGE @"ignore"
typedef  enum
{
    UNCHECKEDITEM,
    CHECKEDITEM,
    IGNORGEITEM,
}tableViewType;

@interface ListitemLoadAndSaveModel : NSObject


//@property (strong, nonatomic)NSString *listFileName;

-(void)toBackGroundSave;

-(NSInteger) numberOfSection;

-(NSInteger)numberofCountAtSection:(NSInteger)sectionNum;
-(NSString *)cellTextAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum;

-(NSString *)cellTextInCheckedTableviewAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum;
-(NSInteger)numberofCountInCheckedTableviewAtSection:(NSInteger)sectionNum;

-(NSInteger)numberofCountInIgnoredTableViewAtSection:(NSInteger)sectionNum;
-(NSString *)cellTextInIgnoredTableViewAtIndex:(NSUInteger)index InSectionNumber:(NSUInteger)sectionNum;

-(NSString *)sectionHeaderText:(NSUInteger)sectionNum inTableViewIndex:(tableViewType)tableViewIndex;



+ (id)shared;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)headerIsTapEvent:(NSInteger)sectionIndex;
- (void)deleteRowsAtIndexPaths:(NSIndexPath *)indexPath;
- (void)ignoreRowsAtIndexPaths:(NSIndexPath *)indexPath;

- (void)headerIsTapEventInCheckedTableView:(NSInteger)sectionIndex;
- (void)deleteRowsAtIndexPathsInCheckedTableView:(NSIndexPath *)indexPath;

- (void)headerIsTapEventInIgnoredTableView:(NSInteger)sectionIndex;
-(void)deleteRowsAtIndexPathsInIgnoredTableView:(NSIndexPath *)indexPath;

-(void)removeIgnorItemsToUnCheckedItems;
-(void)removeCheckedItemsToUnChekedItems;
@end
