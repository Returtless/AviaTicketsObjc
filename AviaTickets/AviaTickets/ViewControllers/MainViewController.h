//
//  MainViewController.h
//  AviaTickets
//
//  Created by Владислав Лихачев on 12.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface MainViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) SecondViewController *secondViewController;
@property (nonatomic, strong) NSMutableArray *images;

@end

