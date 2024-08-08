//
//  SWHRotateClockView.m
//  
//
//  Created by snail on 2024/7/16.
//  Copyright © 2024 Snail. All rights reserved.
//

#import "SWHRotateClockView.h"
#import "YYKit.h"
#import "Masonry.h"

@interface SWHClockNumView : UIView

- (instancetype)initWithNumStr:(NSString *)numStr size:(CGFloat)size;
@property (nonatomic, assign)CGFloat size;
@property (nonatomic, strong)NSString *numStr;

@end


@implementation SWHClockNumView

- (instancetype)initWithNumStr:(NSString *)numStr size:(CGFloat)size
{
    self = [super init];
    if (self) {
        _size = size;
        _numStr = numStr;
        [self creatBgViewWithNumStr:numStr];
        
        
    }
    return self;
}

- (void)creatBgViewWithNumStr:(NSString *)numStr {
    self.layer.cornerRadius = self.size/10.0;
    UILabel *preLab;
    for (int i=0; i<numStr.length; i++) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:self.size *3.5/5];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = [numStr substringWithRange:NSMakeRange(numStr.length -i-1, 1)];
        lab.tag = 1000+i;
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (preLab) {
                make.right.equalTo(preLab.mas_left).offset(0);
            } else {
                make.right.offset(-self.size *0.1);
            }
            make.top.offset(self.size *0.1);
            make.bottom.offset(-self.size *0.1);
            make.width.mas_equalTo(self.size *0.8/2.0);
            make.height.mas_equalTo(self.size *0.8);
            make.left.mas_greaterThanOrEqualTo(self.size *0.1);
        }];
        preLab = lab;
    }
}

- (void)setNumStr:(NSString *)numStr {
    if ([_numStr isEqualToString:numStr]) {
        return;
    }
    if (numStr.length > _numStr.length) { // 需要新增lab
        UILabel *preLab = [self viewWithTag:1000+_numStr.length -1];
        for (NSInteger i=_numStr.length; i<numStr.length; i++) {
            UILabel *lab = [[UILabel alloc]init];
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont systemFontOfSize:self.size *4.0/5];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"0";
            lab.tag = 1000+i;
            [self addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preLab) {
                    make.right.equalTo(preLab.mas_left).offset(0);
                } else {
                    make.right.offset(-self.size *0.1);
                }
                make.top.offset(self.size *0.1);
                make.bottom.offset(-self.size *0.1);
                make.width.mas_equalTo(self.size*0.8/2.0);
                make.height.mas_equalTo(self.size*0.8);
                make.left.mas_greaterThanOrEqualTo(self.size *0.1);
            }];
            preLab = lab;
        }
    } else if (_numStr.length > numStr.length) { // 需要移除lab
        for (NSInteger i=numStr.length; i<_numStr.length; i++) {
            UILabel *lab = [self viewWithTag:1000+i];
            if (lab) {
                [lab removeFromSuperview];
            }
        }
    }
    _numStr = numStr;
    for (NSInteger i=0; i<numStr.length; i++) {
        UILabel *lab = [self viewWithTag:1000+i];
        if (lab) {
            lab.text = [numStr substringWithRange:NSMakeRange(numStr.length -i-1, 1)];
        }
    }
}


@end


@interface SWHClockNumAnimateView : UIView <CAAnimationDelegate>

- (instancetype)initWithNumStr:(NSString *)numStr size:(CGFloat)size;
@property (nonatomic, assign)CGFloat size;
@property (nonatomic, strong)NSString *numStr;
- (void)updateNumStr:(NSString *)numStr animate:(BOOL)animate;

@property (nonatomic, strong)SWHClockNumView *numView;

@property (nonatomic, strong)SWHClockNumView *oldTopView;
@property (nonatomic, strong)SWHClockNumView *oldBottomView;
@property (nonatomic, strong)SWHClockNumView *neTopView;

@end


@implementation SWHClockNumAnimateView

- (instancetype)initWithNumStr:(NSString *)numStr size:(CGFloat)size
{
    self = [super init];
    if (self) {
        _size = size;
        _numStr = numStr;
        [self setupUI];
        
    }
    return self;
}
- (void)setupUI {
    self.layer.cornerRadius = self.size/10.0;
    SWHClockNumView *numView = [[SWHClockNumView alloc]initWithNumStr:_numStr size:_size];
    [self addSubview:numView];
    [numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.numView = numView;
    
    //贝塞尔曲线 画一个带有圆角的矩形
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.size *self.numStr.length/2.0, self.size *5.0/11)];
    [bpath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, self.size *6.0/11, self.size *self.numStr.length/2.0, self.size *5.0/11)]];
    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    //添加图层蒙板
    self.layer.mask = shapeLayer;
}


- (void)setNumStr:(NSString *)numStr {
    _numStr = numStr;
    //贝塞尔曲线 画一个带有圆角的矩形
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.size *numStr.length/2.0, self.size *5.0/11)];
    [bpath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, self.size *6.0/11, self.size *numStr.length/2.0, self.size *5.0/11)]];
    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    //添加图层蒙板
    self.layer.mask = shapeLayer;
    self.numView.numStr = numStr;
}

