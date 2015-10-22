//
//  ViewController.m
//  IngramSoccerInfoList
//
//  Created by ADMINISTRATOR on 21/10/15.
//  Copyright (c) 2015 ADMINISTRATOR. All rights reserved.
//

#import "ViewController.h"
#import "IngramServiceManager.h"
#import "IngramDBManager.h"
#import "SoccerSeasonInfo.h"
#import "SoccerSeasonInfoCell.h"

#define kSoccerSeasonInfoCellIdentifier @"soccerSeasonInfoCell"

@interface ViewController ()
@property(strong, nonatomic)NSArray *readSoccerArray;
@property(weak, nonatomic)IBOutlet UITableView *soccerListTableView;
@end

@implementation ViewController
@synthesize readSoccerArray = _readSoccerArray;
@synthesize soccerListTableView = _soccerListTableView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _readSoccerArray = [[IngramDBManager sharedDBManager] readSoccerInfo];
    
    if([_readSoccerArray count]==0)
    {
        [[IngramServiceManager sharedServiceManager] getSoccerInfo:^(BOOL status, NSError *error){
        
            dispatch_async(dispatch_get_main_queue(), ^{
            if(status){
            _readSoccerArray= [[IngramDBManager sharedDBManager] readSoccerInfo];
            [_soccerListTableView reloadData];
            }
       else
           NSLog(@"error %@",[error localizedDescription]);
            });
        
    }];
    }
    else{
        
        [_soccerListTableView reloadData];
    }
    

    
    // Do any additional setup after loading the view, typically from a nib.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return [_readSoccerArray count];
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoccerSeasonInfo *objInfo;
    
    objInfo = [ _readSoccerArray objectAtIndex:indexPath.row];
    
    
    SoccerSeasonInfoCell *cell;
    
  
    
    cell=(SoccerSeasonInfoCell*)[tableView dequeueReusableCellWithIdentifier:kSoccerSeasonInfoCellIdentifier];
    
    cell.lbl_homeTeam.text=[NSString stringWithFormat:@"HomeTeam: %@",objInfo.homeTeamName];
    cell.lbl_awayTeam.text=[NSString stringWithFormat:@"AwayTeam: %@",objInfo.awayTeamName];
    cell.lbl_goalsHome.text=[NSString stringWithFormat:@"Goals: %@",[objInfo.goalsHomeTeam stringValue]];
    cell.lbl_goalsAway.text=[NSString stringWithFormat:@"Goals: %@",[objInfo.goalsAwayTeam stringValue]];
    cell.lbl_gameDate.text=[objInfo getDateValue];
    cell.lbl_status.text=[NSString stringWithFormat:@"Status: %@",objInfo.status];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
