//
//  SWHStarView.m
//  EPProject
//
//  Created by snail on 2024/7/5.
//  Copyright © 2024 QDWL. All rights reserved.
//

#import "SWHStarView.h"

#define WHITE_NAME @"w_star_hollow"
#define RED_NAME @"w_star_solid"

@interface SWHStarView ()


@property(nonatomic,assign)SWHStarType      starType;

@property(nonatomic,assign)CGSize           starSize;

@property(nonatomic,strong)NSMutableArray   *starArray;

@property(nonatomic,assign)CGFloat          width;
@property(nonatomic,assign)CGFloat          height;
@property(nonatomic,assign)CGFloat          lineMargin;
@property(nonatomic,assign)CGFloat          listMargin;

@property(nonatomic,strong)UIView           *foreView;
@property(nonatomic,strong)UIView           *bgView;

@end

@implementation SWHStarView


- (instancetype)initWithStarSize:(CGSize)starSize
                       starCount:(NSInteger)starCount
                           style:(SWHStarType)style
{
    if (self = [super init])
    {
        self.bounds = CGRectMake(0, 0, starSize.width *starCount *2, starSize.height);
        _starCount = starCount;
        _starType = style;
        _starSize = starSize;
        _isTouch = YES;
        NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"images"ofType :@"bundle"];

        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        _starImage = [UIImage imageNamed:@"w_star_hollow" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        _starHighlightImage = [UIImage imageNamed:@"w_star_solid" inBundle:resourceBundle compatibleWithTraitCollection:nil];
        [self initView];
    }
    return self;
}

#pragma mark - 初始化
- (void)initView
{
    self.starArray      = [NSMutableArray array];
    CGFloat speacing = (self.frame.size.width -self.starCount *self.starSize.width)/self.starCount;
    for (int i =0; i<self.starCount; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithImage:self.starImage];
        starImageView.frame = CGRectMake(speacing/2 +i*(speacing +self.starSize.width), (self.frame.size.height-self.starSize.height)/2.0, self.starSize.width, self.starSize.height);
        starImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:starImageView];
        UIView *starHighlightView = [[UIView alloc]initWithFrame:CGRectMake(speacing/2 +i*(speacing +self.starSize.width), (self.frame.size.height-self.starSize.height)/2.0, 0, self.starSize.height)];
        starHighlightView.tag = 1000+i;
        starHighlightView.layer.masksToBounds = YES;
        starHighlightView.backgroundColor = [UIColor clearColor];
        starHighlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:starHighlightView];
        UIImageView *starHighlightImageView = [[UIImageView alloc]initWithImage:self.starHighlightImage];
        starHighlightImageView.frame = CGRectMake(0, 0, self.starSize.width, self.starSize.height);
        [starHighlightView addSubview:starHighlightImageView];
    }
    
}

#pragma mark - SET
- (void)setStarScore:(CGFloat)starScore
{
    CGFloat score = MAX(0, MIN(self.starCount, starScore));
    if (self.starType == SWHStarTypeInteger) {
        score = round(score);
    }
    NSInteger index = 0;
    for (index =0; index<(int)score; index++) {
        UIView *starHighlightView = [self viewWithTag:1000 +index];
        CGRect rect = starHighlightView.frame;
        rect.size.width = self.starSize.width;
        starHighlightView.frame = rect;
    }
    if (score -index >0) {
        UIView *starHighlightView = [self viewWithTag:1000 +index +1];
        CGRect rect = starHighlightView.frame;
        rect.size.width = self.starSize.width *(score -index);
        starHighlightView.frame = rect;
    }
}


#pragma mark - touch
///点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTouch)
    {
        return;
    }
    if(self.starType == SWHStarTypeInteger)
    {
        [self resetIntegerStar:touches];
    }
    else
    {
        [self resetFloatStar:touches];
    }
    
}
///移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTouch)
    {
        return;
    }
    if(self.starType == SWHStarTypeInteger)
    {
        [self resetIntegerStar:touches];
    }
    else
    {
        [self resetFloatStar:touches];
    }
}

- (void)resetFloatStar:(NSSet<UITouch *> *)touches
{

    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint starPoint;
    int flag = 0;//判断是否已经调用block
    CGFloat star = 0;
    
    if (touchPoint.x >= 0 && touchPoint.x < self.frame.size.width && touchPoint.y >= 0 && touchPoint.y < self.frame.size.height)
    {
        for (int i = 0; i < 5; i++)
        {
            UIImageView *img = self.starArray[i];
                starPoint = [touch locationInView:img];
                if (starPoint.x >= 0 && starPoint.x <= self.width)
                {///在星星上
                    CGFloat value = starPoint.x / self.width;
                    self.foreView.frame = CGRectMake(0, 0, img.frame.origin.x + value * self.width, self.frame.size.height);
                    if(flag == 0 && self.starBlock)
                    {
                        self.starBlock([NSString stringWithFormat:@"%.1f",i + value]);
                    }
                    flag++;
                }
                else
                {
                    self.foreView.frame = CGRectMake(0, 0, touchPoint.x, self.frame.size.height);
                    if (touchPoint.x > img.frame.origin.x)
                    {
                        star = i + 1;
                    }
                }
        }
        if (flag == 0 && self.starBlock)
        {
            //       没有调用block，当前点击不在星星上
            self.starBlock([NSString stringWithFormat:@"%.1f",star]);
        }
    }
    
    
}

- (void)resetIntegerStar:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSInteger star = 0;
    for (int i = 0; i < 5; i++)
    {
        UIImageView *img = self.starArray[i];
        if (touchPoint.x >= 0 && touchPoint.x < self.frame.size.width && touchPoint.y >= 0 && touchPoint.y < self.frame.size.height)
        {
            if (img.frame.origin.x > touchPoint.x)
            {
                img.image = [UIImage imageNamed:WHITE_NAME];
            }
            else
            {
                img.image = [UIImage imageNamed:RED_NAME];
                star++;
            }
        }
    }
    if (self.starBlock)
    {
        self.starBlock([NSString stringWithFormat:@"%ld",star]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
