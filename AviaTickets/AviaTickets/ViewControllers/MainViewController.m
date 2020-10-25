//
//  ViewController.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 12.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "SecondViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Главный экран"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createLabel];
    [self createStartButton];
    [self createAirplaneImageView];
    [self createAddButton];
    _images = [NSMutableArray array];
}


-(void)createLabel{
    CGRect labelFrame = CGRectMake(20.0, 40.0, [UIScreen mainScreen].bounds.size.width-20.0, [UIScreen mainScreen].bounds.size.height - 400.0);
    UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
    label.font = [UIFont systemFontOfSize:54.0 weight:UIFontWeightBold];
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Добро пожаловать!";
    label.numberOfLines = 2;
    [self.view addSubview: label];
}

-(void)createStartButton{
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, [UIScreen mainScreen].bounds.size.height/2+170, 200, 200.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Перейти к просмотру фото из массива!" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 4;
    button.titleLabel.font = [UIFont systemFontOfSize:26.0 weight:UIFontWeightBold];
    button.backgroundColor = [UIColor blueColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.tintColor = [UIColor whiteColor];
    button.frame = frame;
    button.layer.cornerRadius = button.bounds.size.width/2;
    button.clipsToBounds = true;
    [button addTarget:self action:@selector(toNextControllerButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)createAddButton{
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50.0, [UIScreen mainScreen].bounds.size.height/2+70, 100.0, 100.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Добавить фото из галереи в массив!" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 4;
    button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    button.backgroundColor = [UIColor blueColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.tintColor = [UIColor whiteColor];
    button.frame = frame;
    button.layer.cornerRadius = button.bounds.size.width/2;
    button.clipsToBounds = true;
    [button addTarget:self action:@selector(addImageToArray:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)createAirplaneImageView{
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - 75, [UIScreen mainScreen].bounds.size.width , 100);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: frame];
    imageView.image = [UIImage imageNamed:@"plane"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
}


- (void)toNextControllerButtonDidTap:(UIButton *)sender
{
    if(self.secondViewController == nil){
        SecondViewController *secondView = [[SecondViewController alloc] init];
        secondView.images = _images;
        self.secondViewController = secondView;
        
    }
    [self.navigationController pushViewController:self.secondViewController animated:YES];
}

-(void)addImageToArray:(UIButton *)sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

   UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];

    if (pickedImage) {
        [_images addObject:pickedImage];
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.toolbarHidden = YES;
    [super viewWillAppear:animated];
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
