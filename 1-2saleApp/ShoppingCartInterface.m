//
//  ShoppingCartInterface.m
//  ShoppingAPP
//
//  Created by TY on 14-1-6.
//  Copyright (c) 2014年 王懿. All rights reserved.
//

#import "ShoppingCartInterface.h"

@implementation ShoppingCartInterface

// 添加商品到购物车
- (void)addToShoppingCart:(NSDictionary *)goodsInfoDictionary
{
    NSString *goodsId = [goodsInfoDictionary objectForKey:@"goodsid"];
    NSString *customerId = [DanLi sharDanli].myUserID;
    NSString *goodsCount = [goodsInfoDictionary objectForKey:@"goodscount"];
    
    NSString *lBodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&goodscount=%@",goodsId,customerId,goodsCount];
    NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/addcart.php",kIP];
    NSURL *lURL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
    if (lData == nil)
    {
        NSLog(@"send request failed: %@", error);
    }
    else
    {
        NSLog(@"add goods success");
    }
}

// 查看购物车
- (NSDictionary *)checkShoppingCart
{
    NSString *lBodyString = [NSString stringWithFormat:@"customerid=%@",[DanLi sharDanli].myUserID];

    NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/getcart.php",kIP];
    NSURL *lURL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
    if (lData == nil)
    {
        NSLog(@"send request failed: %@", error);
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        return dictionary;
    }
    else
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *lDic = [dictionary objectForKey:@"msg"];
        NSLog(@"%@",lDic);
        return lDic;
    }
}

// 修改购物车
- (NSDictionary *)resetShoppingCart:(NSDictionary *)goodsInfoDictionary
{
    NSString *cartId = [goodsInfoDictionary objectForKey:@"cartid"];
    NSString *goodsId = [goodsInfoDictionary objectForKey:@"goodsid"];
    NSString *customerId = [DanLi sharDanli].myUserID;
    NSString *goodsCount = [goodsInfoDictionary objectForKey:@"goodscount"];
    
    NSString *lBodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&goodscount=%@&cartid=%@",goodsId,customerId,goodsCount,cartId];
    NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/changecart.php",kIP];
    NSURL *lURL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lURLRequest setHTTPMethod:@"post"];
    [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
    if (lData == nil)
    {
        NSLog(@"send request failed: %@", error);
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        return dictionary;
    }
    else
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *lDic = [dictionary objectForKey:@"msg"];
        NSLog(@"%@",lDic);
        return lDic;
    }
}

// 删除购物车
- (NSDictionary *)deleteShoppingCart:(NSArray *)cartIdArray
{
    NSDictionary *lDictionary;
    
    for (int i=0; i<cartIdArray.count; i++)
    {
        NSString *lBodyString = [NSString stringWithFormat:@"cartid=%@&customerid=%@",[cartIdArray objectAtIndex:i],[DanLi sharDanli].myUserID];
        
        NSString *URLString = [NSString stringWithFormat:@"http://%@/shop/deletecart.php",kIP];
        NSURL *lURL = [NSURL URLWithString:URLString];
        NSMutableURLRequest *lURLRequest = [NSMutableURLRequest requestWithURL:lURL];
        [lURLRequest setHTTPMethod:@"post"];
        [lURLRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError *error = nil;
        NSData *lData = [NSURLConnection sendSynchronousRequest:lURLRequest returningResponse:nil error:&error];
        
        if (i == cartIdArray.count-1) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
            lDictionary = [dictionary objectForKey:@"msg"];
        }
    }
    
    return lDictionary;
}
@end
