//
//  ServiceConnector.m
//  Service Reader
//
//  Created by Divan Visagie on 2012/08/25.
//  Copyright (c) 2012 Divan Visagie. All rights reserved.
//

#import "ServiceConnector.h"
#import "JSONDictionaryExtensions.h"

@implementation ServiceConnector{
    NSData *receivedData;;
}


-(void)getTest{
    
    //build up the request that is to be sent to the server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://zamperla.ph/testfolder/postGet.php"]];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"getValues" forHTTPHeaderField:@"METHOD"]; //selects what task the server will perform
    
    //initialize an NSURLConnection  with the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
}

-(void)postTest{
    
    //build up the request that is to be sent to the server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://zamperla.ph/testfolder/postGet.php"]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
   
    //create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@2 forKey:@"value1"];
    [dictionary setValue:@"This was sent from ios to server" forKey:@"value2"];
    
    //serialize the dictionary data as json
    NSData *data = [[dictionary copy] JSONValue];
    
    [request setHTTPBody:data]; //set the data as the post body
    [request addValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }

}


#pragma mark - Data connection delegate -

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{ // executed when the connection receives data
    
    receivedData = data;
    /* NOTE: if you are working with large data , it may be better to set recievedData as NSMutableData 
             and use  [receivedData append:Data] here, in this event you should also set recievedData to nil
             when you are done working with it or any new data received could end up just appending to the 
             last message received*/
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{ //executed when the connection fails
    
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
    /*This message is sent when there is an authentication challenge ,our server does not have this requirement so we do not need to handle that here*/
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"Request Complete,recieved %lu bytes of data",(unsigned long)receivedData.length);
    
    [self.delegate requestReturnedData:receivedData];//send the data to the delegate
}

@end
