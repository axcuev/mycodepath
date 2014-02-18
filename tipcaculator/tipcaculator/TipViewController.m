//
//  TipViewController.m
//  tipcaculator
//
//  Created by Tony Cuevas on 2/17/14.
//  Copyright (c) 2014 Tony Cuevas. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmtLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (strong, nonatomic) NSArray *tipValues;
- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)setDefaultTip;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (NSArray*) tipValues {
    if( !_tipValues ) _tipValues = @[@(0.1), @(0.15), @(0.20)];
    
    return _tipValues;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self setDefaultTip];
    [self updateValues];
}

- (void) setDefaultTip
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultIndex = [defaults integerForKey:@"defaultTip"];
    [self.tipControl setSelectedSegmentIndex:defaultIndex];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmt = [self.billAmtLabel.text floatValue];
    float tipAmt = [self.tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmt;
    
    float total = billAmt + tipAmt;
    
    self.tipAmtLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmt];
    self.totalAmtLabel.text = [NSString stringWithFormat:@"$%0.2f", total];    
    
}
@end
