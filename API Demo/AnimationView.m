//
//  AnimationView.m
//  API Demo
//
//  Created by 杨毅辉 on 15/7/1.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
//        AnimationView *animationView = [[AnimationView alloc] initWithFrame:self.view.frame];
//        animationView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:animationView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawTest];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    /**
     *  通过CGContextSaveGState 过程来保存图形环境的状态
     */
    CGContextSaveGState(currentContext);
    
    /**
     *  通过CGContextRestoreGState 过程恢复之前的状态
     */
    CGContextRestoreGState(currentContext);
}

- (void)drawTest {
    
    /**
     *  在一个视图的图形环境上绘制的一个随机字符串
     */
    [self drawString];
    
    /**
     *  在图形环境中绘制图像
     */
    [self drawImage];
    
    /**
     *  在当前图形环境上一次画两条相交直线
     */
    [self drawLine];
    
    /**
     *  两条线相遇的点，被称为接合点（join）。
     *  使用Core Graphics，你可以指定线和线之间接合点的类型。
     */
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 40.0f)
                    textToDisplay:@"Miter"
                         lineJoin:kCGLineJoinMiter];//接合点为尖角。这是默认的接合类型。
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 180.0f)
                    textToDisplay:@"Bevel"
                         lineJoin:kCGLineJoinBevel];//接合点为斜角
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 320.0f)
                    textToDisplay:@"Round"
                         lineJoin:kCGLineJoinRound];//接合点为圆角
    
    /**
     *  画两条交叉线
     */
    [self drawLines];
    
    /**
     *  画两个相交的矩形
     */
    [self drawRectTest];
    
    /**
     *  画矩形阴影
     */
    [self drawRectAtTopOfScreen];
    [self drawRectAtBottomOfScreen];
    
    /**
     *  渐变
     */
    [self drawGradient];
    
    /**
     *  改变矩形位移
     */
    [self drawRectMove];
    
    /**
     *  矩形缩放
     */
    [self drawRectScale];
    
    /**
     *  矩形旋转45度
     */
    [self drawRectTransform];
}

- (void)drawString {
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];//字体
    UIColor *color = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];//颜色
    NSString *myString = @"Some String";//内容
    NSDictionary *attributeDic = @{NSFontAttributeName:helveticaBold,NSForegroundColorAttributeName:color};
    [myString drawAtPoint:CGPointMake(20, 20) withAttributes:attributeDic];
    [myString drawInRect:CGRectMake(10, 10, 20, 100) withAttributes:attributeDic];
}

- (void)drawImage {
    
    UIImage *image = [UIImage imageNamed:@"snow.png"];
    if (image != nil) {
        
        NSLog(@"Successfully loaded the image.");
    } else {
        
        NSLog(@"Failed to load the image.");
    }
    [image drawAtPoint:CGPointMake(0.0f, 20.0f)];
    [image drawInRect:CGRectMake(50.0f,10.0f,100.0f,100.0f)];
}

- (void)drawLine {
    
    /* Get the current graphics context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Set the width for the line */
    CGContextSetLineWidth(currentContext,5.0f);
    /* Start the line at this point */
    CGContextMoveToPoint(currentContext,50.0f,10.0f);
    /* And end it at this point */
    CGContextAddLineToPoint(currentContext,100.0f,200.0f);
    /* Extend the line to another point */
    CGContextAddLineToPoint(currentContext,300.0f,100.0f);
    /* Set the color that we want to use to draw the line */
    [[UIColor brownColor]set];
    /* Use the context's current color to draw the line */
    CGContextStrokePath(currentContext);
}

/**
 *  画3条平行的折线
 */
- (void)drawRooftopAtTopPointof:(CGPoint)paramTopPoint
                  textToDisplay:(NSString *)paramText
                       lineJoin:(CGLineJoin)paramLineJoin {
    
    /* Set the color that we want to use to draw the line */
    [[UIColor brownColor] set];
    /* Get the current graphics context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Set the line join */
    CGContextSetLineJoin(currentContext,paramLineJoin);
    /* Set the width for the lines */
    CGContextSetLineWidth(currentContext,20.0f);
    /* Start the line at this point */
    CGContextMoveToPoint(currentContext,paramTopPoint.x - 140,paramTopPoint.y + 100);
    /* And end it at this point */
    CGContextAddLineToPoint(currentContext,paramTopPoint.x,paramTopPoint.y);
    /* Extend the line to another point to
     make the rooftop */
    CGContextAddLineToPoint(currentContext,paramTopPoint.x + 140,paramTopPoint.y + 100);
    /* Use the context's current color to draw the lines */
    CGContextStrokePath(currentContext);
    
    /* Now draw the text */
    CGPoint drawingPoint = CGPointMake(paramTopPoint.x - 40.0f,paramTopPoint.y + 60.0f);
    NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0f]};
    [paramText drawAtPoint:drawingPoint withAttributes:attributeDic];
}

