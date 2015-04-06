//
//  FMDatabase+CHNFTS3.m
//  mapboxgl-app
//
//  Created by Baocai Zhang on 4/6/15.
//
//

#import "FMDatabase+CHNFTS3.h"
#include <sqlite3.h>
#include "character_tokenizer.h"

@implementation FMDatabase (CHNFTS3)
int registerTokenizer(
                             sqlite3 *db,
                             char *zName,
                             const sqlite3_tokenizer_module *p
                             ){
    int rc;
    sqlite3_stmt *pStmt;
    const char *zSql = "SELECT fts3_tokenizer(?, ?)";
    
    rc = sqlite3_prepare_v2(db, zSql, -1, &pStmt, 0);
    if( rc!=SQLITE_OK ){
        return rc;
    }
    
    sqlite3_bind_text(pStmt, 1, zName, -1, SQLITE_STATIC);
    sqlite3_bind_blob(pStmt, 2, &p, sizeof(p), SQLITE_STATIC);
    sqlite3_step(pStmt);
    
    return sqlite3_finalize(pStmt);
}
-(void)registerFTS3
{
    if (_db) {
        char token_name[] = "character";
        const sqlite3_tokenizer_module *ptr;
        get_character_tokenizer_module(&ptr);
        registerTokenizer(_db, token_name, ptr);

    }
    
}
@end
