//
//  CoreTwoViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 5/20/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "SyncModel.h"
#import "User.h"


@interface CoreTwoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SyncModelProtocol>
{
    
}
@property (nonatomic,strong)NSMutableArray *addUser;
@property (nonatomic,strong)IBOutlet UITableView *coreTable;
@property (nonatomic,strong) User *selectedUser;
@property (nonatomic,strong) NSString *matches;

@end