/**
 *  画两条交叉线
 *  1.创建一个可变路径(CGPathCreateMutable)
 *  2.向你的图形环境上添加该路径(CGContextAddPath)
 *  3.并将它绘制到图形环境上(CGContextDraw Path)
 */
- (void)drawLines {
    
    /* Create the path */
    CGMutablePathRef path = CGPathCreateMutable();
    /* How big is the screen? We want the X to cover
     the whole screen */
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    /* Start from top-left */
    CGPathMoveToPoint(path,
                      NULL,
                      screenBounds.origin.x,
                      screenBounds.origin.y);
    /* Draw a line from top-left to bottom-right of the screen */
    CGPathAddLineToPoint(path,
                         NULL,
                         screenBounds.size.width,
                         screenBounds.size.height);
    /* Start another line from top-right */
    CGPathMoveToPoint(path,
                      NULL,
                      screenBounds.size.width,
                      screenBounds.origin.y);
    /* Draw a line from top-right to bottom-left */
    CGPathAddLineToPoint(path,
                         NULL,
                         screenBounds.origin.x,
                         screenBounds.size.height);
    /* Get the context that the path has to be drawn on */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Add the path to the context so we can
     draw it later */
    CGContextAddPath(currentContext,path);
    /* Set the blue color as the stroke color */
    [[UIColor yellowColor] setStroke];
    /* Draw the path with stroke color */
    CGContextDrawPath(currentContext,kCGPathStroke);
    /* Finally release the path object */
    CGPathRelease(path);
}

/**
 *  画两个相交的矩形
 */
- (void)drawRectTest {
    
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    /* Here are the first rectangle boundaries */
    CGRect rectangle1 = CGRectMake(10.0f,10.0f,200.0f,300.0f);
    /* And the second rectangle */
    CGRect rectangle2 = CGRectMake(40.0f,100.0f,90.0f,300.0f);
    /* Put both rectangles into an array */
    CGRect rectangles[2] = {
        rectangle1, rectangle2
    };
    /* Add the rectangles to the path */
    CGPathAddRects(path,NULL,(const CGRect *)&rectangles,2);
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Add the path to the context */
    CGContextAddPath(currentContext,path);
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    /* Set the stroke color to black */
    [[UIColor blackColor] setStroke];
    /* Set the line width (for the stroke) to 5 */
    CGContextSetLineWidth(currentContext,5.0f);
    /* Stroke and fill the path on the context */
    CGContextDrawPath(currentContext,kCGPathFillStroke);
    /* Dispose of the path */
    CGPathRelease(path);
}

/**
 *  对矩形使用阴影
 */
- (void)drawRectAtTopOfScreen {
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(currentContext);
    
    /**
     *  offset
     *  阴影的位移，由CGSize 类型值指定，从每个形状要应用阴影的右下部分开始。位移
     *  的x 值越大，形状右边的阴影就扩散得越远。位移的y 值越大，下部的阴影就越低。
     *
     *  blur
     *  阴影的模糊值，以浮点值(CGFloat)来指定。指定0.0f 将导致阴影成为固态形状。这个
     *  值越高，阴影就越模糊。
     *
     *  color
     *  设置阴影的颜色
     */
    CGContextSetShadowWithColor(currentContext,
                                CGSizeMake(10.0f, 10.0f),
                                20.0f,
                                [[UIColor grayColor] CGColor]);
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    /* Here are the rectangle boundaries */
    CGRect firstRect = CGRectMake(55.0f,
                                  60.0f,
                                  150.0f,
                                  150.0f);
    /* Add the rectangle to the path */
    CGPathAddRect(path,NULL,firstRect);
    /* Add the path to the context */
    CGContextAddPath(currentContext,path);
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f
                     green:0.60f
                      blue:0.80f
                     alpha:1.0f] setFill];
    /* Fill the path on the context */
    CGContextDrawPath(currentContext,
                      kCGPathFill);
    /* Dispose of the path */
    CGPathRelease(path);
    
    CGContextRestoreGState(currentContext);
}

- (void)drawRectAtBottomOfScreen {
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGMutablePathRef secondPath = CGPathCreateMutable();
    CGRect secondRect = CGRectMake(150.0f,
                                   250.0f,
                                   100.0f,
                                   100.0f);
    CGPathAddRect(secondPath,
                  NULL,
                  secondRect);
    CGContextAddPath(currentContext,
                     secondPath);
    [[UIColor purpleColor] setFill];
    CGContextDrawPath(currentContext,
                      kCGPathFill);
    CGPathRelease(secondPath);
}

