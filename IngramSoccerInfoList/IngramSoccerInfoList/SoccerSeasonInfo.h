//
//  SoccerSeasonInfo.h
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SoccerSeasonInfo : NSManagedObject

@property (nonatomic, retain) NSString * homeTeamName;
@property (nonatomic, retain) NSString * awayTeamName;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * goalsHomeTeam;
@property (nonatomic, retain) NSNumber * goalsAwayTeam;
-(void)setDateValue:(NSString*)dateString;
-(NSString*)getDateValue;
@end
