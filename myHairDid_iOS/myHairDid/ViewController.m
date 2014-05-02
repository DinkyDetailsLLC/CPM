//
//  ViewController.m
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//
NSString *nameStr;
NSString *objectIdStr;

#import "ViewController.h"
#import <Parse/Parse.h>
#import "SignUPViewController.h"
#import "DashboardViewController.h"
#include "MBProgressHUD.h"
#import "Utilities-1.h"

@interface ViewController ()
{
    NSArray *dataArray;
    MBProgressHUD *HUD;
    NSString *alertString;
    NSInteger alertTag;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


////////////////// Empty the text fields every time the view appears ////////////////////////

-(void)viewWillAppear:(BOOL)animated
{
    HUD.hidden=YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myString1 = [prefs stringForKey:@"textField1Text"];
    NSString *myString2 = [prefs stringForKey:@"textField2Text"];
    self.nameTxtFld.text=myString1;
    self.passwordTxtFLd.text=myString2;
    if (myString1 && myString2 !=Nil)
    {
        //self.uncheckButton.hidden=YES; // hidding the uncheck button of remember me
    }
    else
    {
        // self.checkButton.hidden=YES; // hidding the check button of remember me
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];   // Setting the background image
    
    self.title=@"Login";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)rememberMeCheckButton:(id)sender
{
    self.uncheckButton.hidden=NO;       // Checking the remember me button
    self.checkButton.hidden=YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"textField1Text"];
    [defaults removeObjectForKey:@"textField2Text"];
    [defaults synchronize];
    
    
}

- (IBAction)rememberMeUncheckButton:(id)sender
{
    self.checkButton.hidden=NO;         // Unchecking the remember me button
    self.uncheckButton.hidden=YES;
    
    [self saveDetails];
    
}

-(void)saveDetails
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString* textField1Text = self.nameTxtFld.text;
    [defaults setObject:textField1Text forKey:@"textField1Text"];
    
    NSString *textField2Text = self.passwordTxtFLd.text;
    [defaults setObject:textField2Text forKey:@"textField2Text"];
    [defaults synchronize];
    
    
}
#pragma mark   Buttons


///////////////////////////////////////// Navigates the User to signUp Screen /////////////////////////////

- (IBAction)signUpBTn:(id)sender
{
    SignUPViewController *signUp=[[SignUPViewController alloc]initWithNibName:@"SignUPViewController" bundle:Nil];
    [self.navigationController pushViewController:signUp animated:YES];
    
}


- (IBAction)loginBtn:(id)sender

{
    if (![Utilities CheckInternetConnection])
    {
        
    }
    
    else
    {
        [self.nameTxtFld resignFirstResponder];
        [self.passwordTxtFLd resignFirstResponder];
        ////////////////////// Empty Text Field Validation //////////////////////
        
        if ([self.nameTxtFld.text isEqualToString:@""] || [self.passwordTxtFLd.text isEqualToString:@""] )
        {
            UIAlertView *loginALert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter All The Details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [loginALert show];
        }
        
        else
        {
            
            
            /////////////// remove the white blank space before the name/////////
            self.nameTxtFld.text  = [ self.nameTxtFld.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
            self.passwordTxtFLd.text=[self.passwordTxtFLd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            nameStr= self.nameTxtFld.text;
            
            HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];   // Adding the MBPRogressHUD on LoginButton
            HUD.labelText=@"Logging In";
            
            
            [PFUser logInWithUsernameInBackground:self.nameTxtFld.text password:self.passwordTxtFLd.text block:^(PFUser *user, NSError *error)
             {
                 if (user) {
                     DashboardViewController *dash=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
                     [self.navigationController pushViewController:dash animated:YES];
                     
                 }
                 else
                 {
                     NSString *errorString = [[error userInfo] objectForKey:@"error"];
                     NSLog(@"Error: %@", errorString);
                     HUD.hidden=YES;
                     
                 }
             }];
            
            //        PFQuery *query=[PFQuery queryWithClassName:@"ParseAppDB"];   // Fetching the Data to the Database with ClassName
            //        [query whereKey:@"name" equalTo:self.nameTxtFld.text];
            //        [query whereKey:@"password" equalTo:self.passwordTxtFLd.text];
            //
            //
            //        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
            //
            //        {
            //            objectIdStr= [objects valueForKey:@"objectId"];
            //
            //
            //             if (!error)
            //
            //             {
            //                 HUD.hidden=YES;
            //                 dataArray=objects;
            //                 if (objects.count==0)   // If data entered is incorrect then alert
            //                 {
            //                     {
            //                         alertString =@"Invalid Username or Password";
            //                         alertTag =0;
            //                         [Utilities alertViewMethod:alertString :alertTag];
            //
            //                         self.nameTxtFld.text=@"";
            //                        self.passwordTxtFLd.text=@"";
            //
            //                     }
            //
            //                 }
            
            
            //                 else   // If data entered is correct then navigates to next screen
            //
            //                 {
            //                     if (self.checkButton.hidden==NO)
            //                     {
            //                         [self saveDetails];
            //                     }
            //
            //                     DashboardViewController *dash=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
            //                     [self.navigationController pushViewController:dash animated:YES];
            //                 }
            //             }
            //             else
            //             {
            //                 NSString *errorString = [[error userInfo] objectForKey:@"error"];
            //                 NSLog(@"Error: %@", errorString);
            //             }
            //             
            //         }];
            //    }
            //    }
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