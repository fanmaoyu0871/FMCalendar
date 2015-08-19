//
//  ViewController.m
//  FMCalendar
//
//  Created by 范茂羽 on 15/8/19.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import "ViewController.h"
#import "FMCalendarView.h"

@interface ViewController ()<FMCalendarViewDelegate>

@property (nonatomic, strong)NSDate *curDate;

@property (nonatomic, strong)FMCalendarView *calendar;

@end

@implementation ViewController

#pragma mark - FMCalendarViewDelegate
//一个月的天数
-(NSInteger)lengthInMonth
{
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    NSRange range = [curCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.curDate];
    
    return range.length;
}

//一个月1号是星期几
-(NSInteger)ordinalityOfFirstWeekInMonth
{
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComp = [curCalendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.curDate];
    [dateComp setDay:1];
    
    NSDate *tmpDate = [curCalendar dateFromComponents:dateComp];
    
    NSInteger firstWeekDay = [curCalendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:tmpDate];
    
    return firstWeekDay-1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.curDate = [NSDate date];
    _calendar = [[FMCalendarView alloc]initWithFrame:CGRectMake(0, 64, 375, self.view.frame.size.height/2) itemSpace:20 lineSpace:20 edgeInsets:UIEdgeInsetsZero];
    _calendar.calendarViewDelegate = self;
    [self.view addSubview:_calendar];
    
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    upBtn.frame = CGRectMake(100, 500, 100, 100);
    [upBtn setTitle:@"上个月" forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upBtn];
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    downBtn.frame = CGRectMake(250, 500, 100, 100);
    [downBtn setTitle:@"下个月" forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(downBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
}

typedef NS_ENUM(NSInteger, MONTHOPERATION)
{
    PLUS,
    MINUS
};

-(void)monthOperation:(MONTHOPERATION)opt
{
    NSDate *tmpDate = self.curDate;
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [curCalendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:tmpDate];
    
    switch (opt) {
        case PLUS:
            comp.month += 1;
            if(comp.month > 12)
            {
                comp.year += 1;
                comp.month = 1;
            }
            break;
        case MINUS:
            comp.month -= 1;
            if(comp.month < 0)
            {
                comp.year -= 1;
                comp.month = 12;
            }
            break;
        default:
            break;
    }
    
    self.curDate = [curCalendar dateFromComponents:comp];
}


-(void)upBtnAction
{
    [self monthOperation:MINUS];
    [_calendar reloadData];
}

-(void)downBtnAction
{
    [self monthOperation:PLUS];
    [_calendar reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
