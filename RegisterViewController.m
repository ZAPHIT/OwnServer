
//
//  RegisterViewController.m
//  OwnServer
//
//  Created by Joey Serquina on 4/23/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    

    _fnameTextField.returnKeyType =UIReturnKeyDone;
    [self.fnameTextField setDelegate:self];
    
    _lnameTextField.returnKeyType =UIReturnKeyDone;
    [self.lnameTextField setDelegate:self];
    
    _usernameTextField.returnKeyType =UIReturnKeyDone;
    [self.usernameTextField setDelegate:self];
    
    _emailTextField.returnKeyType =UIReturnKeyDone;
    [self.emailTextField setDelegate:self];
    
    _passwordTextField.returnKeyType =UIReturnKeyDone;
    [self.passwordTextField setDelegate:self];
    
    _confirmTextField.returnKeyType =UIReturnKeyDone;
    [self.confirmTextField setDelegate:self];
    

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





- (IBAction)submitButton:(UIButton *)sender {



    [self checkFieldComplete];

}

- (IBAction)reg:(UIButton *)sender {
    
    alert =[[UIAlertView alloc]initWithTitle:nil message:@"submitting. . . " delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alert show];
    [self performSelector:@selector(stopActivity) withObject:self afterDelay:2.0];
    
    
    
    // loading.hidden = NO;
    fnameHolder = _fnameTextField.text;
    lnameHolder = _lnameTextField.text;
    usernameHolder = _usernameTextField.text;
    emailHolder = _emailTextField.text;
    passwordHolder = _passwordTextField.text;
    confirmHolder = _confirmTextField.text;
    
    NSString *rawStr =[NSString stringWithFormat:@"firstname=%@&lastname=%@&",fnameHolder,lnameHolder];
    
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://zamperla.ph/testfolder/savedata2.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
    
    NSLog(@"%@",responseString);
    
    NSString *success =@"success";
    
    [success dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSLog(@"%lu",(unsigned long)responseString.length);
    NSLog(@"%lu",(unsigned long)success.length);
    
    
}





-(void)stopActivity
{
   // [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *complete =[[UIAlertView alloc]initWithTitle:nil message:@"Completed" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [complete show];
    [complete dismissWithClickedButtonIndex:0 animated:YES];
    [alert dismissWithClickedButtonIndex:0 animated:YES];

    
    LoginViewController *firstView =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.navigationController pushViewController:firstView animated:YES];

}


-(void)checkpasswordMatch{
    if (![_passwordTextField.text isEqualToString:_confirmTextField.text]) {
        UIAlertView *checkPassword = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [checkPassword show];
    }
    else {
        [self registerNewUser];
    }
    
}

-(void)checkFieldComplete{
    if ([_usernameTextField.text isEqualToString:@""] ||[_passwordTextField.text isEqualToString:@""] || [_emailTextField.text isEqualToString:@""] || [_usernameTextField.text isEqualToString:@""] || [_lnameTextField.text isEqualToString:@""] || [_fnameTextField.text isEqualToString:@""] ) {
        UIAlertView *checkAllFields =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [checkAllFields show];}
    else {
        [self checkpasswordMatch];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
    NSLog(@"textfield frame size "  @"%@",[NSValue valueWithCGRect:_activeField.frame]);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (void) shiftViewDownAfterKeyboard;
{
    if (viewShiftedForKeyboard)
    {
        [UIView beginAnimations: @"ShiftUp" context: nil];
        [UIView setAnimationDuration: keyboardSlideDuration];
        self.view.center = CGPointMake( self.view.center.x, self.view.center.y + keyboardShiftAmount);
        
        [UIView commitAnimations];
        viewShiftedForKeyboard = FALSE;
    }
}


- (void) shiftViewUpForKeyboard: (NSNotification*) theNotification;
{
    CGRect keyboardFrame;
    NSDictionary* userInfo = theNotification.userInfo;
    keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if UIInterfaceOrientationIsLandscape(theStatusBarOrientation)
        keyboardShiftAmount = keyboardFrame.size.width;
    else
        keyboardShiftAmount = keyboardFrame.size.height;
    
    [UIView beginAnimations: @"ShiftUp" context: nil];
    [UIView setAnimationDuration: keyboardSlideDuration];
    
    
    CGRect aRect = self.view.frame;
    NSLog(@"Screen Size" @"%f",aRect.size.height);
    
    //determine the textfield y coordinate
    float new_float = _activeField.frame.origin.y;
    //keyboard frame height
    float stone = 216.00;
    //determine the textfield y coordinate - keyboard height
    new_float =new_float -stone;
    NSLog(@"distance of keyboard" @"%f",new_float);
    
    
    //If textfield is hidden it shift up
    if (new_float >=70)
    {
        keyboardShiftAmount =216.000000;
    }
    
    else{
        keyboardShiftAmount = 0.000000;
    }
    self.view.center = CGPointMake( self.view.center.x, self.view.center.y - keyboardShiftAmount);
    [UIView commitAnimations];
    NSLog(@"KEYBOARD SHIFT AMOUNT " @"%f",keyboardShiftAmount);
    viewShiftedForKeyboard = TRUE;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewUpForKeyboard:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewDownAfterKeyboard)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.fnameTextField || theTextField == self.lnameTextField || theTextField == self.usernameTextField || theTextField == self.emailTextField || theTextField == self.passwordTextField || theTextField == self.confirmTextField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}


-(void)registerNewUser{
    
    alert =[[UIAlertView alloc]initWithTitle:nil message:@"submitting. . . " delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alert show];
    [self performSelector:@selector(stopActivity) withObject:self afterDelay:2.0];
    
    
    
    // loading.hidden = NO;
    fnameHolder = _fnameTextField.text;
    lnameHolder = _lnameTextField.text;
    usernameHolder = _usernameTextField.text;
    emailHolder = _emailTextField.text;
    passwordHolder = _passwordTextField.text;
    confirmHolder = _confirmTextField.text;
    
    NSString *rawStr =[NSString stringWithFormat:@"firstname=%@&lastname=%@&username=%@&emailAddress=%@&password=%@&",fnameHolder,lnameHolder,usernameHolder,emailHolder,passwordHolder];
    
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://zamperla.ph/testfolder/savedata3.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
    
    NSLog(@"%@",responseString);
    
    NSString *success =@"success";
    
    [success dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSLog(@"%lu",(unsigned long)responseString.length);
    NSLog(@"%lu",(unsigned long)success.length);
    
    
}

@end
