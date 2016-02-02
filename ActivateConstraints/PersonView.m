//
//  PersonView.m
//  ActivateConstraints
//
//  Created by Matt Glover on 01/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import "PersonView.h"

static NSTimeInterval const defaultAnimationDuration = 0.4;

@interface PersonView ()
@property (nonatomic, strong, readwrite) UILabel *nameLabel;
@property (nonatomic, strong, readwrite) UILabel *ageLabel;
@property (nonatomic, strong, readwrite) UILabel *cityLabel;
@property (nonatomic, strong, readwrite) UILabel *countryLabel;

@property (nonatomic, strong) NSArray *verticalConstraintsShowAll;
@property (nonatomic, strong) NSArray *verticalConstraintsShowNameOnly;
@property (nonatomic, strong) NSArray *verticalConstraintsShowNameAndAge;
@property (nonatomic, strong) NSArray *verticalConstraintsShowNameAndAddress;

@property (nonatomic, assign, getter=isContraintsSetup) BOOL contraintsSetup;
@end

@implementation PersonView

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
    
    _ageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.ageLabel];
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.cityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.cityLabel];
    
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.countryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.countryLabel];
}

- (void)configureSubviews {
    
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.ageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.cityLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.countryLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
}

- (void)updateConstraints {
    [self updateConstraintsForTraitCollection:self.traitCollection];
    [super updateConstraints];
}

- (void)updateConstraintsForTraitCollection:(UITraitCollection *)traitCollection {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _ageLabel, _cityLabel, _countryLabel);
    
    if (!self.contraintsSetup) {
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameLabel]-|" options:0 metrics:nil views:views]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ageLabel]-|" options:0 metrics:nil views:views]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cityLabel]" options:0 metrics:nil views:views]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countryLabel]-|" options:0 metrics:nil views:views]];
        [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:self.countryLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]]];

        self.verticalConstraintsShowAll = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-[_ageLabel]-[_cityLabel]-|" options:0 metrics:nil views:views];
        self.verticalConstraintsShowNameOnly = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-|" options:0 metrics:nil views:views];
        self.verticalConstraintsShowNameAndAge = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-[_ageLabel]-|" options:0 metrics:nil views:views];
        self.verticalConstraintsShowNameAndAddress = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-[_cityLabel]-|" options:0 metrics:nil views:views];
        
        [self modifyView:PersonViewModifyTypeShowAll animated:NO];
        
        self.contraintsSetup = YES;
    }
}

- (void)modifyView:(PersonViewModifyType)type animated:(BOOL)animated {

    switch (type) {
        case PersonViewModifyTypeNameAndAge:
            self.cityLabel.hidden = YES;
            self.countryLabel.hidden = YES;
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowAll];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameOnly];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAddress];
            [NSLayoutConstraint activateConstraints:self.verticalConstraintsShowNameAndAge];
            break;
            
        case PersonViewModifyTypeNameAndAddress:
            self.ageLabel.hidden = YES;
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowAll];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameOnly];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAge];
            [NSLayoutConstraint activateConstraints:self.verticalConstraintsShowNameAndAddress];
            break;
            
        case PersonViewModifyTypeNameOnly:
            self.cityLabel.hidden = YES;
            self.countryLabel.hidden = YES;
            self.ageLabel.hidden = YES;
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowAll];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAge];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAddress];
            [NSLayoutConstraint activateConstraints:self.verticalConstraintsShowNameOnly];
            break;
            
        default:
        case PersonViewModifyTypeShowAll:
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameOnly];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAge];
            [NSLayoutConstraint deactivateConstraints:self.verticalConstraintsShowNameAndAddress];
            [NSLayoutConstraint activateConstraints:self.verticalConstraintsShowAll];
            break;
    }
    
    NSTimeInterval timeInterval = animated ? defaultAnimationDuration : 0.0;
    [UIView animateWithDuration:timeInterval
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self showSubviewsForType:type];
                     }];
}

- (void)showSubviewsForType:(PersonViewModifyType)type {
    switch (type) {
        case PersonViewModifyTypeNameAndAge:
            self.nameLabel.hidden = NO;
            self.ageLabel.hidden = NO;
            break;
            
        case PersonViewModifyTypeNameAndAddress:
            self.cityLabel.hidden = NO;
            self.countryLabel.hidden = NO;
            self.nameLabel.hidden = NO;
            break;
            
        case PersonViewModifyTypeNameOnly:
            self.nameLabel.hidden = NO;
            break;
            
        default:
        case PersonViewModifyTypeShowAll:
            self.cityLabel.hidden = NO;
            self.countryLabel.hidden = NO;
            self.nameLabel.hidden = NO;
            self.ageLabel.hidden = NO;
            break;
    }
}

@end