- (void)updateNumStr:(NSString *)numStr animate:(BOOL)animate {
    if ([_numStr isEqualToString:numStr]) {
        return;
    }
    if (animate) {
        NSString *old = self.numStr;
        NSString *new = numStr;
        if (numStr.length >self.numStr.length) {    // 新的值比较长先补位
            old = [NSString stringWithFormat:[NSString stringWithFormat:@"%%.%ldld",numStr.length],self.numStr.integerValue];
            self.numStr = old;
        } else if (numStr.length <self.numStr.length) { // 旧的值比较长，新视图先补位后减位
            new = [NSString stringWithFormat:[NSString stringWithFormat:@"%%.%ldld",self.numStr.length],numStr.integerValue];
        }
        if (!_oldTopView) {
            UIView *oldTopBgView = [[UIView alloc]init];
            oldTopBgView.backgroundColor = [UIColor clearColor];
            oldTopBgView.layer.masksToBounds = YES;
            self.oldTopView = [[SWHClockNumView alloc]initWithNumStr:old size:self.size];
            self.oldTopView.backgroundColor = self.backgroundColor;
            [oldTopBgView addSubview:self.oldTopView];
            [self.oldTopView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.and.right.offset(0);
                make.bottom.offset(self.size/2.0);
            }];
            [self addSubview:oldTopBgView];
            [oldTopBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
            }];
        }
        if (!_oldBottomView) {
            UIView *oldBottomBgView = [[UIView alloc]init];
            oldBottomBgView.backgroundColor = [UIColor clearColor];
            oldBottomBgView.layer.anchorPoint = CGPointMake(0, 0);
            oldBottomBgView.layer.masksToBounds = YES;
            self.oldBottomView = [[SWHClockNumView alloc]initWithNumStr:old size:self.size];
            self.oldBottomView.backgroundColor = self.backgroundColor;
            [oldBottomBgView addSubview:self.oldBottomView];
            [self.oldBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.and.left.and.right.offset(0);
                make.top.offset(-self.size/2.0);
            }];
            [self addSubview:oldBottomBgView];
            [oldBottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.and.right.offset(0);
            }];
        }
        if (!_neTopView) {
            UIView *neTopBgView = [[UIView alloc]init];
            neTopBgView.backgroundColor = [UIColor clearColor];
            neTopBgView.layer.anchorPoint = CGPointMake(0, 1);
            neTopBgView.layer.masksToBounds = YES;
            self.neTopView = [[SWHClockNumView alloc]initWithNumStr:new size:self.size];
            self.neTopView.backgroundColor = self.backgroundColor;
            [neTopBgView addSubview:self.neTopView];
            [self.neTopView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.and.right.offset(0);
                make.bottom.offset(self.size/2.0);
            }];
            [self addSubview:neTopBgView];
            [neTopBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
            }];
            
        }
        [self layoutIfNeeded];
        // 显示层级处理
        self.oldTopView.superview.layer.zPosition=0.01;
        self.neTopView.superview.layer.zPosition=0.1;
        self.oldBottomView.superview.layer.zPosition=0.2;
        
        self.neTopView.superview.layer.position = CGPointMake(0, self.size/2.0);
        self.oldBottomView.superview.layer.position = CGPointMake(0, self.size/2.0);
        //
        self.oldTopView.numStr = old;
        self.oldBottomView.numStr = old;
        self.neTopView.numStr = new;
        self.oldTopView.alpha = 1;
        self.oldBottomView.alpha = 1;
        self.neTopView.alpha = 1;
        self.numStr = new;
        // 开始动画
        self.oldBottomView.superview.layer.transform = CATransform3DIdentity;
        self.neTopView.superview.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        [UIView animateWithDuration:0.6 animations:^{
            self.oldBottomView.superview.layer.transform = CATransform3DMakeRotation(-M_PI, 1, 0, 0);
            self.neTopView.superview.layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
        } completion:^(BOOL finished) {
            self.neTopView.alpha = 0;
            self.oldTopView.alpha = 0;
            self.oldBottomView.alpha = 0;
            self.numStr = numStr;       // 针对前面补位，动画结束后减位的
        }];
        // 新旧上下更换上下层
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.oldBottomView.superview.layer.zPosition=0.1;
            self.neTopView.superview.layer.zPosition=0.2;
        });
        
    } else {
        self.numStr = numStr;
    }
    
}



@end



@interface SWHRotateClockView()

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)CADisplayLink *displayLink;

@property (nonatomic, strong)UIStackView *stackView;

@property (nonatomic, strong)NSString *format;

@property (nonatomic, strong)NSArray <NSString *>*numStrArray;

@property (nonatomic, strong)NSArray <NSString *>*spacingStrArray;

@property (nonatomic, assign)SWHRotateClockType type;

@end



@implementation SWHRotateClockView

