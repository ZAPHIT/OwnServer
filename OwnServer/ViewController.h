//
//  ViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, HomeModelProtocol>

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@end
