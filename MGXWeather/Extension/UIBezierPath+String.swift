//
//  UIBezierPath+String.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/9.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit
import CoreText
extension UIBezierPath {
    class func path(for string:String, font:UIFont) -> UIBezierPath {
        let attribute = [NSAttributedString.Key.font:font]
        let attributeString = NSAttributedString(string: string, attributes: attribute)
        let letters = CGMutablePath()
        //根据字符串创建 line
        let line = CTLineCreateWithAttributedString(attributeString)
        //获取每一个字符作为数组
        let runArray = CTLineGetGlyphRuns(line)
        
        for runIndex in 0..<CFArrayGetCount(runArray) {
            let runT = CFArrayGetValueAtIndex(runArray, runIndex)
            let run = unsafeBitCast(runT, to: CTRun.self)
            let  CTFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)
            let runFontT = CFDictionaryGetValue(CTRunGetAttributes(run), CTFontName)
            let runFont = unsafeBitCast(runFontT, to: CTFont.self)
            for runGlyphIndex in 0..<CTRunGetGlyphCount(run) {
                let thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                var glyph = CGGlyph()
                var position = CGPoint()
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                
                // Get PATH of outline
                let letter = CTFontCreatePathForGlyph(runFont, glyph , nil);
                let t = CGAffineTransform(translationX: position.x, y: position.y);
                if let l = letter {
                    letters.addPath(l, transform: t)
                }
            }
            
        }
        let finalPath = letters.copy();
        let bezierPath = UIBezierPath.init(cgPath: finalPath!)
        return bezierPath;
    }
}
