//
//  ChangeControllerViewController.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/17.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "ChangeControllerViewController.h"
#import "ImageViewCell.h"
#import "TestController.h"

@interface ChangeControllerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *myTableView;

@end

static NSString *const indentifier=@"cell";

@implementation ChangeControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=self.titleStr;
    
    UIButton *leftButtom=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [leftButtom setImage:[UIImage imageNamed:@"会员头像"] forState:0];
    [leftButtom addTarget:self action:@selector(openLeftVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButtom];
    
    self.myTableView= [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.myTableView.dataSource = self;
    self.myTableView.delegate  = self;
    [self.view addSubview:self.myTableView];
    [self.myTableView registerClass:[ImageViewCell class] forCellReuseIdentifier:indentifier];
    
    NSLog(@"更换页面初始化");

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate =KEYAPPDELEGATE;
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AppDelegate *tempAppDelegate =KEYAPPDELEGATE;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)openLeftVC{
    AppDelegate *tempAppDelegate = KEYAPPDELEGATE;
    if ([tempAppDelegate.LeftSlideVC closed]) {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }else{
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

#pragma mark tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENWIDTH*900/1440.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.iconImageView.image=[UIImage imageNamed:@"美女3"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestController *testVC=[[TestController alloc]init];
    testVC.hidesBottomBarWhenPushed=YES;
    testVC.titleString=self.titleStr;
    [self.navigationController pushViewController:testVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    NSLog(@"更换页面释放");
}

@end
