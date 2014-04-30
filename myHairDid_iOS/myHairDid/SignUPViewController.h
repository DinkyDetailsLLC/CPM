//
//  SignUPViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUPViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameSignUp;
@property (strong, nonatomic) IBOutlet UITextField *emailSignUp;
- (IBAction)registerBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordForSignUp;

@property (strong, nonatomic) IBOutlet UITextField *passwordSignUp;
@end
