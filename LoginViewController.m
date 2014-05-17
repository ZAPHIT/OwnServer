//
//  LoginViewController.m
//  OwnServer
//
//  Created by Joey Serquina on 4/23/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "JSONDictionaryExtensions.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(UIButton *)sender {

  
 
    

    
    
    // loading.hidden = NO;
    NSString *userHolder = _verifyUsername.text;
    NSString *passwordHolder = _verifyPassword.text;
//    
//    
//    NSString *rawStr =[NSString stringWithFormat:@"username=%@&password=%@&",userHolder,passwordHolder];
//    
//    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:@"http://zamperla.ph/testfolder/login.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:data];
//    NSURLResponse *response;
//    NSError *err;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
//
//    
//    NSLog(@"%@",responseString);
//    
//    NSString *success =@"success";
//    
//    [success dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    NSLog(@"%lu",(unsigned long)responseString.length);
//    NSLog(@"%lu",(unsigned long)success.length);
//    NSLog(@"%@",responseData);
//    
//
//   
//    alert =[[UIAlertView alloc]initWithTitle:nil message:@"submitting. . . " delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    
//    [alert show];
//    [self performSelector:@selector(stopActivity) withObject:self afterDelay:2.0];
//    
    
    
//    ServiceConnector *serviceConnector = [[ServiceConnector alloc]init];
//    serviceConnector.delegate =self;
//    [serviceConnector getTest];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @try {
        
        if([_verifyUsername.text isEqualToString:@""] || [_verifyPassword.text isEqualToString:@""])
            {
            
                UIAlertView *statusAlert = [[UIAlertView alloc]initWithTitle:@"Please enter both username and password" message:@"Login Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [statusAlert show];
            }
        
           else {
              NSString *post =[NSString stringWithFormat:@"username=%@&password=%@&",userHolder,passwordHolder];

            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://zamperla.ph/testfolder/login.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"%ld",(long)success);
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    
                    UIAlertView *loginstatus = [[UIAlertView alloc]initWithTitle:@"Login Status" message:@"Login Success" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                        [loginstatus show];
                    
                    
                    [self performSelector:@selector(stopActivity) withObject:self afterDelay:1.0];
                    [loginstatus dismissWithClickedButtonIndex:0 animated:YES];
   
                } else {
                    
                 
                    
                    UIAlertView *errMessage = [[UIAlertView alloc]initWithTitle:@"Error Message" message:@"Wrong Username and Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [errMessage show];
                
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                UIAlertView *errMessage = [[UIAlertView alloc]initWithTitle:@"Error Message" message:@"Wrong Username and Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [errMessage show];
                
  
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        
        UIAlertView *errMessage = [[UIAlertView alloc]initWithTitle:@"Error Message" message:@"Wrong Username and Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errMessage show];

    }
    
}

-(void)stopActivity
{
    // [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *complete =[[UIAlertView alloc]initWithTitle:nil message:@"Completed" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [complete show];
    [complete dismissWithClickedButtonIndex:0 animated:YES];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    ViewController *firstView =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self.navigationController pushViewController:firstView animated:YES];
    
}



#pragma mark - ServiceConnectorDelegate -

-(void)requestReturnedData:(NSData *)data{ //activated when data is returned
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithJSONData:data];
    output = dictionary.JSONString; // set the textview to the raw string value of the data recieved
    
    verifyLogin = [NSString stringWithFormat:@"%d",[[dictionary objectForKey:@"value1"] intValue]];

    NSLog(@"%@",dictionary);
    NSLog(@"%@",output);
    NSLog(@"%@",verifyLogin);
    
}
@end
