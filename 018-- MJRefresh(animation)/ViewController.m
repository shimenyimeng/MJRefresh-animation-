//
//  ViewController.m
//  018-- MJRefresh(animation)
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
    
    @end

NSString *cellIdentifier = @"cellIdentifier";
@implementation ViewController {
    
    NSMutableArray *_dataListArr;
    UITableView *_tableView;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    
    _dataListArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%zd", arc4random_uniform(100)];
        [_dataListArr addObject:str];
        
    }
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<= 40; i++) {
        NSString *imageName = [NSString stringWithFormat:@"gun%03zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    }
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (int i = 1; i<= 67; i++) {
        NSString *imageName = [NSString stringWithFormat:@"showLove%03zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [pullingImages addObject:image];
    }
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<= 40; i++) {
        NSString *imageName = [NSString stringWithFormat:@"water%03zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏刷新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    _tableView.mj_header = header;
    
}

- (void)loadNewData {
    
    for (NSInteger i = 0; i < 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%zd", arc4random_uniform(100)];
        [_dataListArr addObject:str];
        
        [_tableView reloadData];
        
        [_tableView.mj_header endRefreshing];
    }
    
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataListArr.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _dataListArr[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
