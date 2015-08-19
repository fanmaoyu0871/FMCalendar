//
//  FMCalendarView.m
//  FMCalendar
//
//  Created by 范茂羽 on 15/8/19.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import "FMCalendarView.h"

@interface FMCalendarCell : UICollectionViewCell

@property (nonatomic, weak)UILabel *numlabel;

@end

@implementation FMCalendarCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        _numlabel = label;
        [self.contentView addSubview:_numlabel];
    }
    
    return self;
}

@end


#define CELLID @"FMCalendarCellID"


@interface FMCalendarView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation FMCalendarView

-(instancetype)initWithFrame:(CGRect)frame itemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)edgeInsets
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = itemSpace;
    layout.minimumLineSpacing = lineSpace;
    
    //row * column : 6 * 7
    CGFloat itemW = (frame.size.width - edgeInsets.left - edgeInsets.right - 6*itemSpace)/7.0;
    layout.itemSize = CGSizeMake(itemW, itemW); //正方形好看点
    
    
    if(self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        [self registerCell];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)registerCell
{
    [self registerClass:[FMCalendarCell class] forCellWithReuseIdentifier:CELLID];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if(self.calendarViewDelegate)
    {
        num = [self.calendarViewDelegate lengthInMonth] + [self.calendarViewDelegate ordinalityOfFirstWeekInMonth];
    }
    
    return num;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMCalendarCell *cell = nil;
    
    if(self.delegate)
    {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
        NSInteger startNum = [self.calendarViewDelegate ordinalityOfFirstWeekInMonth];
        
        cell.backgroundColor = indexPath.item >= startNum?[UIColor orangeColor] : [UIColor whiteColor];
        
        NSString *numStr = [NSString stringWithFormat:@"%ld", indexPath.item - startNum + 1];
        cell.numlabel.text = indexPath.item >= startNum?numStr : @"";
    }
    return cell;
}




@end
