//
//  ViewController.m
//  MHPrettyDateExampleApp
//
//  Created by Bobby Williams on 10/2/12.
//  Copyright (c) 2012 Bobby Williams. All rights reserved.
//

#import "ViewController.h"
#import "../../MHPrettyDate/MHPrettyDate.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPicker];
//    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFormatPicker:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - initialize app

-(void) initPicker
{
    self.formatPicker.dataSource = self;
    self.formatPicker.delegate   = self;
}

-(void) initTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
}

#pragma mark - picker view data source

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

#pragma mark - picker view delegate

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* formatString;
    
    switch (row)
    {
        case MHPrettyDateFormatWithTime:
            formatString = @"MHPrettyDateFormatWithTime";
            break;
        case MHPrettyDateFormatNoTime:
            formatString = @"MHPrettyDateFormatNoTime";
            break;
        case MHPrettyDateLongFormatWithTime:
            formatString = @"MHPrettyDateLongFormatWithTime";
            break;
        case MHPrettyDateLongRelativeTime:
            formatString = @"MHPrettyDateLongRelativeTime";
            break;
        case MHPrettyDateShortRelativeTime:
            formatString = @"MHPrettyDateShortRelativeTime";
            break;
        default:
            formatString = @"bad row number";
            break;
    }
    return formatString;
}

@end
