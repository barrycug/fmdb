//
//  FTSQueryTask.m
//  mapboxgl-app
//
//  Created by Baocai Zhang on 4/6/15.
//
//

#import "FTSQueryTask.h"
#import "FMDB.h"
#import "FMDatabase+CHNFTS3.h"
#import "FMDatabaseQueue+CHNFTS3.h"
@interface FTSQueryTask()
@property(nonatomic,strong)FMDatabaseQueue *queue;
@end
@implementation FTSQueryTask
-(id)init
{
    if (self = [super init]) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"data_with_token" ofType:@"sqlite"];
        self.queue = [[FMDatabaseQueue alloc] initWithPathAndFTS3:path];
        
    }
    return self;
}
-(void)dealloc
{
    [self.queue close];
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)query:(NSString*)query block:(void (^)(NSArray *result))block
{
    NSString * queryStr = [NSString stringWithFormat:@"SELECT * FROM data_v WHERE data_v MATCH '%@'",query];
    [self.queue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *rs = [db executeQuery:queryStr];
       
        NSMutableArray * array = [NSMutableArray new];
        while ([rs next]) {
            NSString * content = [rs stringForColumnIndex:0];
            [array addObject:content];
        }
        block(array);
    }];
}

@end
