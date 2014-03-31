//
//  WebRequestViewController.m
//  ASIHTTPRequest
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "WebRequestViewController.h"

#define URL @"http://www.weather.com.cn/data/sk/101010200.html"

@interface WebRequestViewController ()

@end

@implementation WebRequestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  同步请求
 *
 *  @param sender sender description
 */
- (IBAction)synchronization:(id)sender {
    
    NSURL *url = [NSURL URLWithString:URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"请求数据 %@",response);
    }
}
/**
 *  异步请求
 *
 *  @param sender sender description
 */
- (IBAction)asynchronous:(id)sender {
    
    NSURL *url =[NSURL URLWithString:URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"请求数据 %@",responseString);
    
    NSData *data = [request responseData];
    NSLog(@"请求数据 %@",data);
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"请求数据 %@",error);
}



- (IBAction)blocks:(id)sender {
    
    NSURL *url = [NSURL URLWithString:URL];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSLog(@"请求数据 %@",responseString);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"请求数据 %@",error);
    }];
    [request startAsynchronous];
}

- (IBAction)queue:(id)sender {
    if (!queue) {
        queue = [[NSOperationQueue alloc]init];
    }
    NSURL *url = [NSURL URLWithString:URL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request setDidFailSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWrong:)];
    [queue addOperation:request];
}

- (IBAction)showWeather:(id)sender {
}
-(void)requestDone:(ASIHTTPRequest *)reque
{
    NSString *response = [reque responseString];
    NSLog(@"请求数据 %@",response);
}
-(void)requestWrong:(ASIHTTPRequest *)reque
{
    NSError *error = [reque error];
    NSLog(@"请求数据 %@",error);
}

- (IBAction)Return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
