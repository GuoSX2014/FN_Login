//
//  FNViewController.m
//  FN_Login
//
//  Created by GuoSX2014 on 01/03/2019.
//  Copyright (c) 2019 GuoSX2014. All rights reserved.
//

#import "FNViewController.h"
#import <FN_Login/FNLoginViewController.h>

@interface FNViewController ()

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"hello");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(50, 30, 100, 50);
    [button addTarget:self
               action:@selector(buttonClick)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    FNLoginViewController *vc = [[FNLoginViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
