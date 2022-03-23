import Foundation

//玩家手牌的类型
//豹子 6>同花顺5 >同花4 >顺子3 >对子2 >单张1
enum DaXiaoType:Int{
    case type_Baozhi=6
    case type_TongHuaShun=5
    case type_TongHua=4
    case type_shunzhi=3
    case type_DuiZhi=2
    case type_DanZhang=1
}
