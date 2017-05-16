//
//  AuthViewController.m
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "AuthViewController.h"
@import WebKit;

@interface AuthViewController () <WKNavigationDelegate>

@property(strong, nonatomic) WKWebView *webView;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"URL: %@", navigationAction.request.URL.absoluteString);
    
    if ([navigationAction.request.URL.absoluteString containsString:@"access_token="]) {
//        NSLog(@"SUCCESS!!!");
//        NSLog(@"%@", navigationAction.request);
        
        NSArray *stringComponents = [navigationAction.request.URL.absoluteString componentsSeparatedByString:@"="];
        NSLog(@"ACCESS TOKEN: %@", stringComponents.lastObject);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
