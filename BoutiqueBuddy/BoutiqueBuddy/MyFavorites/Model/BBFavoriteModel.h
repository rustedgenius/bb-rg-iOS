//
//  BBFavoriteModel.h
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBFavoriteModel : NSObject
{
    UIImage                 *productImage;
    NSString                 *productName;
}
@property(nonatomic, strong)UIImage                 *productImage;
@property(nonatomic, copy)NSString                   *productName;
@end
