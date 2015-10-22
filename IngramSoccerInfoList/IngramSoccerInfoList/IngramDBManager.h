//
//  IngramDBManager.h
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

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
