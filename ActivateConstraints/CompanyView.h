//
//  CompanyView.h
//  ActivateConstraints
//
//  Created by Matt Glover on 04/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CompanyViewShowOptions) {
	CompanyViewShowNone		= 0,	  // 00000000

	CompanyViewShowName 	= 1 << 0, // 1, 00000001
	CompanyViewShowIndustry = 1 << 1, // 2, 00000010
	CompanyViewShowAddress 	= 1 << 2  // 4, 00000100
};

@interface CompanyView : UIView

@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *industryLabel;
@property (nonatomic, strong, readonly) UILabel *cityLabel;
@property (nonatomic, strong, readonly) UILabel *countryLabel;

- (void)updateViewWithOptions:(CompanyViewShowOptions)options;

@end
