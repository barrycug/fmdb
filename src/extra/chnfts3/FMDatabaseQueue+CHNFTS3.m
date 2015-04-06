//
//  FMDatabaseQueue+CHNFTS3.m
//  mapboxgl-app
//
//  Created by Baocai Zhang on 4/6/15.
//
//

#import "FMDatabaseQueue+CHNFTS3.h"
#import "FMDatabase+CHNFTS3.h"
@implementation FMDatabaseQueue (CHNFTS3)
- (instancetype)initWithPathAndFTS3:(NSString*)aPath
{
    if (self = [self initWithPath:aPath]) {
        [_db registerFTS3];
    }
    return self;
    
}
@end
