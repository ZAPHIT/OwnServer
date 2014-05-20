//
//  SyncModel.m
//  OwnServer
//
//  Created by Joey Serquina on 5/16/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "SyncModel.h"
#import "User.h"


@interface SyncModel (){
    NSMutableData *_downloadedData;
}
@end


@implementation SyncModel



-(void)downloadItems{
    //download the json file
    NSURL *jsonFileUrl =[NSURL URLWithString:@"http://zamperla.ph/ZamperlaApp/User.php"];
    
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
        User *newUser =[[User alloc]init];
        newUser.firstname =jsonElement[@"firstname"];
        newUser.lastname =jsonElement[@"lastname"];
        newUser.username =jsonElement[@"username"];
        newUser.emailAddress =jsonElement[@"emailAddress"];
        newUser.password =jsonElement[@"password"];
        
        //Add this question to the locations array
        [_locations addObject:newUser];
    }
    //Ready to notify delegate that data is ready and pass back items
    
    if (self.delegate) {
        [self.delegate itemsDownloaded:_locations];
    }
    
    
}

@end
