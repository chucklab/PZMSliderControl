//
//  PZMSquareSliderControl.h
//  PZMSquareSliderControl
//
//  Created by 马超 on 2015/4/26.
//  Copyright (c) 2015 PiZiMa Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CurrIndexChangedBlock)(NSString *currTitle);
typedef void (^CurrIndexDidChangedBlock)(NSString *currTitle);

@interface PZMSquareSliderControl : UIControl

@property (nonatomic, copy) CurrIndexChangedBlock currIndexChangedBlock;
@property (nonatomic, copy) CurrIndexDidChangedBlock currIndexDidChangedBlock;

#pragma mark - Main Init Msgs.
- (id)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr;

#pragma mark - Publics.
- (unsigned int)currIndex;
- (NSString *)currTitleString;
- (void)setSegIndex:(int)index;
- (void)setBgColor:(UIColor *)bgColor;
- (void)setLeftTitleText:(NSString *)leftTitleText rightTitleText:(NSString *)rightTitleText;
//- (void)setSegTitlesArr:(NSArray *)titlesArr;

@end
