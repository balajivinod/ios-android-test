//
//  IngramDBManager.m
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

#import "IngramDBManager.h"
#import "SoccerSeasonInfo.h"

#define kSoccerSeasonInfoEntity @"SoccerSeasonInfo"

@implementation IngramDBManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+(instancetype)sharedDBManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sample.IngramSoccerInfoList" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"IngramSoccerInfoList" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"IngramSoccerInfoList.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}




-(void)saveSoccerInfoToDB:(NSArray *)valueArray
{
    for(NSDictionary *seasonDictionary in valueArray)
    {
        SoccerSeasonInfo *newSeasonInfo = [NSEntityDescription insertNewObjectForEntityForName:kSoccerSeasonInfoEntity inManagedObjectContext:self.managedObjectContext];
    
    
        
        
        [newSeasonInfo setHomeTeamName:seasonDictionary[@"homeTeamName"]];
         [newSeasonInfo setAwayTeamName:seasonDictionary[@"awayTeamName"]];
         [newSeasonInfo setStatus:seasonDictionary[@"status"]];
         [newSeasonInfo setDateValue:seasonDictionary[@"date"]];
        
          [newSeasonInfo setGoalsHomeTeam:seasonDictionary[@"result"][@"goalsHomeTeam"]];
           [newSeasonInfo setGoalsAwayTeam:seasonDictionary[@"result"][@"goalsAwayTeam"]];
        
        NSError *savingError = nil;
    
        if ([self.managedObjectContext save:&savingError])
        {
           
        }
    
        else
        {
            NSLog(@"Failed the save the new House. Error = %@", savingError);
        }
    }
    
            [self saveContext];
}



-(NSArray*)readSoccerInfo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kSoccerSeasonInfoEntity];
    
    NSError *requestError = nil;
    
    NSArray *socccerInfoArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([socccerInfoArray count] > 0)
    {
        return socccerInfoArray;
    }
    else
    {
        NSLog(@"Could not find any SoccerSeasonInfoList entities in the context.");
        return 0;
    }
}



@end
