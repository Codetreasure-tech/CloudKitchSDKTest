//
//  CuisineModel.swift
//  CloudKitch
//
//  Created by Codetreasure on 04/09/20.
//  Copyright © 2020 Codetreasure. All rights reserved.
//

import Foundation

struct CuisineListResponse : Codable
{
    var status : Bool?
    var msg    : String?
    var data   : [Cuisine]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([Cuisine].self, forKey: .data)
    }
}

struct Cuisine : Codable
{
    var status : String?
    var msg    : String?
    var id : String?
    var name : String?
    var description : String?
    var description1 : String?
    var price : String?
    var serves : String?
    var leadtime : String?
    var minorderquantity : String?
    var restaurantId : String?
    var restaurantName : String?
    var restaurantWorkingStart : String?
    var restaurantWorkingEnd : String?
    var image : String?
    var offer : String?
    var discountprice : Double?
    var isCustomisable : String?
    var color : String?
    var cartQuntity : String?//Int?
    var selectedaddons : String?
    var section : [AddOnsSection]?
    var type : [CuisineType]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "msg"
        case id = "id"
        case name = "name"
        case description = "description"
        case description1 = "description1"
        case price = "price"
        case serves = "serves"
        case leadtime = "leadtime"
        case minorderquantity = "minorderquantity"
        case restaurantId = "restaurantId"
        case restaurantName = "restaurantName"
        case restaurantWorkingStart = "restaurantWorkingStart"
        case restaurantWorkingEnd = "restaurantWorkingEnd"
        case image = "image"
        case offer = "offer"
        case discountprice = "discountprice"
        case isCustomisable = "isCustomisable"
        case color = "color"
        case cartQuntity = "quantity"
        case selectedaddons = ""
        case section = "sections"
        case type = "type"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description1 = try values.decodeIfPresent(String.self, forKey: .description1)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        serves = try values.decodeIfPresent(String.self, forKey: .serves)
        leadtime = try values.decodeIfPresent(String.self, forKey: .leadtime)
        minorderquantity = try values.decodeIfPresent(String.self, forKey: .minorderquantity)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
        restaurantWorkingStart = try values.decodeIfPresent(String.self, forKey: .restaurantWorkingStart)
        restaurantWorkingEnd = try values.decodeIfPresent(String.self, forKey: .restaurantWorkingEnd)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        offer = try values.decodeIfPresent(String.self, forKey: .offer)
        discountprice = try values.decodeIfPresent(Double.self, forKey: .discountprice)
        isCustomisable = try values.decodeIfPresent(String.self, forKey: .isCustomisable)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        cartQuntity = try values.decodeIfPresent(String.self, forKey: .cartQuntity)
        selectedaddons = try values.decodeIfPresent(String.self, forKey: .selectedaddons)
        section = try values.decodeIfPresent([AddOnsSection].self, forKey: .section)
        type = try values.decodeIfPresent([CuisineType].self, forKey: .type)
    }
    
    init() {
        status = ""
        msg = ""
        id = ""
        name = ""
        description = ""
        description1 = ""
        price = ""
        serves = ""
        leadtime = ""
        minorderquantity = ""
        restaurantId = ""
        restaurantName = ""
        restaurantWorkingStart = ""
        restaurantWorkingEnd = ""
        image = ""
        offer = ""
        discountprice = 0.0
        isCustomisable = ""
        color = ""
        cartQuntity = "0"
        selectedaddons = ""
        section = [AddOnsSection]()
        type = [CuisineType]()
    }
}




struct CuisineType : Codable
{
    let name : String?
    let background : String?


    enum CodingKeys: String, CodingKey {

        case name = "name"
        case background = "background"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        background = try values.decodeIfPresent(String.self, forKey: .background)
    }

}


struct AddOnsSection : Codable
{
    let title : String?
    let section_id : String?
    let choicetype : String?
    let noofchoice : String?
    let addon_id : String?
    let detail : String?
    let price : String?
    let addons : [AddOns]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case section_id = "section_id"
        case choicetype = "choicetype"
        case noofchoice = "noofchoice"
        case addon_id = "addon_id"
        case detail = "detail"
        case price = "price"
        case addons = "addons"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        section_id = try values.decodeIfPresent(String.self, forKey: .section_id)
        choicetype = try values.decodeIfPresent(String.self, forKey: .choicetype)
        noofchoice = try values.decodeIfPresent(String.self, forKey: .noofchoice)
        addon_id = try values.decodeIfPresent(String.self, forKey: .addon_id)
        detail = try values.decodeIfPresent(String.self, forKey: .detail)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        addons = try values.decodeIfPresent([AddOns].self, forKey: .addons)
    }

}

struct AddOns : Codable
{
    var addon_id : String?
    var detail : String?
    var price : Double?
    let strikeprice : String?
    let cuisinetype : String?

    enum CodingKeys: String, CodingKey {

        case addon_id = "addon_id"
        case detail = "detail"
        case price = "price"
        case strikeprice = "strikeprice"
        case cuisinetype = "cuisinetype"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addon_id = try values.decodeIfPresent(String.self, forKey: .addon_id)
        detail = try values.decodeIfPresent(String.self, forKey: .detail)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        strikeprice = try values.decodeIfPresent(String.self, forKey: .strikeprice)
        cuisinetype = try values.decodeIfPresent(String.self, forKey: .cuisinetype)
    }
    
    init() {
        addon_id = ""
        detail = ""
        price = 0
        strikeprice = ""
        cuisinetype = ""
    }

}
