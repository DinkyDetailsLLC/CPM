//
//  EditInfoViewController.m
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//
extern NSString *selectedUser;
#import "EditInfoViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "Utilities-1.h"
@interface EditInfoViewController ()
{
    NSArray *infoArray;
    MBProgressHUD *HUD;
    NSString * ObjID;
    UIImage *chosenImage;
    NSString *offlineStr;
}

@end

@implementation EditInfoViewController

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
    
    offlineStr=@"1";
    self.title=@"Edit Info";
    HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];   // Adding the MBPRogressHUD on LoginButton
    HUD.labelText=@"Please Wait";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];   // Setting the background image
    
    PFQuery *query=[PFQuery queryWithClassName:@"AdditionalInfoDB"];
    [query whereKey:@"name" equalTo:selectedUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
             
         {
             
             if (objects.count==0)
             {
                 NSLog(@"Empty");
             }
             else
             {
                 self.nameTxt.text=[[objects valueForKey:@"name"]objectAtIndex:0];
                 self.addressTxt.text=[[objects valueForKey:@"address"]objectAtIndex:0];
                 self.cityTxt.text=[[objects valueForKey:@"city"]objectAtIndex:0];
                 self.phoneTxt.text=[[objects valueForKey:@"phone"]objectAtIndex:0];
                 self.stateTxt.text=[[objects valueForKey:@"state"]objectAtIndex:0];
                 self.zipTxt.text=[[objects valueForKey:@"zip"]objectAtIndex:0];
                 self.emailTxt.text=[[objects valueForKey:@"email"]objectAtIndex:0];
                 ObjID=[[objects valueForKey:@"objectId"]objectAtIndex:0];
                 HUD.hidden=YES;
                 PFObject *photoObject = [query getFirstObject];
                 PFFile *imageFile = [photoObject objectForKey:@"image"];
                 NSData *imageData;
                 imageData=[imageFile getData];
                 UIImage *fullImage = [UIImage imageWithData:imageData];
                 self.myImage.image=fullImage;
             }
         }
     }];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (![self.emailTxt.text isEqualToString:@""]) {
        
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        //Validate email address.
        if (![emailTest evaluateWithObject:self.emailTxt.text] == YES)
        {
            UIAlertView *EmailAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [EmailAlert show];
            [self.emailTxt becomeFirstResponder];
        }
        
    }
    if (![self.phoneTxt.text isEqualToString:@""]) {
        
        
        if (![self isNumeric:self.phoneTxt.text] )
        { //mobileNumber Check
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Phone Number. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [self.phoneTxt becomeFirstResponder];
        }
    }
    if (![self.zipTxt.text isEqualToString:@""]) {
        if (![self isNumeric:self.zipTxt.text]) {
            UIAlertView *ZipAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Zip . " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [ZipAlert show];
            [self.zipTxt becomeFirstResponder];
        }
    }
    
    return YES;
}
-(BOOL)isNumeric:(NSString*)inputString         // Validation for Phone
{
    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    return [inputString isEqualToString:filtered];
}

//#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)hideKeyboard:(id)sender
{
    
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editImageBtn:(id)sender
{
    UIActionSheet *image=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Gallery",@"Camera", nil];
    [image showInView:self.view];
    image.tag=1;
    
}
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
    self.myImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)editInfoBtn:(id)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"AdditionalInfoDB"];
    [query getObjectInBackgroundWithId:ObjID block:^(PFObject *myInfo, NSError *error) {
        
        
        NSData *imageData = UIImageJPEGRepresentation(self.myImage.image, 0.8);
        
        PFFile *file = [PFFile fileWithName:@"chosenImageEditted.jpg" data:imageData];
        
        
        [myInfo setObject:file forKey:@"image"];
        
        myInfo[@"name"] = self.nameTxt.text;
        myInfo[@"address"] = self.addressTxt.text;
        myInfo[@"city"] = self.cityTxt.text;
        myInfo[@"phone"] = self.phoneTxt.text;
        myInfo[@"state"]=self.stateTxt.text;
        myInfo[@"zip"]=self.zipTxt.text;
        myInfo[@"email"]=self.emailTxt.text;
        [myInfo saveInBackground];
    }];
    
    UIAlertView *editAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Information Has Been Edited" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [editAlert show];
}
@end
