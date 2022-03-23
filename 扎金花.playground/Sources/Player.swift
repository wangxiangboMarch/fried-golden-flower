import Foundation

//类：玩家
class Player{
    var id:Int //玩家ID
    var name :String
    var playerCardList:[Card]=[] //玩家手上的牌，0-2号为1号玩家的，3-5号原来2号玩家人
    
    var des = ""
    
    init(id:Int,name:String) {
        self.id=id
        self.name=name
    }
}
