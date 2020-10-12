//
//  SecondViewController.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 12.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     CGRect labelFrame = CGRectMake(20.0, [UIScreen mainScreen].bounds.size.height / 2 - 100, [UIScreen mainScreen].bounds.size.width-20.0, 300);
       UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
       label.font = [UIFont systemFontOfSize:36.0 weight:UIFontWeightBold];
       label.textColor = [UIColor orangeColor];
       label.textAlignment = NSTextAlignmentCenter;
       label.text = @"Скоро тут будут билеты!";
       label.numberOfLines = 2;
       [self.view addSubview: label];
}

@end
