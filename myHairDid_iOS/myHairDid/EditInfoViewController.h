//
//  EditInfoViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *addressTxt;

@property (strong, nonatomic) IBOutlet UITextField *cityTxt;

@property (strong, nonatomic) IBOutlet UIImageView *myImage;

@property (strong, nonatomic) IBOutlet UITextField *phoneTxt;
@property (strong, nonatomic) IBOutlet UITextField *stateTxt;

@property (strong, nonatomic) IBOutlet UITextField *zipTxt;

@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

- (IBAction)editImageBtn:(id)sender;

- (IBAction)editInfoBtn:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@end
