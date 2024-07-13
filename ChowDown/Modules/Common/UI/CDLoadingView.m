//
//  CDLoadingView.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/8.
//

#import "CDLoadingView.h"
#import <Masonry/Masonry.h>

static CDLoadingView *currentLoadingView;

@interface CDLoadingView ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CDLoadingView

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.containerView.layer.cornerRadius = 16.f;
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    CGSize animationSize = CGSizeMake(50, 50);
    CGFloat circleWidth = animationSize.width / 5;
    for (int i = 0; i < 5; i++) {
        CGFloat factor = i * 0.2;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(circleWidth / 2, circleWidth / 2)
                        radius:circleWidth / 2
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:NO];
        layer.backgroundColor = nil;
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.path = path.CGPath;
        layer.frame = CGRectMake(0, 0, circleWidth, circleWidth);
        
        CAAnimationGroup *animation = [self rotateAnimationWithRate:factor
                                                             center:CGPointMake(50, 50)
                                                               size:animationSize];
        [layer addAnimation:animation forKey:@"animation"];
        [self.containerView.layer addSublayer:layer];
    }
}
- (CAAnimationGroup *)rotateAnimationWithRate:(float)rate
                                    center:(CGPoint)center
                                     size:(CGSize)size {
    CGFloat duration = 1.5;
    CGFloat fromScale = 1 - rate;
    CGFloat toScale = 0.2 + rate;
    CAMediaTimingFunction *timeFunc = [CAMediaTimingFunction functionWithControlPoints:0.5 :0.15 + rate :0.25 :1];
    
    // scale animation
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = INFINITY;
    scaleAnimation.fromValue = @(fromScale);
    scaleAnimation.toValue = @(toScale);
    
    // position animation
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = duration;
    positionAnimation.repeatCount = INFINITY;
    positionAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x, center.y) radius:size.width / 2 startAngle:(3.0 * M_PI * 0.5) endAngle:(3 * M_PI * 0.5 + 2 * M_PI) clockwise:YES].CGPath;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, positionAnimation];
    group.timingFunction = timeFunc;
    group.duration = duration;
    group.repeatCount = INFINITY;
    group.removedOnCompletion = NO;

  return group;
}

+ (void)showLoading {
    if (currentLoadingView.superview) {
        [currentLoadingView removeFromSuperview];
    }
    currentLoadingView = [[CDLoadingView alloc] init];
    [[CDCommonUtils keyWindow] addSubview:currentLoadingView];
    [currentLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.mas_offset(0);
    }];
}

+ (void)dismissLoading {
    if (currentLoadingView) {
        [currentLoadingView removeFromSuperview];
        currentLoadingView = nil;
    }
}

@end
