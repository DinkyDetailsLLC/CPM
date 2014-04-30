//
//  ViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTxtFld;       // Name Textfield
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtFLd;    // Password Textfield
- (IBAction)rememberMeCheckButton:(id)sender;

- (IBAction)signUpBTn:(id)sender;
- (IBAction)rememberMeUncheckButton:(id)sender;

- (IBAction)loginBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIButton *uncheckButton;


@end
