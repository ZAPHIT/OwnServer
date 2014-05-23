//
//  CoreTwoViewController.m
//  OwnServer
//
//  Created by Joey Serquina on 5/20/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "CoreTwoViewController.h"
#import "AppDelegate.h"
#import "UserData.h"
#import <CoreData/CoreData.h>
#import "UserCell.h"
#import "User.h"


@interface CoreTwoViewController ()
{
    SyncModel *_homeModel;
    NSArray *_feedItems;
    User *_selectedUser;
}

@property (strong, nonatomic)NSMutableArray *__firstname;

@end

@implementation CoreTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ___firstname = [[NSMutableArray alloc]init];
    
    //create array object and assign it to _feedItems variable
    _feedItems =[[NSArray alloc]init];
    
    //Create new homemodel object and assign it to _homeModel variable
    _homeModel =[[SyncModel alloc]init];
    
    //Set this view controller object as the delegate for the home model object
    _homeModel.delegate =self;
    
    //Call the download items method of the home model object
    [_homeModel downloadItems];
    
    
    
    NSLog(@"%lu",(unsigned long)[_feedItems count ]);
    
    _addUser =[[NSMutableArray alloc]init];
    
    
    [self refreshTableView];
    
        
        
    }
    
-(void)itemsDownloaded:(NSArray *)items{
    //This delegate method will get called when the items are finished downloading
    //Set the downloaded items to the array
    _feedItems =items;
    
    //Reload the table view
   // [self.coreTable reloadData];
}


-(void)refreshTableView{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"UserData" inManagedObjectContext:appDelegate.managedObjectContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstname" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    
    NSArray *objects = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    
    
    if ( objects == nil) {
        NSLog(@"No matches");
    }
    else {
        
        if (objects.count >0) {
            [_addUser addObjectsFromArray:objects];
            NSLog(@"%lu",(unsigned long)[objects count]);
            NSLog(@" feed items  %lu",(unsigned long)[_feedItems count]);
            
            [self.coreTable reloadData];
            
        }

        
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)add:(UIBarButtonItem *)sender {
    
    
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    UserData *newUserData  =[NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:appDelegate.managedObjectContext];
    
    User *items;
    
    
    if (_feedItems > 0)
            {

    //newUserData.firstname = @"zamperla";
    //newUserData.lastname =@"zamperla";
                
                for (int i = 0; i < [_feedItems count]; i++) {
                    items = _feedItems[i];
                    
                    
                    NSLog(@"%@", items.firstname);
                    [___firstname addObject:[items valueForKeyPath:@"firstname"]];
                    NSLog(@" __firsntame %@",___firstname);
//                    newUserData.firstname = items.firstname;
//                    newUserData.lastname = items.firstname;
                }
                
                
//                for (int x = 0;  x < [___firstname count]; x++) {
//                    _matches = ___firstname[x];
//                    newUserData.firstname = _matches;
//                    NSLog(@" matches %@",_matches);
//                }
    
    [appDelegate saveContext];
    [_addUser removeAllObjects];
    [self   refreshTableView];
    
            }
    
    else    {
        
        NSLog(@"No data from web");
            }


}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.coreTable reloadData];
}


#pragma mark Table View Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the number feed items (initially 0)
    return [_addUser count];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Retrieve Cell
    NSString *cellIdentifier =@"coreCELL";
    UserCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UserData *newUserData = _addUser [indexPath.row];
    myCell.myfirstname.text = newUserData.firstname;
    myCell.mylastname.text = newUserData.lastname;
    
    
    return myCell;
    
}


@end
