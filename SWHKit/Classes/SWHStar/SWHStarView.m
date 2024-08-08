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
    CGFloat speacing = (self.frame.size.width -self.starCount *self.starSize.width)/self.starCount;
    for (int i =0; i<self.starCount; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithImage:self.starImage];
        starImageView.frame = CGRectMake(speacing/2 +i*(speacing +self.starSize.width), (self.frame.size.height-self.starSize.height)/2.0, self.starSize.width, self.starSize.height);
        starImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:starImageView];
        UIView *starHighlightView = [[UIView alloc]initWithFrame:CGRectMake(speacing/2 +i*(speacing +self.starSize.width), (self.frame.size.height-self.starSize.height)/2.0, self.starSize.width, self.starSize.height)];
        starHighlightView.tag = 1000+i;
        starHighlightView.layer.masksToBounds = YES;
        starHighlightView.backgroundColor = [UIColor clearColor];
        starHighlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:starHighlightView];
        starHighlightView.hidden = YES;
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
    for (index =0; index<self.starCount; index++) {
        UIView *starHighlightView = [self viewWithTag:1000 +index];
        CGRect rect = starHighlightView.frame;
        if (index <(int)score) {
            rect.size.width = self.starSize.width;
            starHighlightView.frame = rect;
            starHighlightView.hidden = NO;
        } else {
            if (score -index >0) {
                rect.size.width = self.starSize.width *(score -index);
                starHighlightView.hidden = NO;
            } else {
                rect.size.width = 0;
                starHighlightView.hidden = YES;
            }
            starHighlightView.frame = rect;
        }
        
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
    [self resetStarScore:touches];
    
}
///移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTouch)
    {
        return;
    }
    [self resetStarScore:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.starBlock) {
        self.starBlock(self.starScore);
    }
}

- (void)resetStarScore:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGFloat value = MIN(MAX(touchPoint.x, 0), self.frame.size.width) ;
    CGFloat score = touchPoint.x/self.bounds.size.width *self.starCount;
    self.starScore = score;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
