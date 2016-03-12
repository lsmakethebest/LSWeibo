


//
//  LSUnreadResult.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSUnreadResult.h"

@implementation LSUnreadResult
- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}
@end
