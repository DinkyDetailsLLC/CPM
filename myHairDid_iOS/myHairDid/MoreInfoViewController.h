//
//  MoreInfoViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface MoreInfoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *userImage;
- (IBAction)UploadBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *nameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *addressTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *cityTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *stateTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *ZipTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *emailTxtFld;

- (IBAction)addInfoBtn:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end