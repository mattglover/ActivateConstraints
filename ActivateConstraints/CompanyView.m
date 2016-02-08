//
//  CompanyView.m
//  ActivateConstraints
//
//  Created by Matt Glover on 04/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import "CompanyView.h"

/** With help from Stack-Overflow Question
 * http://stackoverflow.com/questions/16166895/declaring-and-checking-comparing-bitmask-enums-in-objective-c
 */

@interface CompanyView ()
@property (nonatomic, strong, readwrite) UILabel *nameLabel;
@property (nonatomic, strong, readwrite) UILabel *industryLabel;
@property (nonatomic, strong, readwrite) UILabel *cityLabel;
@property (nonatomic, strong, readwrite) UILabel *countryLabel;

@property (nonatomic, strong) NSArray *nameLabelToTopConstraints;

@property (nonatomic, strong) NSArray *industryLabelToTopConstraints;
@property (nonatomic, strong) NSArray *industryLabelTopToNameBottomConstraints;

@property (nonatomic, strong) NSArray *addressLabelToTopConstraints;
@property (nonatomic, strong) NSArray *addressLabelTopToNameBottomConstraints;
@property (nonatomic, strong) NSArray *addressLabelTopToIndustryBottomConstraints;

@property (nonatomic, strong) NSArray *currentBottomConstraints;

@property (nonatomic, assign, getter=isContraintsSetup) BOOL contraintsSetup;

@end

@implementation CompanyView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self customInit];
	}
	return self;
}

- (void)customInit {

	[self setupSubviews];
	[self configureSubviews];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureSubviews) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupSubviews {
	_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.nameLabel];

	_industryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.industryLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.industryLabel];

	_cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.cityLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.cityLabel];

	_countryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.countryLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.countryLabel];
}

- (void)configureSubviews {

	self.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0];

	self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	self.industryLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	self.cityLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	self.countryLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
}

- (void)updateConstraints {
	[self updateConstraintsForTraitCollection:self.traitCollection];
	[super updateConstraints];
}

- (void)updateConstraintsForTraitCollection:(UITraitCollection *)traitCollection {

	NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _industryLabel, _cityLabel, _countryLabel);

	if (!self.contraintsSetup) {

		[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameLabel]-|" options:0 metrics:nil views:views]];
		[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_industryLabel]-|" options:0 metrics:nil views:views]];
		[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cityLabel]" options:0 metrics:nil views:views]];
		[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countryLabel]-|" options:0 metrics:nil views:views]];
		[NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:self.countryLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]]];

		self.nameLabelToTopConstraints 					= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8@250)-[_nameLabel]" options:0 metrics:nil views:views];

		self.industryLabelToTopConstraints 			 	= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8@249)-[_industryLabel]" options:0 metrics:nil views:views];
		self.industryLabelTopToNameBottomConstraints 	= [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-(8@250)-[_industryLabel]" options:0 metrics:nil views:views];

		self.addressLabelToTopConstraints 			 	= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8@248)-[_cityLabel]" options:0 metrics:nil views:views];
		self.addressLabelTopToNameBottomConstraints  	= [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-(8@249)-[_cityLabel]" options:0 metrics:nil views:views];
		self.addressLabelTopToIndustryBottomConstraints	= [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_industryLabel]-[_cityLabel]" options:0 metrics:nil views:views];

		[self updateViewWithOptions:CompanyViewShowName | CompanyViewShowIndustry | CompanyViewShowAddress];

		self.contraintsSetup = YES;
	}
}

