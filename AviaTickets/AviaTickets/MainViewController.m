//
//  ViewController.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 12.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[DataManager sharedInstance] loadData];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)loadDataComplete
{
    self.view.backgroundColor = [UIColor yellowColor];
}

@end
