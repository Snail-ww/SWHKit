//
//  SWHRotateClockView.h
//  毫秒倒计时
//
//  Created by snail on 2024/7/16.
//  Copyright © 2024 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SWHRotateClockType) {
    SWHRotateClockType_Default,      // 时钟
    SWHRotateClockType_Countdown  =1,    // 倒计时
};


@interface SWHRotateClockView : UIView
// 倒计时结束时间
- (instancetype)initWithTimeInterval:(NSInteger)timeInterval;
- (instancetype)initWithEndDate:(NSDate *)endDate;
// 时钟
- (instancetype)initWithFormat:(NSString *)format;

@property (nonatomic, assign)CGFloat size;
@property (nonatomic, assign)CGFloat spacing; // 0表示不设置自动间距
// 倒计时剩余时间（s）
@property (nonatomic, assign)NSTimeInterval timeInterval;
- (void)reloadData:(BOOL)animate;

@end




NS_ASSUME_NONNULL_END
