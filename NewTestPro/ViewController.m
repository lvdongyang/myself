//
//  ViewController.m
//  NewTestPro
//
//  Created by 吕东阳 on 2018/10/8.
//  Copyright © 2018 吕东阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    int a = 0 ;
    if (a == 1) {
        
    }
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 200, 30)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"hellow world";
    [self.view addSubview:titleLab];
    
    
        UIImage *image = [UIImage imageNamed:@"123"];
}


@end
