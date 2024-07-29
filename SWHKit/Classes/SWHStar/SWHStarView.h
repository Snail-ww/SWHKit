//
//  SWHStarView.h
//  EPProject
//
//  Created by snail on 2024/7/5.
//  Copyright © 2024 QDWL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SWHStarType) {
///整数
    SWHStarTypeInteger = 0,
///允许浮点(半颗星)
    SWHStarTypeFloat,
};

@interface SWHStarView : UIView


///回调
@property(nonatomic,copy)void(^starBlock)(NSString *value);

///星级 0-5(默认5)
@property(nonatomic,assign)CGFloat star;

///是否允许触摸改变星级   默认YES
@property(nonatomic,assign)BOOL isTouch;


/**
 *  构建方法
 *  @param starSize 星星大小（默认为平分，间距是大小的一半）,默认填CGSizeZero
 *  @param style    类型（WTKStarTypeInteger-不允许半颗星）WTKStarTypeInteger下，star最低为1颗星
 */
- (instancetype)initWithFrame:(CGRect)frame
                     starSize:(CGSize)starSize
                    withStyle:(SWHStarType)style;

@end

NS_ASSUME_NONNULL_END
