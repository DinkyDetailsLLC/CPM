//
//  MasterViewController.h
//  myHairDid
//
//  Created by DANIEL ANNIS on 4/15/14.
//  Copyright (c) 2014 Dinky_Details. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
