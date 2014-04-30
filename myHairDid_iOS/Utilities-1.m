//
//  Utilities.m
//  CarDealership
//

//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities-1.h"
#import "Reachability-1.h"
//#import "TopVehicleInfoView.h"
//#import "Contants.h"
//#import "ConfirmMaintenanceViewController.h"

//#define plist_path @"CarDeslrShipSummary.plist"


@implementation Utilities

Reachability *m_internetReach;
int m_internetWorking;

//+(TopVehicleInfoView *)createNewTopBarFromNib {
//    
//    
//	NSArray* nibContents = [[NSBundle mainBundle] loadNibNamed:@"TopVehicleInfoView" owner:nil options:nil];
//	NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
//	TopVehicleInfoView* view = nil;
//	NSObject* nibItem = nil;
//	while ((nibItem = [nibEnumerator nextObject]) != nil) {
//        
//		if([nibItem isKindOfClass: [TopVehicleInfoView class]]) {
//			view = (TopVehicleInfoView *)nibItem;
//			break;
//		}
//	}
//	return view;
//}
//
//#pragma mark ----
//#pragma mark Top Bar View
//
//+(void)addingTopBarOntoView:(id)targetView withTopBarValues:(NSString *)strcustName withModelOfVehicle:(NSString *)strModelName ofMileage:(NSString *)strMileage withYear:(NSString *)strYear{
//
//    TopVehicleInfoView * topBarOnCutomerInfoView = [Utilities createNewTopBarFromNib];
//    [topBarOnCutomerInfoView setFrame:frametopBar];
//    [targetView addSubview:topBarOnCutomerInfoView];
//    
//    [topBarOnCutomerInfoView setTheCustomerNameOfVehicle:strcustName];
//    [topBarOnCutomerInfoView setTheMileageOfVehicle:strMileage];
//    [topBarOnCutomerInfoView setTheModelOfVehicle:strModelName];
//     [topBarOnCutomerInfoView setTheYear:strYear]; 
//
//    if (topBarOnCutomerInfoView ){
//       topBarOnCutomerInfoView = nil;
//    }
//}
//
//+(NSString *)documentsPath:(NSString *)fileName {
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//	return [documentsDirectory stringByAppendingPathComponent:fileName];
//}
//
////check for the plist path
//+(BOOL)checkForThePlist_path{
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    
//    if (![fileManager fileExistsAtPath: [Utilities documentsPath:plist_path]]) 
//    {
//        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"CarDeslrShipSummary" ofType:@"plist"];
//        [fileManager copyItemAtPath:bundle toPath: [Utilities documentsPath:plist_path] error:&error]; 
//    }
//    
//    if ([fileManager fileExistsAtPath:[Utilities documentsPath:plist_path]]) {
//        return TRUE;
//    }
//    else {
//        return FALSE;
//    }
//}
//
//
//#pragma mark writeDataToPlist
//
//+(void)writeDataToPlist:(NSMutableArray *)arrToWrite
//{
//    if ([self checkForThePlist_path] == TRUE) {
//        if ([arrToWrite count]>0) {
//            [arrToWrite writeToFile:[Utilities documentsPath:plist_path] atomically:YES];
//        }
//    }
//}
//
//#pragma mark readDataFromPlist
//
//+(NSArray *)readDataFromPlist{
//    
//    //if array is blank then just return nil
//    if([self checkForThePlist_path] == FALSE)
//        return [NSArray arrayWithObject:nil];
//    
//    NSMutableArray *plistData = [[NSMutableArray alloc] initWithContentsOfFile:[Utilities documentsPath:plist_path]];
//    
//    //now its owner responsibility to release this
//    return [plistData autorelease];
//}

+(void)alertViewMethod:(NSString*) alertString :(int )tag
{
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:alertString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [al show];
    al.tag=tag;
    NSLog(@"%d",tag);
}

#pragma mark -
#pragma mark Internet Reachability Methods

+(BOOL)CheckInternetConnection
{
	Reachability *m_reachibility = [Reachability reachabilityForInternetConnection] ;
	[m_reachibility startNotifier];
	BOOL statusInternet = [self updateInterfaceWithReachability:m_reachibility];
    
    //release the reachibility object
    
    
    //return the status
	return statusInternet;
}

+ (BOOL) updateInterfaceWithReachability: (Reachability*) curReach
{
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
//            UIAlertView *CheckInternetConnection=[[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection Available. Please Check Your Internet Settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [CheckInternetConnection show];
//            CheckInternetConnection=nil;
            
            return FALSE;
            break;
        }
        case ReachableViaWiFi:
        {
            return TRUE;
            break;
        }
        case ReachableViaWWAN:
        {
            return TRUE;
            break;
            
        }
        default:
        {
            return FALSE;
            break;
            
        }
            
    }
}

////this method will delete the existed plist
//+ (void)deletePList {  
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"CarDeslrShipSummary.plist"];
//    
//    NSError *error;
//    if(![[NSFileManager defaultManager] removeItemAtPath:path error:&error])
//    {
//        
//    }
//}

@end
