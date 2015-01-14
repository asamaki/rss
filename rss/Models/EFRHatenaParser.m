//
//  EFRHatenaParser.m
//  rss
//
//  Created by Ikai Masahiro on 2014/10/16.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "EFRHatenaParser.h"

@interface EFRHatenaParser () <NSXMLParserDelegate>{
    BOOL isItem, isTitle, isLink, isDescription, isContent, isDate, isSubject, isBookmarkCount, isImage;
    NSMutableString *title, *link, *description, *content, *date, *subject, *bookmarkCount, *image;

}

@property (strong, nonatomic) NSMutableArray *articles;

@end

@implementation EFRHatenaParser

+ (NSArray *)parseResultWithCategoryName:(NSString *)categoryName{
    EFRHatenaParser *hatenaParser = [[self alloc] init];
    hatenaParser.articles = [[NSMutableArray array]mutableCopy];
    NSString *urlStr = [NSString stringWithFormat:@"http://b.hatena.ne.jp/hotentry/%@.rss", categoryName];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = hatenaParser;
    BOOL isSuccess = [parser parse];
    //iphone4sSimulator だとnilになるみたい！
    if(!isSuccess) return nil;
    
    return hatenaParser.articles;
}


#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    isItem          = NO;
    isTitle         = NO;
    isLink          = NO;
    isDescription   = NO;
    isContent       = NO;
    isDate          = NO;
    isSubject       = NO;
    isBookmarkCount = NO;
    isImage = NO;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //NSLog(@"<%@>", elementName);
    if ([ITEM isEqualToString:elementName]) isItem = YES;
    if (isItem) {
        if ([TITLE isEqualToString:elementName]) {
            isTitle = YES;
            title = [[NSMutableString string] mutableCopy];
        } else if ([LINK isEqualToString:elementName]) {
            isLink = YES;
            link = [[NSMutableString string] mutableCopy];
        } else if ([DESCRIPTION isEqualToString:elementName]) {
            isDescription = YES;
            description = [[NSMutableString string] mutableCopy];
            //NSLog(@"<%@>", description);
        } else if ([CONTENT isEqualToString:elementName]) {
            isContent = YES;
            content = [[NSMutableString string] mutableCopy];
        } else if ([DATE isEqualToString:elementName]) {
            isDate = YES;
            date = [[NSMutableString string] mutableCopy];
        } else if ([SUBJECT isEqualToString:elementName]) {
            isSubject = YES;
            subject = [[NSMutableString string] mutableCopy];
        } else if ([BOOKMARK_COUNT isEqualToString:elementName]) {
            isBookmarkCount = YES;
            bookmarkCount = [[NSMutableString string] mutableCopy];
        } else if ([IMAGE isEqualToString:elementName]) {
            isImage = YES;
            image = [[NSMutableString string] mutableCopy];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //NSLog(@"<%@>", elementName);
    if([ITEM isEqualToString:elementName]){
        isItem = NO;
        NSDictionary *article = @{
                                  TITLE         : title,
                                  LINK          : link,
                                  DESCRIPTION   : description,
                                  CONTENT       : content,
                                  DATE          : date,
                                  SUBJECT       : subject,
                                  BOOKMARK_COUNT: bookmarkCount
                                  };
        [self.articles addObject:article];
    }
    if (isItem) {
        if ([TITLE isEqualToString:elementName]) {
            isTitle = NO;
        } else if ([LINK isEqualToString:elementName]) {
            isLink = NO;
        } else if ([DESCRIPTION isEqualToString:elementName]) {
            isDescription = NO;
        } else if ([CONTENT isEqualToString:elementName]) {
            isContent = NO;
        } else if ([DATE isEqualToString:elementName]) {
            isDate = NO;
        } else if ([SUBJECT isEqualToString:elementName]) {
            isSubject = NO;
        } else if ([BOOKMARK_COUNT isEqualToString:elementName]) {
            isBookmarkCount = NO;
        } else if ([IMAGE isEqualToString:elementName]) {
            isImage = NO;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //NSLog(@"%@", string);
    if (isTitle) {
        [title appendString:string];
    } else if (isLink) {
        [link appendString:string];
    } else if (isDescription) {
        [description appendString:string];
    } else if (isContent) {
        [content appendString:string];
    } else if (isDate) {
        [date appendString:string];
    } else if (isSubject) {
        [subject appendString:string];
    } else if (isBookmarkCount) {
        [bookmarkCount appendString:string];
    } else if (isImage) {
        [image appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
}


@end
