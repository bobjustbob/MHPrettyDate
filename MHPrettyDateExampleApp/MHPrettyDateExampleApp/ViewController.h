//
//  ViewController.h
//  MHPrettyDateExampleApp
//
//  Created by Bobby Williams on 10/2/12.
//  Copyright (c) 2012 Bobby Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *formatPicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
