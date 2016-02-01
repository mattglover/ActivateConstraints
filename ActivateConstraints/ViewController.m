//
//  ViewController.m
//  ActivateConstraints
//
//  Created by Matt Glover on 01/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import "ViewController.h"
#import "PersonView.h"

@interface ViewController ()
@property (nonatomic, strong) PersonView *personView;
@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    _personView = [[PersonView alloc] initWithFrame:CGRectZero];
    self.personView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.personView];
    
    [self setupConstraints];
    [self setupModifyButton];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_personView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_personView]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_personView]" options:0 metrics:nil views:views]];
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
}

#pragma mark - UIBarButton
- (void)modifyTapped:(UIBarButtonItem *)sender {
    PersonViewModifyType type = arc4random_uniform(4);
    [self.personView modifyView:type animated:YES];
}

@end
