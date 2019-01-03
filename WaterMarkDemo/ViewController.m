//
//  ViewController.m
//  WaterMarkDemo
//
//  Created by Apple on 2019/1/3.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WaterMark.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 290)];
    imgView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:imgView];
    
//    imgView.image = [imgView.image addWaterMarkText:@"Apple" textPosition:WaterMarkPositionRightBottom textFont:[UIFont systemFontOfSize:20] textColor:[UIColor redColor]];
    
    imgView.image = [imgView.image addWaterMarkImage:[UIImage imageNamed:@"apple"] imagePosition:WaterMarkPositionCenter imageWidthProportion:10 text:@"Apple" textPosition:WaterMarkPositionRightBottom textFont:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
