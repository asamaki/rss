////
////  DetailScrollView.m
////  rss
////
////  Created by Ikai Masahiro on 2014/11/29.
////  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
////
//
//#import "DetailScrollView.h"
//
//@implementation DetailScrollView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        
//        self.delegate = self;
//        self.minimumZoomScale = 1.0f;    // 最小拡大率
//        self.maximumZoomScale = 3.0f;    // 最大拡大率
//        self.zoomScale = 1.0f;
//        
//        UIImageView *imageView = [[UIImageView alloc]init];
//        self.imageView = imageView;
//    }
//    return self;
//}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return self.imageView;
//}
//
///**
// * ScrollViewが拡大縮小されるたびに呼び出される
// */
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    [self updateImageCenter];
//}
//
///**
// * ScrollViewの拡大縮小終了時に呼び出される
// */
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
//                       withView:(UIView *)view
//                        atScale:(CGFloat)scale
//{
//    [self updateImageCenter];
//}
//
///**
// * 拡大縮小された画像のサイズに合わせて中央座標を変更する
// */
//- (void)updateImageCenter
//{
//    // 画像の表示サイズを取得
//    CGSize imageSize = self.imageView.image.size;
//    imageSize.width *= self.zoomScale;
//    imageSize.height *= self.zoomScale;
//    
//    // サブスクロールビューのサイズを取得
//    CGRect  bounds = self.bounds;
//    
//    // イメージビューの中央の座標を計算
//    CGPoint point;
//    point.x = imageSize.width / 2;
//    if (imageSize.width < bounds.size.width) {
//        point.x += (bounds.size.width - imageSize.width) / 2;
//    }
//    point.y = imageSize.height / 2;
//    if (imageSize.height < bounds.size.height) {
//        point.y += (bounds.size.height - imageSize.height) / 2;
//    }
//    self.imageView.center = point;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}
//*/
//
//@end
