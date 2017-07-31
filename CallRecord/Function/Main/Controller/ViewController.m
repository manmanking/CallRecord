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
#import "WIFIViewController.h"
#import "CallRecord-Swift.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSourcesArr;
@property (nonatomic,strong) NSArray *dataSourcesTitleArr;



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
    [self getLocalFont];
    self.dataSourcesArr = @[@"CallRecordViewController",@"AudioRecordViewController",@"WIFIViewController",@"CycleViewController",@"TableViewController",@"NextTableViewVController"];
    self.dataSourcesTitleArr = @[@"$电话录音",@"¥录音",@"%获得WI-FI名称",@"轮播实现",@"倒计时",@"嵌套表格"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourcesTitleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentify];
    cell.textLabel.text = [NSString stringWithFormat:@"index  section %ld  row%ld",(long)indexPath.section,(long)indexPath.row];
    
    
    NSString * title = self.dataSourcesTitleArr[indexPath.row];
    cell.textLabel.text = title;
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        cell.textLabel.font = [UIFont fontWithName:@"Alexis 3D" size:13];
//    }
    
    //UIFont.init(name:"FZLanTingHeiS-R-GB" , size: size)
    //cell.textLabel.font = [UIFont fontWithName:@"Hiragino Mincho ProN" size:13];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"selected index  section %ld  row%ld",(long)indexPath.section,(long)indexPath.row);
    
   
    id controller = [[NSClassFromString(self.dataSourcesArr[indexPath.row]) alloc]init];
    if (controller == nil && indexPath.row == 3) {
        printf("into here ...");
        controller = [[CycleViewController alloc] init];
        /*
            若没有这个 为空判断 由Swift 写的控制器 获取不到这个
            添加了 校验 就可以获取到 这个 由 swift 编写的控制器
            这个什么原理
         
         */
    }
    if (controller == nil && indexPath.row == 4)
    {
        controller = [[TableViewController alloc] init];
        
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    return;

    
}




- (void)getLocalFont
{
    
    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    NSLog(@"[familyNames count]===%d",[familyNames count]);
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        
        {
            NSLog(@"Font name: %@",[fontNames objectAtIndex:indFont]);
            
        }
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)dataSourcesArr
{
    if (_dataSourcesArr  == nil) {
        
        _dataSourcesArr = [[NSArray alloc]init];
        
    }
    return  _dataSourcesArr;
}




@end
