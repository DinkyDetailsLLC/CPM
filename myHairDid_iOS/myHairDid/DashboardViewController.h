//
//  DashboardViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableForName;

@end

