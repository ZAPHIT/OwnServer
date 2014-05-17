//
//  LoginViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 4/23/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnector.h"
#import "SBJson.h"

@interface LoginViewController : UIViewController<UIAlertViewDelegate,ServiceConnectorDelegate>{
    UIAlertView *alert;
    NSString *verifyLogin;
    NSString *output;

}
@property (weak, nonatomic) IBOutlet UITextField *verifyUsername;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassword;

- (IBAction)loginButton:(UIButton *)sender;

@end
