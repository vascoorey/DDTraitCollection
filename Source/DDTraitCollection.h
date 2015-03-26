//
//  DDTraitCollection.h
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 25/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTraitCollection : NSObject <NSCopying, NSSecureCoding>

- (BOOL)containsTraitsInCollection:(UITraitCollection *)trait;

/*! Returns a trait collection by merging the traits in `traitCollections`. The last trait along any given
 axis (e.g. interface usage) will supercede any others. */
+ (UITraitCollection *)traitCollectionWithTraitsFromCollections:(NSArray *)traitCollections;

+ (instancetype)traitCollectionForCurrentEnvironment;

+ (instancetype)traitCollectionForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

+ (UITraitCollection *)traitCollectionWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom;
@property (nonatomic, readonly) UIUserInterfaceIdiom userInterfaceIdiom; // unspecified: UIUserInterfaceIdiomUnspecified

+ (UITraitCollection *)traitCollectionWithDisplayScale:(CGFloat)scale;
@property (nonatomic, readonly) CGFloat displayScale; // unspecified: 0.0

+ (UITraitCollection *)traitCollectionWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass;
@property (nonatomic, readonly) UIUserInterfaceSizeClass horizontalSizeClass; // unspecified: UIUserInterfaceSizeClassUnspecified

+ (UITraitCollection *)traitCollectionWithVerticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass;
@property (nonatomic, readonly) UIUserInterfaceSizeClass verticalSizeClass; // unspecified: UIUserInterfaceSizeClassUnspecified

@end
