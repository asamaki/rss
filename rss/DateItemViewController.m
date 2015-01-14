//
//  DateItemViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/20.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "DateItemViewController.h"
#import "ItemViewController.h"

@interface DateItemViewController ()
@property (nonatomic) BOOL isShowAd;

@end

@implementation DateItemViewController{
    UIDatePicker *picker;
    UILabel *label;
    NSString *dateString;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //GA_TRACK_CLASS;
    [self initBannerAd];
    
    // UIPickerのインスタンス化
    picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    [picker addTarget:self action:@selector(pickerDidChange) forControlEvents:UIControlEventValueChanged];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    dateString = [formatter stringFromDate:picker.date];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.center            = CGPointMake(160, 340);
    label.text              = dateString;
    label.textAlignment     = NSTextAlignmentCenter;    
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 44   )];
    _button.center = CGPointMake(160, 400);
    [_button setTitle:@"検   索" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    _button.layer.borderColor = [UIColor grayColor].CGColor;
    _button.layer.borderWidth = 1.0f;
    _button.layer.cornerRadius = 7.5f;
    [_button addTarget:self action:@selector(pushTableView) forControlEvents:UIControlEventTouchDown];
    
    
    // UIPickerのインスタンスをビューに追加
    [self.view addSubview:picker];
    [self.view addSubview:_button];
    [self.view addSubview:label];
    
    [self initBannerAd];
    // Do any additional setup after loading the view.
}

-(void) pushTableView
{
    NSString *baseUrl = @"http://gazo.asamaki.com/items/json_date_app_2_0_0/";
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@%@",baseUrl,dateString,@"/"];
    NSLog(@"%@",requestUrl);
    
    ItemViewController *itemViewController = [[ItemViewController alloc]initWithUrl:requestUrl];
    [self.navigationController pushViewController:itemViewController animated:YES];
}


-(void) pickerDidChange{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
   dateString = [formatter stringFromDate:picker.date];
    
    label.text              = dateString;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

/**
 * ピッカーに表示する行数を返す
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

/**
 * 行のサイズを変更
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return 50.0;
            break;
            
        case 1: // 2列目
            return 100.0;
            break;
            
        case 2: // 3列目
            return 150.0;
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return [NSString stringWithFormat:@"%ld", (long)row];
            break;
            
        case 1: // 2列目
            return [NSString stringWithFormat:@"%ld行目", (long)row];
            break;
            
        case 2: // 3列目
            return [NSString stringWithFormat:@"%ld列-%ld行", (long)component, (long)row];
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーの選択行が決まったとき
 */
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 1列目の選択された行数を取得
    NSInteger val0 = [pickerView selectedRowInComponent:0];
    
    // 2列目の選択された行数を取得
    NSInteger val1 = [pickerView selectedRowInComponent:1];
    
    // 3列目の選択された行数を取得
    NSInteger val2 = [pickerView selectedRowInComponent:2];
    
    NSLog(@"1列目:%ld行目が選択", (long)val0);
    NSLog(@"2列目:%ld行目が選択", (long)val1);
    NSLog(@"3列目:%ld行目が選択", (long)val2);
}


- (void) initBannerAd
{
    self.isShowAd = NO;
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0,
                                                             self.view.frame.size.height,
                                                             0,
                                                             0)];
    self.nadView.delegate = self;
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    [self.nadView setNendID:@"9f847cf06b9b396bd1b31a91f44fbcf1f1c656f8" spotID:@"17064"];
    //[self.nadView setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9" spotID:@"3172"];
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
}

- (void) nadViewDidReceiveAd:(NADView *)adView;
{
    self.isShowAd = YES;
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float adViewWidth = self.nadView.frame.size.width;
    float adViewHeight = self.nadView.frame.size.height;
    [self.view bringSubviewToFront:self.nadView];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.nadView.frame = CGRectMake(0,
                                                         viewHeight - adViewHeight + statusBarHeight-self.tabBarController.tabBar.frame.size.height,
                                                         adViewWidth,
                                                         adViewHeight);
                         
                         self.nadView.alpha = 1.0;
                     }
                     completion:nil];
    [self.view addSubview:self.nadView];
}
- (void) nadViewDidFailToReceiveAd:(NADView *)adView;
{
    self.isShowAd = NO;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object t
 
 o the new view controller.
 }
 */

@end
