//
//  CoreViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 5/20/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyncModel.h"
#import "User.h"
#import "AppDelegate.h"
#import "UsersViewController.h"



@interface CoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, SyncModelProtocol>

@property (weak, nonatomic) IBOutlet UITableView *coreTable;
@property (nonatomic,strong) User *selectedUser;
@end
