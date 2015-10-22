//
//  IngramServiceManager.h
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^serviceCompleted)(BOOL status, NSError *error);
@interface IngramServiceManager : NSObject
{
    
}
+(instancetype)sharedServiceManager;
-(void)getSoccerInfo:(serviceCompleted)responseCompleted;
@end
