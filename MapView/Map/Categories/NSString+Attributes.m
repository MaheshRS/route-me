//
//  NSString+Attributes.m
//  MapView
//
//  Created by Mahesh Shanbhag on 17/02/16.
//
//

#import "NSString+Attributes.h"

@implementation NSString (Attributes)

- (CGSize)sizeForFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

@end
