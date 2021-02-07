//
//  UIScrollingLabel.m
//  S.T.A.R.
//
//  Created by 李夙璃 on 2048/10/24.
//

#import "UIScrollingLabel.h"

#import <Masonry/Masonry.h>

@interface UIScrollingLabel ()

@property (nonatomic, readonly) UIView *contentView;

@property (nonatomic, readonly) UIView *textContainer;

@property (nonatomic, readonly) UILabel *textLabel;

@property (nonatomic, readonly) UILabel *duplicateLabel;

// Datas
@property (nonatomic, readonly) BOOL isAlwaysScrollEnable;

@property (nonatomic, readonly) CGFloat maxContentWidth;

@property (nonatomic, readonly) CGFloat textSpace;

@end

@implementation UIScrollingLabel

- (instancetype)initWithMaxContentWidth:(CGFloat)maxContentWidth
                          contentHeight:(CGFloat)contentHeight
                           contentInset:(UIEdgeInsets)contentInset
                              textSpace:(CGFloat)textSpace
                   isAlwaysScrollEnable:(BOOL)isAlwaysScrollEnable {
    NSAssert(maxContentWidth >= 0, @"%s: contentHeight ≥ 0 needed.", __FUNCTION__);
    NSAssert(contentHeight > 0, @"%s: contentHeight > 0 needed.", __FUNCTION__);
    NSAssert(textSpace >= 0, @"%s: textSpace ≥ 0 needed.", __FUNCTION__);
    NSAssert(textSpace < maxContentWidth, @"%s: textSpace < maxWidth needed.", __FUNCTION__);
    
    if (self = [super initWithFrame:CGRectZero]) {
        _isAlwaysScrollEnable = isAlwaysScrollEnable;
        _maxContentWidth = maxContentWidth;
        _textSpace = textSpace;
        
        _contentView = UIView.new;
        _contentView.layer.masksToBounds = YES;
        _textContainer = UIView.new;
        _textLabel = UILabel.new;
        _duplicateLabel = UILabel.new;
        
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(contentInset);
            make.height.mas_equalTo(contentHeight);
            make.width.mas_equalTo(0);
        }];
        
        [self.contentView addSubview:self.textContainer];
        [self.textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.contentView);
        }];

        [self.textContainer addSubview:self.textLabel];
        [self.textContainer addSubview:self.duplicateLabel];

        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self.textContainer);
        }];

        [self.duplicateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(self.textContainer);
            make.left.equalTo(self.textLabel.mas_right).offset(textSpace);
        }];
    }

    return self;
}

// MARK: - Text
- (void)setText:(NSAttributedString *)text {
    [self stopAnimation];

    self.textLabel.attributedText = text;
    self.duplicateLabel.attributedText = text;
    
    CGFloat contentWidth = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil].size.width;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MIN(contentWidth, self.maxContentWidth));
    }];
    
    [self layoutIfNeeded];
    
    if (contentWidth > self.maxContentWidth || self.isAlwaysScrollEnable) {
        [self beginAnimation:contentWidth];
    }
}

- (NSAttributedString *)text {
    return self.textLabel.attributedText;
}

// MARK: - Animation
- (void)beginAnimation:(CGFloat)contentWidth {
    [self stopAnimation];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(contentWidth + self.textSpace / 2.0);
    animation.toValue = @(-self.textSpace / 2.0);
    animation.beginTime = CACurrentMediaTime();
    animation.repeatCount = NSIntegerMax;
    animation.removedOnCompletion = NO;
    animation.duration = (contentWidth + self.textSpace) / 25.0;
    
    [self.textContainer.layer addAnimation:animation forKey:nil];
}

- (void)stopAnimation {
    [self.textContainer.layer removeAllAnimations];
}

@end
