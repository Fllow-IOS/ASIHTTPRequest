//
//  ImageRequestViewController.m
//  ASIHTTPRequest
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "ImageRequestViewController.h"

@interface ImageRequestViewController ()

@end

@implementation ImageRequestViewController

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
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    [self.view addSubview:progressView];
    
    lable = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 250, 20)];
    [self.view addSubview:lable];
    
    imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImageView:)];
    [imageView addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dowoload:(id)sender {
    
    queue = [[ASINetworkQueue alloc]init];
    [queue reset];
    [queue setShowAccurateProgress:YES];
    [queue go];
    
    NSURL *url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=2b9b48b9eb50352ab1612208677bfaf2/2e2eb9389b504fc2c40af70be7dde71190ef6d62.jpg"];
    request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    request.downloadProgressDelegate = self;
    
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    savePath = [path stringByAppendingPathComponent:@"image.jpg"];
    
    temp = [path stringByAppendingPathComponent:@"temp"];
    tempPath = [temp stringByAppendingPathComponent:@"test"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:temp];
    if (![fileManager fileExistsAtPath:savePath]) {
        if (!fileExists) {
            [fileManager createDirectoryAtPath:temp withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [request setDownloadDestinationPath:savePath];
        [request setTemporaryFileDownloadPath:tempPath];
        request.allowResumeForFileDownloads = YES;
        
        progressView.alpha = 1.0f;
        progressView.progress = 0;
        
        [queue addOperation:request];
    }
    else
    {
        progressView.progress = 1;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *imagePath = [path stringByAppendingPathComponent:@"image.jpg"];
        NSData *data = [fileManager contentsAtPath:imagePath];
        imageView.image = [UIImage imageWithData:data];
        [self.view addSubview:imageView];
    }
    
}

-(void)setProgress:(float)newProgress
{
    progressView.progress = newProgress;
    lable.text = [NSString stringWithFormat:@"finished:%0.2f %% ",newProgress * 100];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath = [path stringByAppendingPathComponent:@"image.jpg"];
    NSData *data = [fileManager contentsAtPath:imagePath];
    imageView.image = [UIImage imageWithData:data];
    [self.view addSubview:imageView];
}
-(void)removeImageView:(UITapGestureRecognizer *)recongnizer
{
    [imageView removeFromSuperview];
}

- (IBAction)pauseAcion:(id)sender {
    [request clearDelegatesAndCancel];
}
- (IBAction)deleteAction:(id)sender {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath = [path stringByAppendingPathComponent:@"image.jpg"];
    [fileManager removeItemAtPath:imagePath error:nil];
    
}

- (IBAction)return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
