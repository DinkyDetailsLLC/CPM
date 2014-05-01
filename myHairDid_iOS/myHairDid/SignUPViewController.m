//
//  SignUPViewController.m
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import "SignUPViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"
#import "MBProgressHUD.h"
#import "Utilities-1.h"

@interface SignUPViewController ()
{
    
    PFObject *testObject;
    MBProgressHUD *HUD;
    NSString *alertString;
    NSInteger alertTag;
    
}
@end

@implementation SignUPViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Register";
    
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];    // Setting the background image
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerBtn:(id)sender
{
    
    /////////// Empty TextField Validation ///////////////
    
    if ([self.nameSignUp.text isEqual:@""] || [self.passwordSignUp.text isEqual:@""]  || [self.emailSignUp.text isEqual:@""] )
        
    {
        alertString =@"Please Enter All The Details.";
        alertTag =0;
        [Utilities alertViewMethod:alertString :alertTag];
    }
    
    
    ////////////// Validation for Password And Confirm Password ///////////////
    else
        
        if (![self.passwordSignUp.text isEqualToString:self.confirmPasswordForSignUp.text])
        {
            
            alertString =@"Password Does Not Match";
            alertTag =3;
            [Utilities alertViewMethod:alertString :alertTag];
            [self.confirmPasswordForSignUp becomeFirstResponder];
            
        }
        else   if (![self.emailSignUp.text isEqualToString:@""])
        {
            
            NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
            
            //Validate email address.
            if (![emailTest evaluateWithObject:self.emailSignUp.text] == YES)
            {
                alertString =@"Email is Invalid. Please Enter Valid Email Address.";
                alertTag=4;
                [Utilities alertViewMethod:alertString :alertTag];
                
            }
            
            else
            {
                
                self.nameSignUp.text =[self.nameSignUp.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                self.passwordSignUp.text=[self.passwordSignUp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                self.emailSignUp.text=[self.emailSignUp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                testObject = [PFObject objectWithClassName:@"ParseAppDB"];   // Saving the data to the database with ClassName
                testObject[@"name"] = self.nameSignUp.text;
                testObject[@"password"]=self.passwordSignUp.text;
                testObject[@"email"]=self.emailSignUp.text;
                if (![Utilities CheckInternetConnection])
                {
                    
                    [testObject saveEventually];
                    UIAlertView *CheckInternetConnection=[[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection Available. Your data will be saved after you connect to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [CheckInternetConnection show];
                    CheckInternetConnection=nil;
                    
                }
                
                else
                {
                    [testObject saveInBackground];
                    
                    /////////////// Alert to show Successfull Registeration /////////////////
                    
                    UIAlertView *loginALert=[[UIAlertView alloc]initWithTitle:@"" message:@"Your New Account Has Been Registered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [loginALert show];
                    loginALert.tag =1;
                    HUD.hidden=YES;
                    
                }
            }
        }
    
    //  }];
}


//////////////////// Clicking the Button on AlertBox///////////////////////

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0) // On Clicking OK navigates to previous screen
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
#pragma mark - Textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end