- (void)dealloc
{
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


// 倒计时结束时间
- (instancetype)initWithTimeInterval:(NSInteger)timeInterval
{
    self = [super init];
    if (self) {
        _type =SWHRotateClockType_Countdown;
        _size = 18;
        self.timeInterval = timeInterval;
        [self setupUI];
        [self initTimer];
    }
    return self;
}
- (instancetype)initWithEndDate:(NSDate *)endDate
{
    self = [super init];
    if (self) {
        _type =SWHRotateClockType_Countdown;
        _size = 18;
        self.timeInterval = [endDate timeIntervalSinceNow];
        [self setupUI];
        [self initTimer];
    }
    return self;
}

// 时钟
- (instancetype)initWithFormat:(NSString *)format
{
    self = [super init];
    if (self) {
        _type =SWHRotateClockType_Default;
        _size = 18;
        _spacing = 0;
        _format = format;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"ss,mm,HH"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        self.numStrArray = [dateStr componentsSeparatedByString:@","];
        [self setupUI];
        [self initTimer];
    }
    return self;
}





- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    if (timeInterval < 0) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    if (timeInterval == 0) {
        self.hidden = YES;
        // 回调
    }
    NSInteger second = ((NSInteger)timeInterval)%60;
    NSInteger min = ((NSInteger)timeInterval)/60;
    NSInteger hour = min/60;
    min = min%60;
    self.numStrArray = @[[NSString stringWithFormat:@"%.2ld", (long)second],[NSString stringWithFormat:@"%.2ld", (long)min],[NSString stringWithFormat:@"%.2ld", (long)hour]];
    
    
}


- (void)tintColorDidChange {
    [super tintColorDidChange];
    if (self.stackView) {
        for (UIView *view in self.stackView.arrangedSubviews) {
            if ([view isKindOfClass:[SWHClockNumAnimateView class]]) {
                view.backgroundColor = self.tintColor;
            } else if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lab =(UILabel *)view;
                lab.textColor = self.tintColor;
            }
        }
    }
}

- (void)setSize:(CGFloat)size {
    _size = size;
    [self removeAllSubviews];
    [self setupUI];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    if (self.stackView) {
        for (UIView *view in self.stackView.arrangedSubviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lab =(UILabel *)view;
                [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(UIEdgeInsetsZero);
                    if (spacing == 0) {
                        make.left.offset(3);
                        make.right.offset(-3);
                    } else {
                        make.width.mas_greaterThanOrEqualTo(spacing);
                    }
                    make.height.mas_equalTo(self.size);
                }];
            }
        }
    }
}


- (void)setupUI {
    self.tintColor = [UIColor colorWithHexString:@"2E2C27"];
    NSMutableArray <UIView *>*array = [NSMutableArray array];
    for (int i = 0; i<self.numStrArray.count; i++) {
        NSString *numStr = [self.numStrArray objectAtIndex:i];
        SWHClockNumAnimateView *bgView = [[SWHClockNumAnimateView alloc]initWithNumStr:numStr size:self.size];
        bgView.backgroundColor = self.tintColor;
        [array insertObject:bgView atIndex:0];
        if (i < self.numStrArray.count-1) {
            UIView *spacingView =[self creatSpacingView];
            [array insertObject:spacingView atIndex:0];
        }
    }
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:array];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 0;
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.stackView = stackView;
}

- (void)initTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction:)];
    self.displayLink.preferredFramesPerSecond = 1;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)reloadData:(BOOL)animate {
    for (NSInteger i = 0; i<self.numStrArray.count; i++) {
        NSString *numStr = self.numStrArray[i];
        SWHClockNumAnimateView *numView;
        if (i<(self.stackView.arrangedSubviews.count +1)/2) {
            numView = [self.stackView.arrangedSubviews objectAtIndex:(self.numStrArray.count-i-1)*2];
            if ([numView isKindOfClass:[SWHClockNumAnimateView class]]) {
                [numView updateNumStr:numStr animate:animate];
            }
        } else {
            UIView *spacingView =[self creatSpacingView];
            [self.stackView insertSubview:spacingView atIndex:0];
            numView = [[SWHClockNumAnimateView alloc]initWithNumStr:numStr size:self.size];
            numView.backgroundColor = self.tintColor;
            [self.stackView insertSubview:numView atIndex:0];
        }
    }
}

- (void)timerAction:(NSTimer *)timer {
    if (self.type == SWHRotateClockType_Default) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"ss,mm,HH"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        self.numStrArray = [dateStr componentsSeparatedByString:@","];
        [self reloadData:YES];
    } else if (self.type == SWHRotateClockType_Countdown) {
        self.timeInterval = self.timeInterval -1;
        [self reloadData:YES];
    }
}




- (UIView *)creatSpacingView {
    UIView *spacingView = [[UIView alloc]init];
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = self.tintColor;
    lab.text =@":";
    lab.font = [UIFont systemFontOfSize:self.size *4.0/5 weight:UIFontWeightBold];
    lab.textAlignment = NSTextAlignmentCenter;
    [spacingView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        if (self.spacing == 0) {
            make.left.offset(3);
            make.right.offset(-3);
        } else {
            make.width.mas_greaterThanOrEqualTo(self.spacing);
        }
        make.height.mas_equalTo(self.size);
    }];
    return spacingView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end




