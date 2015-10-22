//
//  IngramServiceManager.m
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

#import "IngramServiceManager.h"
#import "IngramDBManager.h"

static NSString * const baseURLString = @"http://api.football-data.org/alpha/soccerseasons/398/fixtures";

static IngramServiceManager *sharedInstance =nil;

@implementation IngramServiceManager

+(instancetype)sharedServiceManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)getSoccerInfo:(serviceCompleted)responseCompleted
{
    
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

// 3
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig];


    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:baseURLString]
                                        completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError *error) {
                                            // handle NSData
                                            if(error==nil)
                                            {
                                                NSError *jsonError=nil;
                                                NSDictionary *notesJSON =
                                                [NSJSONSerialization JSONObjectWithData:data
                                                                            options:NSJSONReadingAllowFragments
                                                                              error:&jsonError];
                                                if(jsonError==nil)
                                                {
                                                
                                                   [[IngramDBManager sharedDBManager] saveSoccerInfoToDB:notesJSON[@"fixtures"]];
                                                    
                                                    responseCompleted(YES,nil);
                                                }
                                                else
                                                {
                                                    responseCompleted(NO,jsonError);
                                                }
                                                
                                                NSLog(@"notes json %@", notesJSON);
                                            }
                                            else
                                            {
                                                responseCompleted(NO,error);
                                            }
                                            
                                            
                                        }];

    [jsonData resume];
}

@end
