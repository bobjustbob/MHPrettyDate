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

@property (assign, nonatomic) MHPrettyDateFormat   dateFormat;
@property (strong, nonatomic) NSMutableArray*      cellArray;
@property (strong, nonatomic) NSCalendar*          calendar;

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
   
    [self initPicker];
    [self initTableView];
}

-(void) viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   [self loadDateDataIntoArray];
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

#pragma mark - load date data into dictionary

-(void) createCellWithMinuteOffset:(NSInteger) offset andLabel:(NSString*) label
{
   NSDate* now = [NSDate date];
   UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mhpretty"];
   
   NSDateComponents* comps = [[NSDateComponents alloc] init];
   [comps setMinute: offset];
   NSDate* compareDate = [self.calendar dateByAddingComponents:comps toDate:now options:0];
   
   cell.detailTextLabel.text = [MHPrettyDate prettyDateFromDate:compareDate withFormat:self.dateFormat];
   cell.textLabel.text       = label;
   
   [self.cellArray addObject:cell];
}

-(void) createCellWithHourOffset:(NSInteger) offset andLabel:(NSString*) label
{
   NSDate* now = [NSDate date];
   UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mhpretty"];
   
   NSDateComponents* comps = [[NSDateComponents alloc] init];
   [comps setHour: offset];
   NSDate* compareDate = [self.calendar dateByAddingComponents:comps toDate:now options:0];
   
   cell.detailTextLabel.text = [MHPrettyDate prettyDateFromDate:compareDate withFormat:self.dateFormat];
   cell.textLabel.text       = label;
   
   [self.cellArray addObject:cell];
}

-(void) createCellWithDayOffset:(NSInteger) offset andLabel:(NSString*) label
{
   NSDate* now = [NSDate date];
   UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mhpretty"];
   
   NSDateComponents* comps = [[NSDateComponents alloc] init];
   [comps setDay: offset];
   NSDate* compareDate = [self.calendar dateByAddingComponents:comps toDate:now options:0];
   
   cell.detailTextLabel.text = [MHPrettyDate prettyDateFromDate:compareDate withFormat:self.dateFormat];
   cell.textLabel.text       = label;
   
   [self.cellArray addObject:cell];
}

-(void) loadDateDataIntoArray
{
   // refresh everytime so now always == now
   self.cellArray  = [[NSMutableArray alloc] init];
   
   [self createCellWithDayOffset:7 andLabel:@"next week"];
   [self createCellWithDayOffset:1 andLabel:@"tomorrow"];
   [self createCellWithDayOffset:0 andLabel:@"now"];

   [self createCellWithMinuteOffset:-1 andLabel:@"minute ago"];
   [self createCellWithMinuteOffset:-3 andLabel:@"3 minutes ago"];
   [self createCellWithMinuteOffset:-15 andLabel:@"15 minutes ago"];
   [self createCellWithMinuteOffset:-45 andLabel:@"45 minutes ago"];
   
   [self createCellWithHourOffset:-1 andLabel:@"hour ago"];
   [self createCellWithHourOffset:-3 andLabel:@"3 hours ago"];
   [self createCellWithHourOffset:-15 andLabel:@"15 hours ago"];
   [self createCellWithHourOffset:-23 andLabel:@"23 hours ago"];
   
   [self createCellWithDayOffset:-1 andLabel:@"yesterday"];
   [self createCellWithDayOffset:-2 andLabel:@"2 days ago"];
   [self createCellWithDayOffset:-3 andLabel:@"3 days ago"];
   [self createCellWithDayOffset:-4 andLabel:@"4 days ago"];
   [self createCellWithDayOffset:-5 andLabel:@"5 days ago"];
   [self createCellWithDayOffset:-6 andLabel:@"6 days ago"];
   [self createCellWithDayOffset:-7 andLabel:@"week ago"];
   [self createCellWithDayOffset:-45 andLabel:@"45 days ago"];
   
   [self.tableView reloadData];
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


-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   self.dateFormat = row;
   [self loadDateDataIntoArray];
}

#pragma mark - tableview data source

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.cellArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return ((UITableViewCell*) self.cellArray[indexPath.row]);
 }

@end
