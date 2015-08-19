//
//  FMCalendarView.h
//  FMCalendar
//
//  Created by 范茂羽 on 15/8/19.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMCalendarViewDelegate <NSObject>


@required
//一个月的天数
-(NSInteger)lengthInMonth;

//一个月1号是星期几
-(NSInteger)ordinalityOfFirstWeekInMonth;

@end

@interface FMCalendarView : UICollectionView

@property (nonatomic, weak)id<FMCalendarViewDelegate> calendarViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)edgeInsets;

@end