- (void)updateViewWithOptions:(CompanyViewShowOptions)options {

	if (options == 0) {
		NSLog(@"********************");
		NSLog(@"********************");
		NSLog(@"****  SHOW NONE  ***");
		NSLog(@"********************");
		NSLog(@"********************");
	}

	NSLog(@"********************");
	// Check all combinaions
	if (options == CompanyViewShowName) {
		NSLog(@"Show Name");
	} else if (options == CompanyViewShowIndustry) {
		NSLog(@"Show Industry");
	} else if (options == CompanyViewShowAddress) {
		NSLog(@"Show Address");
	} else if (options == (CompanyViewShowName | CompanyViewShowIndustry)) {  	// 3, 00000011
		NSLog(@"Show Name and Industry");
	}  else if (options == (CompanyViewShowName | CompanyViewShowAddress)) {   	// 5, 00000101
		NSLog(@"Show Name and Address");
	} else if (options == (CompanyViewShowIndustry | CompanyViewShowAddress)) {	// 6, 00000110
		NSLog(@"Show Industry and Address");
	} else if (options == (CompanyViewShowName | CompanyViewShowIndustry | CompanyViewShowAddress)) { // 7, 0000111
		NSLog(@"Show Name, Industry and Address");
	}

	// Check "Contains"
	if ((options & CompanyViewShowName) != 0) {
		NSLog(@"Options contain `Name`");
		[self showName:YES];
	} else {
		[self showName:NO];
	}
	if ((options & CompanyViewShowIndustry) != 0) {
		NSLog(@"Options contain `Industry`");
		[self showIndustry:YES];
	} else {
		[self showIndustry:NO];
	}	if ((options & CompanyViewShowAddress) != 0) {
		NSLog(@"Options contain `Address`");
		[self showAddress:YES];
	} else {
		[self showAddress:NO];
	}

	[self activateBottomConstraint];
}

- (void)showName:(BOOL)show {
	self.nameLabel.hidden = !show;

	if (show) {
		[NSLayoutConstraint activateConstraints:self.nameLabelToTopConstraints];
	} else {
		[NSLayoutConstraint deactivateConstraints:self.nameLabelToTopConstraints];
	}
}

- (void)showIndustry:(BOOL)show {
	self.industryLabel.hidden = !show;

	if (self.nameLabel.hidden == NO) {
		// activite to industry to name bottom constraint
		[NSLayoutConstraint activateConstraints:self.industryLabelTopToNameBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.industryLabelToTopConstraints];
	} else {
		// activate industry to top constraint
		[NSLayoutConstraint activateConstraints:self.industryLabelToTopConstraints];
		[NSLayoutConstraint deactivateConstraints:self.nameLabelToTopConstraints];
	}
}

- (void)showAddress:(BOOL)show {
	self.cityLabel.hidden = !show;
	self.countryLabel.hidden = !show;

	if (self.industryLabel.hidden == NO) {
		// activate city to industry bottom constraint
		[NSLayoutConstraint activateConstraints:self.addressLabelTopToIndustryBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelTopToNameBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelToTopConstraints];
	} else if (self.nameLabel.hidden == NO) {
		// activate city to name bottom constraint
		[NSLayoutConstraint activateConstraints:self.addressLabelTopToNameBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelTopToIndustryBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelToTopConstraints];
	} else {
		// activate city to top constraint
		[NSLayoutConstraint activateConstraints:self.addressLabelToTopConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelTopToNameBottomConstraints];
		[NSLayoutConstraint deactivateConstraints:self.addressLabelTopToIndustryBottomConstraints];
	}
}

- (void)activateBottomConstraint {
	// deactivate currentBottomConstraints
	if (self.currentBottomConstraints) {
		[NSLayoutConstraint deactivateConstraints:self.currentBottomConstraints];
	}

	// make bottom constraint to bottom-most view
	NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _industryLabel, _cityLabel);
	if (self.cityLabel.hidden == NO) {
		self.currentBottomConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cityLabel]-|" options:0 metrics:nil views:views];
	} else if (self.industryLabel.hidden == NO) {
		self.currentBottomConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_industryLabel]-|" options:0 metrics:nil views:views];
	} else if (self.nameLabel.hidden == NO) {
		self.currentBottomConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-|" options:0 metrics:nil views:views];
	} else {
		// Not sure what to do about bottom constraint when None is selected (????)
	}

	[NSLayoutConstraint activateConstraints:self.currentBottomConstraints];
}

@end
