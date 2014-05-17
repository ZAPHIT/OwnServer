//
//  DetailViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) Location *selectedLocation;
@end
