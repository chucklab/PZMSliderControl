//
//  PZMSquareSliderControl.m
//  PZMSquareSliderControl
//
//  Created by 马超 on 2015/4/26.
//  Copyright (c) 2015 PiZiMa Studio. All rights reserved.
//

#import "PZMSquareSliderControl.h"
#import "GlobalDef.h"
#import "Masonry.h"
//#import "MMPlaceHolder.h"

@implementation PZMSquareSliderControl{
    
    // ::::BEGIN Subviews::::
    UIView
    *_bg;
    UILabel
    *_bar,
    *_leftTitle,
    *_rightTitle;
    // ::::END Subviews::::
    
    unsigned int
    _segsCount,
    _currSegIndex;
    
    float
    _segSize,
    _xrangStart,
    _xrangEnd;
    
    NSArray *_segTitlesArr;
}

#pragma mark - Main Init Msgs.
- (id)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _segTitlesArr = [titlesArr retain];
        
        const float
        v_padding    = frame.size.height * 0.1f,
        bg_w         = frame.size.width,
        bg_h         = frame.size.height - v_padding * 2.0,
        bg_x         = 0.0f,
        bg_y         = v_padding,
        bar_h        = frame.size.height,
        bar_w        = bar_h,
        bar_y        = -v_padding,
        cornerRadius = v_padding * 0.9f;
        
        _xrangStart = bar_w * 0.5;
        _xrangEnd   = bg_w - bar_w * 0.5;
        
        //_segsCount = 5;
        //_segsCount = 35;
        _segsCount = (int)_segTitlesArr.count;
        _segSize   = (_xrangEnd - _xrangStart) / ((_segsCount - 1) == 0 ? 1 : (_segsCount - 1));
        _currSegIndex = 0;
        
        _bg = [[UIView alloc]initWithFrame:CGRectMake(bg_x, bg_y, bg_w, bg_h)];
        [self addSubview:_bg];
        _bg.backgroundColor = [UIColor yellowColor];
        //_bg.clipsToBounds = YES;
        _bg.layer.cornerRadius = cornerRadius;
        
        _bar = [[UILabel alloc]initWithFrame:CGRectMake(0, bar_y, bar_w, bar_h)];
        [_bg addSubview:_bar];
        _bar.backgroundColor = [UIColor whiteColor];
        _bar.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
        _bar.layer.borderWidth = 1.0f;
        _bar.clipsToBounds = YES;
        _bar.layer.cornerRadius = cornerRadius;
        _bar.textColor = [UIColor lightGrayColor];
        _bar.font = [UIFont systemFontOfSize:12];
        _bar.textAlignment = NSTextAlignmentCenter;
        [self updateSegTitle];
        
        _leftTitle = [[UILabel alloc]initWithFrame:_bg.bounds];
        [_bg insertSubview:_leftTitle atIndex:0];
        [_leftTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.center.equalTo(_bg);
            make.width.equalTo(_bg).with.offset(-10.0f/2.0*Scale2X);
            make.height.equalTo(_bg);
        }];
        _leftTitle.backgroundColor = [UIColor clearColor];
        _leftTitle.font = [UIFont systemFontOfSize:16];
        _leftTitle.textColor = [UIColor whiteColor];
        
        _rightTitle = [[UILabel alloc]initWithFrame:_bg.bounds];
        [_bg insertSubview:_rightTitle atIndex:0];
        [_rightTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.center.equalTo(_bg);
            make.width.equalTo(_bg).with.offset(-10.0f/2.0*Scale2X);
            make.height.equalTo(_bg);
        }];
        _rightTitle.backgroundColor = [UIColor clearColor];
        _rightTitle.font = [UIFont systemFontOfSize:16];
        _rightTitle.textColor = [UIColor whiteColor];
        _rightTitle.textAlignment = NSTextAlignmentRight;
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self setSegIndex:1];
//        });
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [self initWithFrame:CGRectZero titlesArr:@[@""]];
    if (self) {
    }
    return self;
}

- (id)init{
    self = [self initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
    }
    return self;
}

#pragma mark - Publics.

- (unsigned int)currIndex{
    return _currSegIndex;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bg.backgroundColor = bgColor;
}

- (void)setLeftTitleText:(NSString *)leftTitleText rightTitleText:(NSString *)rightTitleText{
    _leftTitle.text = leftTitleText;
    _rightTitle.text = rightTitleText;
}

/*
- (void)setSegTitlesArr:(NSArray *)titlesArr{
    SAFE_RELEASE(_segTitlesArr);
    _segTitlesArr = [titlesArr retain];
}
 */

- (void)setSegIndex:(int)index{
    if (index < 0) {
        index = 0;
    }else if(index > _segsCount - 1){
        index = _segsCount - 1;
    }
    
    _currSegIndex = index;
    [self updateSegTitle];
    
    CGPoint pt_bar_center = _bar.center;
    pt_bar_center.x = _bar.bounds.size.width * 0.5 + _segSize * index;
    _bar.center = pt_bar_center;
}

- (void)adjustSegIndexWithX:(float)x{
    x -= _bar.bounds.size.width * 0.5;
    if (_segSize > -0.0000001 &&
        _segSize < +0.0000001) {
        
        [self setSegIndex:0];
    }else{
        [self setSegIndex:(((int)x + (int)(_segSize*.5f)) / (int)_segSize)];
    }
    
    [self updateSegTitle];
    
    if (self.currIndexChangedBlock)
        self.currIndexChangedBlock([self currTitleString]);
}

- (void)updateSegTitle{
    _bar.text = [self currTitleString];
}

- (NSString *)currTitleString{
    return [_segTitlesArr objectAtIndex:_currSegIndex];
}

#pragma mark - Responding to Touch Events.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [[event allTouches] anyObject];
    //CGPoint touchLocation = [touch locationInView:touch.view];
    CGPoint touchLocation = [touch locationInView:self];
    [self adjustSegIndexWithX:touchLocation.x];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [[event allTouches] anyObject];
    //CGPoint touchLocation = [touch locationInView:touch.view];
    CGPoint touchLocation = [touch locationInView:self];
    [self adjustSegIndexWithX:touchLocation.x];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    /*UITouch * touch = [[event allTouches] anyObject];*/
    //CGPoint touchLocation = [touch locationInView:touch.view];
    /*CGPoint touchLocation = [touch locationInView:self];*/
    //[self adjustSegIndexWithX:touchLocation.x];
    if (self.currIndexDidChangedBlock)
        self.currIndexDidChangedBlock([self currTitleString]);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.currIndexDidChangedBlock)
        self.currIndexDidChangedBlock([self currTitleString]);
}

#pragma mark -
- (void)dealloc{
    
    SAFE_RELEASE(_bg);
    SAFE_RELEASE(_bar);
    SAFE_RELEASE(_leftTitle);
    SAFE_RELEASE(_rightTitle);
    
    SAFE_RELEASE(_segTitlesArr);
    
    [super dealloc];
}

@end
