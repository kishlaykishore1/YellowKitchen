import Foundation
import UIKit

open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }
}
extension TTTAttributedLabel {
      func showTextOnTTTAttributeLable(str: String, readMoreText: String, readLessText: String, font: UIFont?, charatersBeforeReadMore: Int, activeLinkColor: UIColor, isReadMoreTapped: Bool, isReadLessTapped: Bool) {

        let text = str + readLessText
        let attributedFullText = NSMutableAttributedString.init(string: text)
        let rangeLess = NSString(string: text).range(of: readLessText, options: String.CompareOptions.caseInsensitive)
//Swift 5
       // attributedFullText.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], range: rangeLess)
        attributedFullText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: rangeLess)
        
        var subStringWithReadMore = ""
        if text.count > charatersBeforeReadMore {
          let start = String.Index(encodedOffset: 0)
          let end = String.Index(encodedOffset: charatersBeforeReadMore)
          subStringWithReadMore = String(text[start..<end]) + readMoreText
        }

        let attributedLessText = NSMutableAttributedString.init(string: subStringWithReadMore)
        let nsRange = NSString(string: subStringWithReadMore).range(of: readMoreText, options: String.CompareOptions.caseInsensitive)
        //Swift 5
       // attributedLessText.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], range: nsRange)
        attributedLessText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange)
        if let font = font {// set font to attributes
         self.font = font
        }
        self.attributedText = attributedLessText
        self.activeLinkAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12)!]
        //Swift 5
       // self.linkAttributes = [NSAttributedStringKey.foregroundColor : UIColor.blue]
        self.linkAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12)!]
        self.addLink(toTransitInformation: ["ReadMore":"1"], with: nsRange)

        if isReadMoreTapped {
          self.numberOfLines = 0
          self.attributedText = attributedFullText
          self.addLink(toTransitInformation: ["ReadLess": "1"], with: rangeLess)
        }
        if isReadLessTapped {
          self.numberOfLines = 2
          self.attributedText = attributedLessText
        }
      }
    }
