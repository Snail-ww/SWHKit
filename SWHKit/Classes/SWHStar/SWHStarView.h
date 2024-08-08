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

///最多星数，默认5
@property(nonatomic,assign)NSInteger starCount;
///星级评分，0-starCount(默认5)
@property(nonatomic,assign)CGFloat starScore;
///是否允许触摸改变星级   默认YES
@property(nonatomic,assign)BOOL isTouch;
///星星图片
@property(nonatomic,strong)UIImage *starImage;
///高亮星星图片
@property(nonatomic,strong)UIImage *starHighlightImage;


/**
 *  构建方法
 *  @param starSize 星星大小（默认为平分，间距是大小的一半）,默认填CGSizeZero
 *  @param starCount   最大星数
 *  @param style    类型（SWHStarTypeInteger-不允许半颗星）SWHStarTypeInteger下，star最低为1颗星
 */
- (instancetype)initWithStarSize:(CGSize)starSize
                       starCount:(NSInteger)starCount
                           style:(SWHStarType)style;

@end

NS_ASSUME_NONNULL_END
