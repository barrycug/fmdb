//
//  FTSQueryTask.h
//  mapboxgl-app
//
//  Created by Baocai Zhang on 4/6/15.
//
//

#import <Foundation/Foundation.h>

@interface FTSQueryTask : NSObject
+(instancetype)sharedInstance;
-(void)query:(NSString*)query block:(void (^)(NSArray *result))block;
@end
