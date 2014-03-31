//
//  WebRequestViewController.h
//  ASIHTTPRequest
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASIHTTPRequest.h>
#import <ASINetworkQueue.h>
@interface WebRequestViewController : UIViewController <ASIHTTPRequestDelegate>
{
    NSOperationQueue *queue;
}
- (IBAction)synchronization:(id)sender;
- (IBAction)asynchronous:(id)sender;
- (IBAction)blocks:(id)sender;
- (IBAction)queue:(id)sender;
- (IBAction)Return:(id)sender;
@end