- (void)drawGradient {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIColor *startColor = [UIColor orangeColor];
    CGFloat *startColorComponents =(CGFloat *)CGColorGetComponents([startColor CGColor]);
    
    UIColor *endColor = [UIColor blueColor];
    CGFloat *endColorComponents =(CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    CGFloat colorComponents[8] = {
        /* Four components of the orange color (RGBA) */
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3], /* First color = orange */
        /* Four components of the blue color (RGBA) */
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3], /* Second color = blue */
    };
    
    /**
     *  两种颜色
     *  第一个数组0是渐变的最开始
     *  第二个数组1在最后
     */
    CGFloat colorIndices[2] = {
        0.0f, /* Color 0 in the colorComponents array */
        1.0f, /* Color 1 in the colorComponents array */
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (colorSpace,
     (const CGFloat *)&colorComponents,
     (const CGFloat *)&colorIndices,
     2);
    
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint, endPoint;
    
    /**
     *  开始点到终点的直线为渐变的直线
     */
    startPoint = CGPointMake(0,0);
    endPoint = CGPointMake(320,0);

    
    /**
     *
     
     CGGradientDrawingOptions：渐变绘制选项
     
     kCGGradientDrawsAfterEndLocation
     在渐变终点之后将渐变扩展到所有点
     
     kCGGradientDrawsBeforeStartLocation
     在渐变起点之前将渐变扩展到所有点
     
     0
     不会以任何方式扩展渐变
     
     */
    CGContextDrawLinearGradient(currentContext,
                                gradient,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsBeforeStartLocation |
                                kCGGradientDrawsAfterEndLocation);
//    CGContextDrawLinearGradient (currentContext,
//                                 gradient,
//                                 startPoint,
//                                 endPoint,
//                                 0);
    CGGradientRelease(gradient);
    CGContextRestoreGState(currentContext);
}

/**
 *  矩形位移移动，左边位置换成右边位置
 */
- (void)drawRectMove {
    
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    /* Here are the rectangle boundaries */
    CGRect rectangle = CGRectMake(10.0f,
                                  10.0f,
                                  200.0f,
                                  300.0f);
    /* We want to displace the rectangle to the right by
     100 points but want to keep the y position
     untouched */
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100.0f,0.0f);//移动1次
    /* Add the rectangle to the path */
    CGPathAddRect(path,&transform,rectangle);
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Translate the current transformation matrix
     to the right by 100 points */
    CGContextTranslateCTM(currentContext,100.0f,0.0f);//移动2次
    /* Add the path to the context */
    CGContextAddPath(currentContext,path);
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f
                     green:0.60f
                      blue:0.80f
                     alpha:1.0f] setFill];
    /* Set the stroke color to brown */
    [[UIColor brownColor] setStroke];
    /* Set the line width (for the stroke) to 5 */
    CGContextSetLineWidth(currentContext,
                          5.0f);
    /* Stroke and fill the path on the context */
    CGContextDrawPath(currentContext,
                      kCGPathFillStroke);
    /* Dispose of the path */
    CGPathRelease(path);
}

/**
 *  矩形缩放
 */
- (void)drawRectScale {
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    /* Here are the rectangle boundaries */
    CGRect rectangle = CGRectMake(10.0f,
                                  10.0f,
                                  200.0f,
                                  300.0f);
    /* Scale the rectangle to half its size */
    CGAffineTransform transform =CGAffineTransformMakeScale(0.5f, 0.5f);//缩放1次
    /* Add the rectangle to the path */
    CGPathAddRect(path,&transform,rectangle);
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Scale everything drawn on the current
     graphics context to half its size */
    CGContextScaleCTM(currentContext,0.5f,0.5f);//缩放2次
    /* Add the path to the context */
    CGContextAddPath(currentContext,path);
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f
                     green:0.60f
                      blue:0.80f
                     alpha:1.0f] setFill];
    /* Set the stroke color to brown */
    [[UIColor brownColor] setStroke];
    /* Set the line width (for the stroke) to 5 */
    CGContextSetLineWidth(currentContext,
                          5.0f);
    /* Stroke and fill the path on the context */
    CGContextDrawPath(currentContext,
                      kCGPathFillStroke);
    /* Dispose of the path */
    CGPathRelease(path);
}

/**
 *  矩形旋转45度，也可以是用 CGContextRotateCTM
 */
- (void)drawRectTransform {
    
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    /* Here are the rectangle boundaries */
    CGRect rectangle = CGRectMake(10.0f,
                                  10.0f,
                                  200.0f,
                                  300.0f);
    /* Rotate the rectangle 45 degrees clockwise */
    CGAffineTransform transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
    /* Add the rectangle to the path */
    CGPathAddRect(path,&transform,rectangle);
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* Add the path to the context */
    CGContextAddPath(currentContext,path);
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f
                     green:0.60f
                      blue:0.80f
                     alpha:1.0f] setFill];
    /* Set the stroke color to brown */
    [[UIColor brownColor] setStroke];
    /* Set the line width (for the stroke) to 5 */
    CGContextSetLineWidth(currentContext,
                          5.0f);
    /* Stroke and fill the path on the context */
    CGContextDrawPath(currentContext,
                      kCGPathFillStroke);
    /* Dispose of the path */
    CGPathRelease(path);
}

@end
