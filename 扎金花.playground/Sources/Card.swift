import Foundation

//类：扑克牌
class Card{
    var color:String   //花色
    var number:String  //数字
    
    init(color:String,number:String) {
        self.color=color
        self.number=number
    }
    
    func toString() ->String{
        return "\(color)\(number)"
    }
}
