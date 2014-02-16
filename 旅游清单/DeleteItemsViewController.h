//
//  DeleteItemsViewController.h
//  旅游清单
//
//  Created by it on 14-1-17.
//  Copyright (c) 2014年 it. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListitemLoadAndSaveModel.h"
#import "SWTableViewCell.h"

@interface DeleteItemsViewController : UITableViewController<SWTableViewCellDelegate,UIAlertViewDelegate>

@property (strong ,nonatomic)ListitemLoadAndSaveModel *listItemModel;
@end
