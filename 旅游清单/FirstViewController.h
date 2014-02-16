//
//  FirstViewController.h
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListitemLoadAndSaveModel.h"
#import "SWTableViewCell.h"
@interface FirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>

@property (strong ,nonatomic)ListitemLoadAndSaveModel *listItemModel;
@property (strong, nonatomic) IBOutlet UITableView *itemsNeedCheckTableview;

@end
