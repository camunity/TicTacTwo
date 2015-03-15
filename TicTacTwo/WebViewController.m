//
//  WebViewController.m
//  TicTacTwo
//
//  Created by Cameron Flowers on 3/14/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *helpWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helpWebView.delegate = self; // these delegates tell app to do its job
    NSString *http = @"http://www.en.wikipedia.org/wiki/Tic-tac-toe";
    NSURL *url = [NSURL URLWithString:http];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.helpWebView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}


@end
