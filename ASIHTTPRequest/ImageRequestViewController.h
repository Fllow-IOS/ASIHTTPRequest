//
//  ImageRequestViewController.h
//  ASIHTTPRequest
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASIHTTPRequest.h>
#import <ASINetworkQueue.h>
@interface ImageRequestViewController : UIViewController <ASIProgressDelegate, ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *request;
    ASINetworkQueue *queue;
    UIProgressView *progressView;
    
    NSString *path;
    NSString *savePath;
    NSString *temp;
    NSString *tempPath;
    
    UILabel *lable;
    UIImageView *imageView;
}
- (IBAction)dowoload:(id)sender;
- (IBAction)pauseAcion:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)return:(id)sender;
@end
