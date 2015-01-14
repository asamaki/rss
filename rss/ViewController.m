//
//  ViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/10/16.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "ViewController.h"
#import "EFRHatenaParser.h"
#import "EFRDetailViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
            
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSLog(@"%@",[EFRHatenaParser parseResultWithCategoryName:@"it"]);
    self.title = @"はてぶホットエントリーIT";
    self.articles = [EFRHatenaParser parseResultWithCategoryName:@"it"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.articles[indexPath.row][TITLE];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    
    EFRDetailViewController *detailViewController = [[EFRDetailViewController alloc] init];
    detailViewController.articleDic = self.articles[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
