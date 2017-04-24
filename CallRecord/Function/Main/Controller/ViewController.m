//
//  ViewController.m
//  CallRecord
//
//  Created by manman on 2017/4/23.
//  Copyright © 2017年 manman. All rights reserved.
//

#import "ViewController.h"
#import "CallRecordViewController.h"
#import "AudioRecordViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;



@end

@implementation ViewController


static NSString *tableViewCellIdentify = @"tableViewCellIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:tableViewCellIdentify];
    
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentify];
    cell.textLabel.text = [NSString stringWithFormat:@"index  section %ld  row%ld",(long)indexPath.section,(long)indexPath.row];
    
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        cell.textLabel.text = @"电话录音";
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        cell.textLabel.text = @"录音";
    }
    
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"selected index  section %ld  row%ld",(long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        CallRecordViewController * callRecordViewController = [[CallRecordViewController alloc]init];
        [self.navigationController pushViewController:callRecordViewController animated:true];
        
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        AudioRecordViewController *audioRecordViewController = [[AudioRecordViewController alloc]init];
        [self.navigationController pushViewController:audioRecordViewController animated:true];
        
        
    }
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
