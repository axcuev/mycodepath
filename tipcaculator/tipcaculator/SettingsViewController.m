//
//  SettingsViewController.m
//  tipcaculator
//
//  Created by Tony Cuevas on 2/17/14.
//  Copyright (c) 2014 Tony Cuevas. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property(strong, nonatomic) NSArray* tipLabels;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSArray *)tipLabels
{
    if( !_tipLabels ) _tipLabels = @[@"10%", @"15%", @"20%"];
    return _tipLabels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    // not sure why it keeps selecting the wrong row!
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger index = [defaults integerForKey:@"defaultTip"];
    [self.picker selectRow:index inComponent:0 animated:YES]; // DEFAULT NOT SELECTED PROPERLY WHEN IT'S THE LAST ROW
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tipLabels.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return self.tipLabels[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:row forKey:@"defaultTip"];
    [defaults synchronize];
}




@end
