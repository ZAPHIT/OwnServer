//
//  ViewController.m
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"
#import "DetailViewController.h"

@interface ViewController ()
{
    HomeModel *_homeModel;
    NSArray *_feedItems;
    Location *_selectedLocation;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Set this view controller object as the delegate and data source for the table view
    
    self.myTable.delegate =self;
    self.myTable.dataSource =self;
    
    //create array object and assign it to _feedItems variable
    _feedItems =[[NSArray alloc]init];
    
    //Create new homemodel object and assign it to _homeModel variable
    _homeModel =[[HomeModel alloc]init];
    
    //Set this view controller object as the delegate for the home model object
    _homeModel.delegate =self;
    
    //Call the download items method of the home model object
    [_homeModel downloadItems];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)itemsDownloaded:(NSArray *)items{
    //This delegate method will get called when the items are finished downloading
    //Set the downloaded items to the array
    _feedItems =items;
    
    //Reload the table view
    [self.myTable reloadData];
}
#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the number feed items (initially 0)
    return _feedItems.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Retrieve Cell
    NSString *cellIdentifier =@"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Get the location to be shown
    Location *items =_feedItems[indexPath.row];
    
    //Get the references to labels of cell
    myCell.textLabel.text =items.address;
    
    return myCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Set selected location to var
    _selectedLocation =_feedItems[indexPath.row];
    
    //Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Get reference to the destination view controller
    DetailViewController *detailVC =segue.destinationViewController;
    //Set the property to the selected location so when the view for
    //detail view controller loads, it can qaccess that property to get the feeditem obj
    detailVC.selectedLocation = _selectedLocation;
}
@end
