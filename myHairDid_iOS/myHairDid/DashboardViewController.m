//
//  DashboardViewController.m
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/29/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

extern NSString *objectIdStr;
NSString *selectedUser;
extern NSString *nameStr;
#import "DashboardViewController.h"
#import <Parse/Parse.h>
#import "MoreInfoViewController.h"
#import "EditInfoViewController.h"
#import "Utilities-1.h"
#import "MBProgressHUD.h"

@interface DashboardViewController ()

{
    
    NSArray *tableArray;
    NSMutableArray *dataArray1;
    NSString *alerStr;
    PFQuery *query;
    NSInteger  selectedInd;
    NSString *alertString;
    NSInteger alertTag;
    MBProgressHUD *HUD;
}

@end

@implementation DashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    alerStr=@"0";
    
    HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];

    // Adding the MBPRogressHUD on LoginButton

    HUD.labelText=@"Please Wait";
    
    dataArray1=[[NSMutableArray alloc]init];
    UIBarButtonItem *backButtonObject=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
    self.navigationItem.leftBarButtonItem=backButtonObject;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];
    
    
    UIBarButtonItem *addButtonObject=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddInfo)];
    self.navigationItem.rightBarButtonItem=addButtonObject;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor blackColor];
    
    query=[PFQuery queryWithClassName:@"AdditionalInfoDB"];
    [query whereKey:@"Admin" equalTo:nameStr];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
             
         {
             
             
             dataArray1 =[objects valueForKey:@"name"];
             
             if (dataArray1.count==0)
                 
             {
                 alertString =@"Add Your Clients.";
                 alertTag=5;
                 [Utilities alertViewMethod:alertString :alertTag];
                 HUD.hidden=YES;
                 
             }
             [self.tableForName reloadData];
         }
     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Clients";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];   // Setting the background image
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray1 count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    
    lpgr.minimumPressDuration = 1.0;
    
    [cell addGestureRecognizer:lpgr];
    cell.backgroundColor=[UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text=[dataArray1 objectAtIndex:indexPath.row];
    HUD.hidden=YES;
    return cell;
    
}
- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableForName];
    
    NSIndexPath *indexPath = [self.tableForName indexPathForRowAtPoint:p];
    if (indexPath == nil)
        NSLog(@"long press on table view but not on a row");
    else
        NSLog(@"long press on table view at row %d", indexPath.row);
    selectedInd=indexPath.row;
    
    if ([alerStr isEqual:@"1"])
    {
        NSLog(@"Repeat");
    }
    else
    {
        alerStr=@"1";
        UIAlertView *DeleteAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        
        [DeleteAlert show];
        DeleteAlert.tag=2;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedUser=[dataArray1 objectAtIndex:indexPath.row];
    
    EditInfoViewController *editInfo=[[EditInfoViewController alloc]initWithNibName:@"EditInfoViewController" bundle:Nil];
    [self.navigationController pushViewController:editInfo animated:YES];
}

-(void)Logout
{
    UIAlertView *LogoutAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are You Sure You Want To Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [LogoutAlert show];
    LogoutAlert.tag=1;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            
        }
        else if (buttonIndex==1)
            
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if (alertView.tag==2)
    {
        if (buttonIndex==0)
        {
            alerStr=@"0";
            NSLog(@"No");
            
        }
        else if (buttonIndex==1)
        {
            alerStr=@"0";
            
            query = [PFQuery queryWithClassName:@"AdditionalInfoDB"];
            [query whereKey:@"name" equalTo:[dataArray1 objectAtIndex:selectedInd]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
             
             {
                 if (!error)
                 {
                     // The find succeeded.
                     // Do something with the found objects
                     for (PFObject *object in objects)
                     {
                         
                         [object deleteInBackground];
                         NSLog(@"Deleted");
                         [self viewWillAppear:YES];
                         
                         
                     }
                     
                     [self.tableForName reloadData];
                     
                 }
                 else
                 {
                     // Log details of the failure
                     NSLog(@"Error: %@ %@", error, [error userInfo]);
                 }
             }];
            
        }
    }
    
}
-(void)AddInfo
{
    
    MoreInfoViewController *moreInfo=[[MoreInfoViewController alloc]initWithNibName:@"MoreInfoViewController" bundle:Nil];
    [self.navigationController pushViewController:moreInfo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

