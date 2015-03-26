//
//  UIView+DDTraitCollection.h
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 25/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDTraitCollection) <UITraitEnvironment>

/**
 *  @abstract Registers the calling instance for updates to it's \c UITraitCollection, via \c -traitCollectionDidChange:
 *
 *  @discussion The observer is kept with a weak ownership (in a \c strong to \c weak \c NSMapTable)
 */
- (void)dd_registerForTraitCollectionUpdates;

@end
