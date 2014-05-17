//
//  DetailViewController.m
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    //Create coordinates from location lat/long
    CLLocationCoordinate2D poiCoordinates;
    poiCoordinates.latitude =[self.selectedLocation.latitude doubleValue];
    poiCoordinates.longitude =[self.selectedLocation.longitude doubleValue];
    
    //ZOOM to region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoordinates, 100, 100);
    [self.mapView setRegion:viewRegion animated:YES];
    
    //Plot pin
    MKPointAnnotation *pin =[[MKPointAnnotation alloc]init];
    pin.coordinate =poiCoordinates;
    [self.mapView addAnnotation:pin];
    
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

@end
