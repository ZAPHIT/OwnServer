//
//  HomeModel.m
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "HomeModel.h"
#import "Location.h"

@interface HomeModel (){
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

-(void)downloadItems{
    //download the json file
    NSURL *jsonFileUrl =[NSURL URLWithString:@"http://zamperla.ph/ZamperlaApp/services.php"];
    
    //Create the request
    NSURLRequest *urlRequest =[[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    //create the NSURLConnection
    
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}
#pragma mark NSURLConnectionDataProtocol Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//initialize the data object
    _downloadedData =[[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //append the newly downloaded data
    [_downloadedData appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //create an array to store the locations
    NSMutableArray *_locations =[[NSMutableArray alloc]init];
    //parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    //Loop through Json Obejcts, create question objects and add them to our question array
    
    for (int i = 0; i<jsonArray.count; i++) {
        NSDictionary *jsonElement = jsonArray[i];
        //Create a new location object and set its props to JsonElement properties
        Location *newLocation =[[Location alloc]init];
        newLocation.name =jsonElement[@"Name"];
        newLocation.address =jsonElement[@"Address"];
        newLocation.latitude =jsonElement[@"Latitude"];
        newLocation.longitude =jsonElement[@"Longitude"];
        
        //Add this question to the locations array
        [_locations addObject:newLocation];
    }
    //Ready to notify delegate that data is ready and pass back items
    
    if (self.delegate) {
        [self.delegate itemsDownloaded:_locations];
    }
    
    
}







@end
