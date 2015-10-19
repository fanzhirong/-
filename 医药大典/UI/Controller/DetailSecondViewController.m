//
//  DetailSecondViewController.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "DetailSecondViewController.h"
#import "DetailFirstBean.h"
#import <UIImageView+WebCache.h>
#import <UMSocial.h>
@interface DetailSecondViewController ()<UIWebViewDelegate,UIScrollViewDelegate>


@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,assign)CGFloat previousHeight;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,strong)UIWebView *webview;
@end

@implementation DetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setWebView];
   
}

-(void)setWebView
{
    DetailFirstBean *bean = self.object;
    
    _webview = [[UIWebView alloc]init];
    _webview.frame = (CGRect){0,0, self.view.bounds.size.width, self.view.bounds.size.height};
    _webview.scrollView.bounces = NO;
    _webview.delegate = self;
    
    self.previousHeight = _webview.scrollView.contentOffset.y;
    _webview.scrollView.delegate = self;
    
    [self.view addSubview:_webview];

    NSString *str3 = @"\
    <div style=\"width:150px;height:49px;position:fixed;bottom:0px;left:5px;background:#cccccc;opacity:1;text-align:center;\">\
    <a href=\"share://?index=1\" style=\"font-size: 20px;color:#fff;width:100%;display: inline-block;height: 50px;line-height: 50px;float: left;background-color:#ffb03f;text-decoration:none;\">\
    \
    分享</a>\
    ";
    NSString *str4 = [NSString stringWithFormat:@"\
    <div style=\"width:150px;height:49px;position:fixed;bottom:0px;right:5px;background:#cccccc;opacity:1;text-align:center;\">\
    <a href=\"%@\" style=\"color: #fff;font-size: 20px;width:150px;display: inline-block;height: 50px;line-height: 50px;float: right;background-color:#f15353;text-decoration:none;\">详情</a>\
    </div>\
    ",bean.url];
    NSString *str = [NSString stringWithFormat:@"<h1 style=\"font-size:16;color:#1DA2A7;margin-top:5px;text-align:center;\">%@</h1><p style=\"font-size:14;color:#33373A;\">日期:%@ 作者:%@</p><p>%@</p><br/><br/><br/><br/><br/>%@%@",bean.title,bean.date,bean.auther,bean.content, str3,str4];
    
   [_webview loadHTMLString:str baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]bundlePath]]];
}
#pragma mark ----设置网页内容长按取消
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout = 'none';"];

}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *params = [request.URL.query componentsSeparatedByString:@"="][1];
    if (params != NULL) {
        if ([@"1" isEqualToString:params]) {
            [self shareData];
        } else if ([@"2" isEqualToString:params]) {
            NSLog(@"打开");
        }
    }
    return YES;
}

-(void)shareData
{
    
    DetailFirstBean *bean = self.object;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5624aaefe0f55ae828002617"
                                      shareText:bean.url
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];
}
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat f= scrollView.contentOffset.y;
//    CGFloat l = self.previousHeight-f;
//    
//    if (f<-64.0f) {
//        if (l>0) {
//            
//            _rect.size.height = _imageView.frame.size.height + l;
//            
//        }
//        else
//        {
//            _rect.size.height = _imageView.frame.size.height + l;
//
//        }
//        _imageView.frame = _rect;
//    }
//    else if(f>-64.0f)
//    {
//            _rect.origin.y = _imageView.frame.origin.y +l;
//            _imageView.frame = _rect;
//    }
//    else
//    {
//        _rect.origin.y = 64.0f;
//        _rect.size.height = 100.0f;
//        [UIView animateWithDuration:0.01 animations:^{
//            _imageView.frame = _rect;
//        }];
//        
//    }
//    self.previousHeight = scrollView.contentOffset.y;
//}

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
