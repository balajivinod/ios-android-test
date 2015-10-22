//
//  IngramServiceManager.h
//  IngramSoccerInfoList
//
//  Created by balaji on 21/10/15.
//  Copyright (c) 2015 balaji. All rights reserved.
//
// version 1.0
// This file is service manager for getting soccerseasondetails.

#import <Foundation/Foundation.h>

typedef void (^serviceCompleted)(BOOL status, NSError *error);
@interface IngramServiceManager : NSObject
{
    
}
+(instancetype)sharedServiceManager;
-(void)getSoccerInfo:(serviceCompleted)responseCompleted;
@end
