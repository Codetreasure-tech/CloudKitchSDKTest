//
//  CusineListTableViewCell.swift
//  CloudKitchTestFrameWork
//
//  Created by Codetreasure on 07/10/20.
//

import UIKit

class CusineListTableViewCell: UITableViewCell
{

    @IBOutlet var cuisineImgV:UIImageView!
    @IBOutlet var cuisinePriceLb:UILabel!
    @IBOutlet var cuisineDisountPriceLb:UILabel!
    @IBOutlet var cuisineDescriptionLb:UILabel!
    
    @IBOutlet var customizeItemLb:UILabel!
    @IBOutlet var customizeItemCheckBox_Btn:UIButton!
    
    @IBOutlet var cuisineNameLb:UILabel!
    @IBOutlet var servesCountLb:UILabel!
    @IBOutlet var quantityLb:UILabel!
    @IBOutlet var cusineTotalPriceLb:UILabel!
    
    @IBOutlet var restaurantNameLb:UILabel!
    @IBOutlet public var offerTextLb:UILabel!
    @IBOutlet public var offerBgView:UIView!
    
    @IBOutlet public var addToCartV:UIView!
    
    func conFigureCuisineTableVCell(data:Cuisine)
    {
        self.addToCartV.layer.cornerRadius = 11
        self.addToCartV.layer.borderWidth = 0.4
        self.addToCartV.layer.borderColor = UIColor.darkGray.cgColor
        
        if data.name != "" && data.name != nil
        {
            self.cuisineImgV?.downloadImage(from: data.image ?? "")
            

            self.cuisineNameLb?.text = data.name
            self.restaurantNameLb?.text = data.restaurantName
            
            self.cuisinePriceLb?.text = data.discountprice ?? 0.0 > 0.0 ? "₹ \(data.discountprice ?? 0)" : "₹ \(data.price ?? "0")"
            
            self.servesCountLb?.text = "Serves \(data.serves ?? "")"
            
            if data.offer != "" && data.offer != nil
            {
                self.offerBgView?.isHidden = false
                self.offerTextLb?.text = "\(data.offer ?? "")% off"
            }
            else
            {
                self.offerBgView?.isHidden = true
                self.offerTextLb?.text = ""
            }


            self.cuisineDescriptionLb?.attributedText = (data.description ?? "").htmlToAttributedString(font:UIFont.systemFont(ofSize: 11),lineSpacing:4)
            
            
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension String
{
    func htmlToAttributedString(font:UIFont,lineSpacing:CGFloat) ->NSMutableAttributedString?
    {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do
        {
            let str = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue,], documentAttributes: nil)
            
            
            str.enumerateAttribute(
                NSAttributedString.Key.font,
                in:NSMakeRange(0,str.length),
                options:.longestEffectiveRangeNotRequired) { value, range, stop in
                    let f1 = value as! UIFont
                    let f2 = font//UIFont(name:CustomFonts.GothamBook, size:13)!
                    if let f3 = applyTraitsFromFont(f1, to:f2) {
                        str.addAttribute(
                            NSAttributedString.Key.font, value:f3, range:range)
                    }
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = .left
            paragraphStyle.lineBreakMode = .byTruncatingTail
            str.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, str.length))
            
            
            str.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range:NSMakeRange(0, str.length))
            
            return str
        } catch
        {
            return NSMutableAttributedString()
        }
        
        
    }
    
    func applyTraitsFromFont(_ f1: UIFont, to f2: UIFont) -> UIFont? {
        let t = f1.fontDescriptor.symbolicTraits
        if let fd = f2.fontDescriptor.withSymbolicTraits(t) {
            return UIFont.init(descriptor: fd, size: 0)
        }
        return nil
    }
}


