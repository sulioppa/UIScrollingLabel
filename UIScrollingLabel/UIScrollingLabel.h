//
//  UIScrollingLabel.h
//  S.T.A.R.
//
//  Created by 李夙璃 on 2048/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollingLabel : UIView

/// init
/// @param maxContentWidth 最大内容宽度
/// @param contentHeight 指定内容高度
/// @param contentInset 内容的边距
/// @param textSpace 内容中间的间距
/// @param isAlwaysScrollEnable 当内容过短时，是否还需要滚动
- (instancetype)initWithMaxContentWidth:(CGFloat)maxContentWidth
                          contentHeight:(CGFloat)contentHeight
                           contentInset:(UIEdgeInsets)contentInset
                              textSpace:(CGFloat)textSpace
                   isAlwaysScrollEnable:(BOOL)isAlwaysScrollEnable;

@property(nullable, nonatomic) NSAttributedString *text;

@end

NS_ASSUME_NONNULL_END
