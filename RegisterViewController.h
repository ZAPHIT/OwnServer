//
//  RegisterViewController.h
//  OwnServer
//
//  Created by Joey Serquina on 4/23/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"



@interface RegisterViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>{
    NSString *fnameHolder;
    NSString *lnameHolder;
    NSString *usernameHolder;
    NSString *emailHolder;
    NSString *passwordHolder;
    NSString *confirmHolder;
    UIAlertView *alert;
    
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
}


@property (weak,nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UITextField *fnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
- (IBAction)submitButton:(UIButton *)sender;
- (IBAction)reg:(UIButton *)sender;

-(void)checkpasswordMatch;
-(void)registerNewUser;
-(void)checkFieldComplete;
@end
