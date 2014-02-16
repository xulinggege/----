//
//  SecondViewController.h
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListitemLoadAndSaveModel.h"
#import "SWTableViewCell.h"

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *listItemCheckedTableview;
//@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarItem;
@property (strong ,nonatomic)ListitemLoadAndSaveModel *listItemModel;

@end
