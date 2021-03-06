//
//  RMAnnotation.h
//  MapView
//
// Copyright (c) 2008-2013, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "RMFoundation.h"

@class RMMapView, RMMapLayer, RMQuadTreeNode;

/** An RMAnnotation defines a container for annotation data to be placed on a map. At a future point in time, depending on map use, a visible layer may be requested and displayed for the annotation. The layer can be set ahead of time using the annotation's layer property, or, in the recommended approach, can be provided by an RMMapView's delegate when first needed for display. */
@interface RMAnnotation : NSObject
{
    CLLocationCoordinate2D coordinate;
    NSString *title;

    CGPoint position;
    RMProjectedPoint projectedLocation;
    RMProjectedRect  projectedBoundingBox;
    BOOL hasBoundingBox;
    BOOL enabled, clusteringEnabled;

    RMMapLayer *layer;
    RMQuadTreeNode *__weak quadTreeNode;

    // provided for storage of arbitrary user data
    id userInfo;
    NSString *annotationType;
    UIImage  *annotationIcon, *badgeIcon;
    CGPoint   anchorPoint;
}

/** @name Configuration Basic Annotation Properties */

/** The annotation's location on the map. */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/** The annotation's title. */
@property (nonatomic, strong) NSString *title;

/** The annotation's subtitle. */
@property (nonatomic, strong) NSString *subtitle;

/** Storage for arbitrary data. */
@property (nonatomic, strong) id userInfo;

/** An arbitrary string representing the type of annotation. Useful for determining which layer to draw for the annotation when requested in the delegate. Cluster annotations, which are automatically created by a map view, will automatically have an annotationType of `RMClusterAnnotation`. */
@property (nonatomic, strong) NSString *annotationType;

/** An arbitrary icon image for the annotation. Useful to pass an image at annotation creation time for use in the layer at a later time. */
@property (nonatomic, strong) UIImage *annotationIcon;
@property (nonatomic, strong) UIImage *badgeIcon;
@property (nonatomic, assign) CGPoint anchorPoint;

/** The annotation's current location on screen. Do not set this directly unless during temporary operations like annotation drags, but rather use the coordinate property to permanently change the annotation's location on the map. */
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, assign) RMProjectedPoint projectedLocation; // in projected meters
@property (nonatomic, assign) RMProjectedRect  projectedBoundingBox;
@property (nonatomic, assign) BOOL hasBoundingBox;

/** Whether touch events for the annotation's layer are recognized. Defaults to `YES`. */
@property (nonatomic, assign) BOOL enabled;

/** Whether the annotation should be clustered when map view clustering is enabled. Defaults to `YES`. */
@property (nonatomic, assign) BOOL clusteringEnabled;

/** @name Representing an Annotation Visually */

/** An object representing the annotation's visual appearance.
*   @see RMMarker
*   @see RMShape
*   @see RMCircle */
@property (nonatomic, strong) RMMapLayer *layer;

// This is for the QuadTree. Don't mess this up.
@property (nonatomic, weak) RMQuadTreeNode *quadTreeNode;

/** @name Filtering Types of Annotations */

/** Whether the annotation is related to display of the user's location. Useful for filtering purposes when providing annotation layers in the delegate. */
@property (nonatomic, readonly) BOOL isUserLocationAnnotation;

#pragma mark -

/** @name Initializing Annotations */

/** Create an initialize an annotation. 
*   @param aMapView The map view on which to place the annotation. 
*   @param aCoordinate The location for the annotation. 
*   @param aTitle The annotation's title. 
*   @return An annotation object, or `nil` if an annotation was unable to be created. */
+ (instancetype)annotationWithMapView:(RMMapView *)aMapView coordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle;

/** Initialize an annotation. 
*   @param aMapView The map view on which to place the annotation. 
*   @param aCoordinate The location for the annotation.
*   @param aTitle The annotation's title. 
*   @return An initialized annotation object, or `nil` if an annotation was unable to be initialized. */
- (id)initWithMapView:(RMMapView *)aMapView coordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle;

- (void)setBoundingBoxCoordinatesSouthWest:(CLLocationCoordinate2D)southWest northEast:(CLLocationCoordinate2D)northEast;
- (void)setBoundingBoxFromLocations:(NSArray *)locations;

#pragma mark -

/** @name Querying Annotation Visibility */

/** Whether the annotation is currently on the screen, regardless if clustered or not. */
@property (nonatomic, readonly) BOOL isAnnotationOnScreen;

/** Whether the annotation is within a certain screen bounds. 
*   @param bounds A given screen bounds. */
- (BOOL)isAnnotationWithinBounds:(CGRect)bounds;

/** Whether the annotation is currently visible on the screen. An annotation is not visible if it is either offscreen or currently in a cluster. */
@property (nonatomic, readonly) BOOL isAnnotationVisibleOnScreen;

#pragma mark -

- (void)setPosition:(CGPoint)position animated:(BOOL)animated;

#pragma mark -

// Used internally
@property (nonatomic, strong) RMMapView *mapView;

@end
