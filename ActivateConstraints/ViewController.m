//
//  ViewController.m
//  ActivateConstraints
//
//  Created by Matt Glover on 01/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import "ViewController.h"
#import "PersonView.h"
#import "CompanyView.h"

@interface ViewController ()
@property (nonatomic, strong) PersonView *personView;
@property (nonatomic, strong) CompanyView *companyView;
@property (nonatomic, assign) PersonViewModifyType currentModifyType;
@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    _personView = [[PersonView alloc] initWithFrame:CGRectZero];
    self.personView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.personView];
	
	_companyView = [[CompanyView alloc] initWithFrame:CGRectZero];
	self.companyView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.companyView];

    [self setupConstraints];
    [self setupModifyButton];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_personView, _companyView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_personView]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_companyView]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_personView]-[_companyView]" options:0 metrics:nil views:views]];
}

- (void)setupModifyButton {
    UIBarButtonItem *modifyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(modifyTapped:)];
    [self.navigationItem setRightBarButtonItem:modifyButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Activate Constraint";

    self.personView.nameLabel.text = @"Mickey Mouse";
    self.personView.ageLabel.text = @"150";
    self.personView.cityLabel.text = @"Dallas, TX";
    self.personView.countryLabel.text = @"United States of America";

	self.companyView.nameLabel.text = @"Walt Disney";
	self.companyView.industryLabel.text = @"Tourism and Leisure";
	self.companyView.cityLabel.text = @"Kissimmee, FL";
	self.companyView.countryLabel.text = @"United States of America";
}

#pragma mark - UIBarButton
- (void)modifyTapped:(UIBarButtonItem *)sender {
	// Update PersonView using regular enums (i.e All combinations - except Name) - Not preferred
    PersonViewModifyType type = arc4random_uniform(4);
    while (self.currentModifyType == type) {
        type = arc4random_uniform(4);
    }
    self.currentModifyType = type;
    [self.personView modifyView:type animated:YES];


	// Update CompanyView using NS_Options enums - PREFERRED
	NSUInteger companyViewOptions = arc4random_uniform(8);
	NSLog(@"%lu", companyViewOptions);
	if        (companyViewOptions == 0) {
		[self.companyView updateViewWithOptions:CompanyViewShowNone];
	} else if (companyViewOptions == 1) {
		[self.companyView updateViewWithOptions:CompanyViewShowName];
	} else if (companyViewOptions == 2) {
		[self.companyView updateViewWithOptions:CompanyViewShowIndustry];
	} else if (companyViewOptions == 3) {
		[self.companyView updateViewWithOptions:CompanyViewShowAddress];
	} else if (companyViewOptions == 4) {
		[self.companyView updateViewWithOptions:CompanyViewShowName | CompanyViewShowIndustry];
	} else if (companyViewOptions == 5) {
		[self.companyView updateViewWithOptions:CompanyViewShowName | CompanyViewShowAddress];
	} else if (companyViewOptions == 6) {
		[self.companyView updateViewWithOptions:CompanyViewShowIndustry | CompanyViewShowAddress];
	} else if (companyViewOptions == 7) {
		[self.companyView updateViewWithOptions:CompanyViewShowName | CompanyViewShowIndustry | CompanyViewShowAddress];
	}
}

@end
