//
//  MoreInfoViewController.m
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.

extern NSString *nameStr;
extern NSString *objectIdStr;
extern NSString *nameStr;
#import "MoreInfoViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "Utilities-1.h"


@interface MoreInfoViewController ()
{
    UIImage *chosenImage ;
    MBProgressHUD *HUD;
    UIAlertView *SignUpDoneAlert;
    
}

@end

@implementation MoreInfoViewController

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
    
    
    self.title=@"Add Client";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];   // Setting the background image
    
    PFQuery *query=[PFQuery queryWithClassName:@"ClientDetail"];
    [query whereKey:@"Admin" equalTo:nameStr];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     
     {
         
         if (!error)
             
         {
             // NSLog(@"DATA : %@",objects);
             
         }
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadBtn:(id)sender
{
    UIActionSheet *image=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Gallery",@"Camera", nil];
    [image showInView:self.view];
    image.tag=1;
    
}
//-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(self.phoneTxtFld.text.length >= 10 && range.length == 0)
//    {
//        return NO;
//    }
//
//    else if (self.nameTxtFld.text.length>=10 &&range.length==0) {
//        return NO;
//    }
//  else  if (self.ZipTxtFld.text.length>=6 && range.length==0) {
//        return NO;
//    }
//
//
//    return YES;
//
//}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag ==1)
    {
        if (buttonIndex==1)
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [myAlertView show];
            }
            
            else{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
            }
            
        }
        if (buttonIndex==0) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate=self;
            picker.allowsEditing =YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    self.userImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)isNumeric:(NSString*)inputString         // Validation for Phone
{
    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    return [inputString isEqualToString:filtered];
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//
//
//    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
//
//    //Validate email address.
//    if (![emailTest evaluateWithObject:self.emailTxtFld.text] == YES)
//    {
//        UIAlertView *EmailAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [EmailAlert show];
//        [self.emailTxtFld becomeFirstResponder];
//    }
//
//
//
//
//    if (![self isNumeric:self.phoneTxtFld.text] )
//            { //mobileNumber Check
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Phone Number. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [alert show];
//                [self.phoneTxtFld becomeFirstResponder];
//            }
//
//        if (![self isNumeric:self.ZipTxtFld.text]) {
//            UIAlertView *ZipAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Zip. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [ZipAlert show];
//            [self.ZipTxtFld becomeFirstResponder];
//
//    }
//
//    return YES;
//}
- (IBAction)addInfoBtn:(id)sender
{
    
    if ([self.nameTxtFld.text isEqualToString:@""] || [self.addressTxtFld.text isEqualToString:@""] || [self.cityTxtFld.text isEqualToString:@""] || [self.phoneTxtFld.text isEqualToString:@""])
        
    {
        UIAlertView *AddInfoAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter All The Details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [AddInfoAlert show];
        
    }
    else
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        //Validate email address.
        if (![emailTest evaluateWithObject:self.emailTxtFld.text] == YES)
        {
            UIAlertView *EmailAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [EmailAlert show];
            [self.emailTxtFld becomeFirstResponder];
        }
        
        
        else{
            
            if (![self isNumeric:self.phoneTxtFld.text] )
            { //mobileNumber Check
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Phone Number. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [self.phoneTxtFld becomeFirstResponder];
            }
            else
                
                if (![self isNumeric:self.ZipTxtFld.text]) {
                    UIAlertView *ZipAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Zip. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [ZipAlert show];
                    [self.ZipTxtFld becomeFirstResponder];
                    
                }
            
            
            
                else
                {
                    
                    HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];   // Adding the MBPRogressHUD on LoginButton
                    HUD.labelText=@"Please Wait";
                    
                    PFQuery *query=[PFQuery queryWithClassName:@"ClientDetail"];
                    [query whereKey:@"Admin" equalTo:nameStr];
                    
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
                     
                     {
                         NSData *imageData = UIImageJPEGRepresentation(self.userImage.image, 0.8);
                         
                         // PFFile *file = [PFFile fileWithName:@"chosenImage.jpg" data:imageData];
                         
                         PFObject *MoreInfoObject=[PFObject objectWithClassName:@"ClientDetail"];
                         //  [MoreInfoObject setObject:file forKey:@"image"];
                         
                         MoreInfoObject[@"name"] = self.nameTxtFld.text;
                         MoreInfoObject[@"address"]=self.addressTxtFld.text;
                         MoreInfoObject[@"city"]=self.cityTxtFld.text;
                         MoreInfoObject[@"phone"]=self.phoneTxtFld.text;
                         MoreInfoObject[@"state"]=self.stateTxtFld.text;
                         MoreInfoObject [@"zip"]=self.ZipTxtFld.text;
                         MoreInfoObject[@"email"]=self.emailTxtFld.text;
                         MoreInfoObject[@"fromUser"] = nameStr;
                         //   MoreInfoObject[@"UniqueIdForUser"]=objectIdStr;
                         MoreInfoObject[@"Admin"]=nameStr;
                         if ([[objects valueForKey:@"name"] containsObject:self.nameTxtFld.text])
                         {
                             
                             UIAlertView *CheckAlertForClients=[[UIAlertView alloc]initWithTitle:@"" message:@"This Name Already Exists. Please Enter A Different Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                             [CheckAlertForClients show];
                             CheckAlertForClients.tag=1;
                             HUD.hidden=YES;
                             [self.nameTxtFld becomeFirstResponder];
                         }
                         else
                         {
                             
                             [MoreInfoObject saveInBackground];
                             HUD.hidden=YES;
                             
                             SignUpDoneAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Your Information Has Been Added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                             [SignUpDoneAlert show];
                             SignUpDoneAlert.tag=1;
                             
                             self.nameTxtFld.text=@"";
                             self.addressTxtFld.text=@"";
                             self.cityTxtFld.text=@"";
                             self.phoneTxtFld.text=@"";
                             self.userImage.image=Nil;
                             self.emailTxtFld.text=@"";
                             self.ZipTxtFld.text=@"";
                             self.stateTxtFld.text=@"";
                         }
                     }];
                }
        }
    }
}
#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//- (IBAction)hideKeyboard:(id)sender
//{
//    NSLog(@"hideKeyboard");
//    [sender resignFirstResponder];
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"textViewDidBeginEditing");
//
//    if (textField.frame.origin.y + textField.frame.size.height > 480 - 216) {
//        double offset = 480 - 216 - textField.frame.origin.y - textField.frame.size.height - 20;
//        CGRect rect = CGRectMake(0, offset, self.view.frame.size.width, self.view.frame.size.height);
//
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.3];
//
//        self.view.frame = rect;
//
//        [UIView commitAnimations];
//    }
//
//
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//    NSLog(@"textViewDidEndEditing");
//
//    CGRect rect = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
//
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3];
//
//    self.view.frame = rect;
//
//    [UIView commitAnimations];
//
//}
//
//////////////////// Clicking the Button on AlertBox///////////////////////

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0) // On Clicking OK navigates to previous screen
        {
            //   [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag==4) {
        if (buttonIndex==0) {
            [self.phoneTxtFld becomeFirstResponder];
        }
    }
    
}
@end