//
//  PersonView.h
//  ActivateConstraints
//
//  Created by Matt Glover on 01/02/2016.
//  Copyright © 2016 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PersonViewModifyType) {
    PersonViewModifyTypeShowAll, // default
    PersonViewModifyTypeNameOnly,
    PersonViewModifyTypeNameAndAge,
    PersonViewModifyTypeNameAndAddress
};

@interface PersonView : UIView

@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *ageLabel;
@property (nonatomic, strong, readonly) UILabel *cityLabel;
@property (nonatomic, strong, readonly) UILabel *countryLabel;

- (void)modifyView:(PersonViewModifyType)type animated:(BOOL)animated;

@end
