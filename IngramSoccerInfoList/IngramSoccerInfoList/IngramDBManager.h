//
//  IngramDBManager.h
//  IngramSoccerInfoList
//
//  Created by balaji on 21/10/15.
//  Copyright (c) 2015 balaji. All rights reserved.
//  This file is for coredata operations such as initializing coredata and saving, retrieving data.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface IngramDBManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
+(instancetype)sharedDBManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)saveSoccerInfoToDB:(NSArray *)valueArray;
-(NSArray*)readSoccerInfo;

@end
