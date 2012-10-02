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

@property (assign, nonatomic) MHPrettyDateFormat dateFormat;

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
    self.dateFormat              = MHPrettyDateFormatWithTime;
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* formatLabel = (UILabel*) view;
    
    if (!formatLabel)
    {
        formatLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0,
                                [pickerView rowSizeForComponent:component].width,
                                [pickerView rowSizeForComponent:component].height)];
        formatLabel.font = [UIFont boldSystemFontOfSize:16.0];
    }
    
    switch (row)
    {
        case MHPrettyDateFormatWithTime:
            formatLabel.text = @"MHPrettyDateFormatWithTime";
            break;
        case MHPrettyDateFormatNoTime:
            formatLabel.text = @"MHPrettyDateFormatNoTime";
            break;
        case MHPrettyDateLongFormatWithTime:
            formatLabel.text = @"MHPrettyDateLongFormatWithTime";
            break;
        case MHPrettyDateLongRelativeTime:
            formatLabel.text = @"MHPrettyDateLongRelativeTime";
            break;
        case MHPrettyDateShortRelativeTime:
            formatLabel.text = @"MHPrettyDateShortRelativeTime";
            break;
        default:
            formatLabel.text = @"bad row number";
            break;
    }
    
    return formatLabel;
}

//-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString* formatString;
//    
//    switch (row)
//    {
//        case MHPrettyDateFormatWithTime:
//            formatString = @"MHPrettyDateFormatWithTime";
//            break;
//        case MHPrettyDateFormatNoTime:
//            formatString = @"MHPrettyDateFormatNoTime";
//            break;
//        case MHPrettyDateLongFormatWithTime:
//            formatString = @"MHPrettyDateLongFormatWithTime";
//            break;
//        case MHPrettyDateLongRelativeTime:
//            formatString = @"MHPrettyDateLongRelativeTime";
//            break;
//        case MHPrettyDateShortRelativeTime:
//            formatString = @"MHPrettyDateShortRelativeTime";
//            break;
//        default:
//            formatString = @"bad row number";
//            break;
//    }
//    return formatString;
//}

@end
