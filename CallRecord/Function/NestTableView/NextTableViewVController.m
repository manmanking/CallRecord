//
//  NextTableViewVController.m
//  CallRecord
//
//  Created by manman on 2017/7/27.
//  Copyright © 2017年 manman. All rights reserved.
//

#import "NextTableViewVController.h"

@interface NextTableViewVController()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic)UITableView *baseBackgroundTableView;

@property (strong ,nonatomic)UITableView *nestTableView;

@property (assign ,nonatomic)NSInteger numberRow;
@property (assign ,nonatomic)BOOL showNest;



@end

static NSString * identifyBase = @"placeHolderBase";
static NSString * identify = @"placeHolder";


@implementation NextTableViewVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"嵌套表格";
     _showNest = false;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUIViewAUtolayout];
    
    
    
    
    
    
}



- (void)setUIViewAUtolayout
{
    
    [self.view addSubview:self.baseBackgroundTableView];
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.nestTableView) {
        return _numberRow;
    }
    
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _baseBackgroundTableView && indexPath.row == 3) {
        return 44 * _numberRow;
    }
    
    
    return  44;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _baseBackgroundTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyBase];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        if (indexPath.row == 3 && _showNest == true) {
            [cell.contentView addSubview:self.nestTableView];
            self.nestTableView.frame = CGRectMake(200, 0, 200, _numberRow * 44);
            
        }
        
        
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        cell.textLabel.text = [NSString stringWithFormat:@"nest view %ld",indexPath.row];
        return cell;
    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( tableView == _baseBackgroundTableView && indexPath.row == 0 ) {
        
        _showNest = true;
        _numberRow = 5;
        [self.baseBackgroundTableView reloadData];
        
        
    }
    if (tableView == _nestTableView && indexPath.row == 0) {
        
        _numberRow = 10;
        [self.baseBackgroundTableView reloadData];
    }
    
    
    
}




- (UITableView *)baseBackgroundTableView
{
    if ( _baseBackgroundTableView == nil) {
        _baseBackgroundTableView = [[UITableView  alloc]initWithFrame:self.view.frame];
        _baseBackgroundTableView.delegate = self;
        _baseBackgroundTableView.dataSource = self;
        _baseBackgroundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_baseBackgroundTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifyBase];
        
    }
    
    return _baseBackgroundTableView;
}
- (UITableView *)nestTableView
{
    if ( _nestTableView == nil) {
        _nestTableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, 100, 0)];
        _nestTableView.delegate = self;
        _nestTableView.dataSource = self;
        [_nestTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
        
    }
    
    return _nestTableView;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
