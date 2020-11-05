//
//  TicketsViewController.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 25.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "TicketsViewController.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"

@interface TicketsViewController ()
@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic) BOOL fromMap;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation TicketsViewController {
    BOOL isFavorites;
    TicketTableViewCell *notificationCell;
}


- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.tickets = [NSArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        

        
        
    }
    return self;
}

- (instancetype)initWithTickets:(NSArray *)tickets fromMap:(BOOL) fromMap {
    self = [super init];
    if (self)
    {
        _tickets = tickets;
        _fromMap = fromMap;
        self.title = @"Билеты";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _tickets = [[CoreDataHelper sharedInstance] favorites];
        [self.tableView reloadData];
    }
}
-(void)viewDidLoad{
    if (isFavorites) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"из Списка", @"из Карты"]];
        [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.tintColor = [UIColor blackColor];
        self.navigationItem.titleView = _segmentedControl;
        _segmentedControl.selectedSegmentIndex = 0;
        [self changeSource];
    }
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.minimumDate = [NSDate date];
    if (@available(iOS 14.0, *)) {
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleInline;
    }
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    self.dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
    self.dateTextField.hidden = YES;
    self.dateTextField.inputView = self.datePicker;
    self.dateTextField.inputAccessoryView = keyboardToolbar;
   
    
    [self.view addSubview:self.dateTextField];
}

- (void)changeSource
{
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _tickets = [[CoreDataHelper sharedInstance] favorites];
            break;
        case 1:
            _tickets = [[CoreDataHelper sharedInstance] getFavoritesFromMap];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavorites) {
        cell.favoriteTicket = [_tickets objectAtIndex:indexPath.row];
    } else {
        cell.ticket = [_tickets objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavorites) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if ([[CoreDataHelper sharedInstance] isFavorite: [_tickets objectAtIndex:indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self->notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [self.dateTextField becomeFirstResponder];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender
{
    if (_datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", notificationCell.ticket.from, notificationCell.ticket.to, notificationCell.ticket.price];
        
        NSURL *imageURL;
        if (notificationCell.airlineLogoView.image) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                UIImage *logo = notificationCell.airlineLogoView.image;
                NSData *pngData = UIImagePNGRepresentation(logo);
                [pngData writeToFile:path atomically:YES];
                
            }
            imageURL = [NSURL fileURLWithPath:path];
        }
        
        Notification notification = NotificationMake(@"Напоминание о билете", message, _datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification:notification];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}


@end

