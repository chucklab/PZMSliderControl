//
//  ViewController.m
//  PZMSliderControl_Example
//
//  Created by 马超 on 2015/5/22.
//  Copyright (c) 2015 Pizima's Studio. All rights reserved.
//

#import "ViewController.h"
#import "GlobalDef.h"
#import "PZMSquareSliderControl.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColorFromRGB(0xfdff61);
    
    NSMutableArray *titlesArr = [[[NSMutableArray alloc]init]autorelease];
    for (int i=100; i<=2000; i+=100) {
        NSString *t = [NSString stringWithFormat:@"%d", i];
        [titlesArr addObject:t];
    }
    PZMSquareSliderControl *ssc = [[[PZMSquareSliderControl alloc]initWithFrame:CGRectMake(10.0f, 100.0f, DEF_SCREEN_WIDTH-20.0f, 40.0f)
                                                                      titlesArr:titlesArr]autorelease];
    [self.view addSubview:ssc];
    [ssc setBgColor:UIColorFromRGB(0x7ad0ff)];
    [ssc setLeftTitleText:@"$100" rightTitleText:[NSString stringWithFormat:@"$%d", 2000]];
    
    ssc.currIndexChangedBlock = ^(NSString *currTitle){
        NSLog(@"Current Index Changed To Title:%@", currTitle);
    };
    ssc.currIndexDidChangedBlock = ^(NSString *currTitle){
        NSLog(@"Current Index Did Changed To Title:%@", currTitle);
    };
    ssc.currIndexCanChangedBlock = ^(int targetIndex){
        
        if (targetIndex > 3) {
            return NO;
        }
        
        return YES;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)dealloc{
    [super dealloc];
}

@end
