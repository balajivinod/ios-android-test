//
//  SoccerSeasonInfo.m
//  IngramSoccerInfoList
//
//  Created by balaji on 21/10/15.
//  Copyright (c) 2015 balaji. All rights reserved.
//

#import "SoccerSeasonInfo.h"


@implementation SoccerSeasonInfo

@dynamic homeTeamName;
@dynamic awayTeamName;
@dynamic status;
@dynamic date;
@dynamic goalsHomeTeam;
@dynamic goalsAwayTeam;

-(void)setDateValue:(NSString*)dateString
{
    NSDateFormatter *dateFormatter;
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.date=[dateFormatter dateFromString:dateString];
    
}

-(NSString*)getDateValue
{
    NSDateFormatter *dateFormatter;
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    return [dateFormatter stringFromDate:self.date];
}
@end
