//
//  Utilities.h
//  CarDealership
//

//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability-1.h"
@class TopVehicleInfoView;
@interface Utilities : NSObject<UIAlertViewDelegate>
    
    
////this method will create the nib for the top bar of needed view
//+(TopVehicleInfoView *)createNewTopBarFromNib;
//
////adding top bar
//+(void)addingTopBarOntoView:(id)targetView withTopBarValues:(NSString *)strcustName withModelOfVehicle:(NSString *)strModelName ofMileage:(NSString *)strMileage withYear:(NSString *)strYear;
//
///***
// create dynamic Plist to store data related Routine Maintennace,Inspection,Other and Auto Detailing Service values
// ***/
//+(void)writeDataToPlist:(NSMutableArray *)arrToWrite;
//
//
//
/////read data from Plist related Routine Maintennace,Inspection,Other and Auto Detailing Service values
//+(NSArray *)readDataFromPlist;
//
//
//methods to check internet connection
+(BOOL)CheckInternetConnection;
+ (BOOL) updateInterfaceWithReachability: (Reachability*) curReach;
+(void)alertViewMethod:(NSString*) alertString :(int )tag;

////this method will delete the existed plist
//+ (void)deletePList ;
//
////get the path from the documents directory
//+(NSString *)documentsPath:(NSString *)fileName;

@end




