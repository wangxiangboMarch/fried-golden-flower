import Foundation

//游戏主类
public class Game {
    
    var cardList:[Card]=[] //扑克牌集合
    var playerList:[Player]=[] //玩家集合
    static var color:[String]=["黑桃","红桃","梅花","方片"]
    static var number:[String]=["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
    
    public init() {
        
    }
    
    //创建玩家
    public func creatPlayer(num: NSInteger){
        print("开始创建玩家。。。")
        for i in 1...num {
            playerList.append(Player(id: i,name:"\(i)_号玩家"))
        }
        print("玩家创建OK。。。。。")
    }
    
    //创建扑克牌
    public func createCards() {
        print("开始创建扑克牌。。。。")
        for  i in 0..<4{
            for  j in 0..<13{
                cardList.append(Card(color:Game.color[i],number:Game.number[j]))
            }
        }
        print("扑克牌创建ok...")
        print("扑克牌为：")
        Computerd.printArray(array: cardList)
    }
    
    //洗牌
    public func changeCards() {
        print("洗牌开始。。。。。")
        var rm: Int=0 //随机数
        for j in 0...10{
            print("开始第\(j+1)次洗牌….")
            for i in 0..<52{
                rm = Int(arc4random_uniform(50)) + 1 //生成洗牌次数,使用arc4random函数求0~45的随机数
                //【i】人【rm】对换，利用随机数内部打乱顺序
                var tmp:Card
                tmp=cardList[i]
                cardList[i]=cardList[rm]
                cardList[rm]=tmp
            }
        }
        print("洗牌完成。。。。")
        Computerd.printArray(array: cardList)
    }
    
    //发牌,每人n张，炸金花为3张
    public func sendCars() {
        
        let numbercard:Int = 3
        
        print("开始发牌，每人\(numbercard)张")
        
        if playerList.count > 17 {
            print("玩家太多游戏无法开始.....")
            return
        }
        
        for (index, player) in playerList.enumerated() {
            //给第一个玩家发牌,从0到numberCard-1
            for  j in index*numbercard..<numbercard*(index + 1) {
                player.playerCardList.append(cardList[j])
            }
        }
        
        print("发牌完毕。。。")
        
        for player in playerList {
            var tmp:String=""
            for j in 0..<numbercard{
                tmp = tmp + player.playerCardList[j].toString()+";"
            }
            let type:Int=Computerd.playerCardType(cards:player.playerCardList) //得到玩家手牌的类型
            print("\(player.name)号玩家牌面是：\(tmp) 手牌类型是  \(Computerd.cardType_toString(cardType: type))")
        }
        
//        //给第一个玩家发牌,从0到numberCard-1
//        for  j in 0..<3{
//            playerList[0].playerCardList.append(cardList[j])
//        }
//        //给第2个玩家发牌，从numberCard 到  numberCard*2-1
//        for  j in 3..<3*2{
//            playerList[1].playerCardList.append(cardList[j])
//        }
//        print("发牌完毕。。。")
        
        
        
//        var tmp:String=""
//        for j in 0..<numbercard{
//            tmp=tmp+playerList[0].playerCardList[j].toString()+";"
//        }
//        print("1号玩家牌面是：\(tmp)")
//
//        tmp=""
//        for j in 0..<numbercard{
//            tmp=tmp+playerList[1].playerCardList[j].toString()+";"
//        }
//        print("2号玩家牌面是：\(tmp)")
        
    }
    
    //2个玩家进行对比PK
    public func gameKO() {
        
        if playerList.count > 17 {
            return
        }
        
        playerList = playerList.sorted(by: {
            
            let oneType = Computerd.playerCardType(cards:$0.playerCardList)
            let twoType = Computerd.playerCardType(cards:$1.playerCardList)

            //先对比牌型，如果牌型大，则直接赢。如果牌型相等，则比较大小。
            if oneType != twoType {
                return oneType>twoType
            }else{
                //对比数字大小，如果是0，则1号玩家赢；如果是1，则2号玩家赢
                let tmp:Int=Computerd.comparison(cards1: $0.playerCardList, cards2: $1.playerCardList)
                return tmp==0
            }
        })
        
//        let card1_Type:Int=Computerd.playerCardType(cards:playerList[0].playerCardList) //得到玩家手牌的类型
//        print("玩家1的手牌类型是  \(Computerd.cardType_toString(cardType: card1_Type))")
//
//        let card2_Type:Int=Computerd.playerCardType(cards: playerList[1].playerCardList)
//        print("玩家2的手牌类型是是  \(Computerd.cardType_toString(cardType: card2_Type))")
        
//        //先对比牌型，如果牌型大，则直接赢。如果牌型相等，则比较大小。
//        if card1_Type>card2_Type {
//            PlayerWin.playerWinId=0
//            PlayerWin.cardWinType=card1_Type
//        }
//        if card1_Type<card2_Type {
//            PlayerWin.playerWinId=1
//            PlayerWin.cardWinType=card2_Type
//        }
//        //如果2手牌类型相同则对比数字的大小
//        if card1_Type==card2_Type{
//            PlayerWin.cardWinType=card1_Type //赢家的牌型
//            //对比数字大小，如果是0，则1号玩家赢；如果是1，则2号玩家赢
//            let tmp:Int=Computerd.comparison(cards1: playerList[0].playerCardList, cards2: playerList[1].playerCardList)
//            if tmp==0   { PlayerWin.playerWinId=0   }
//            if tmp==1   { PlayerWin.playerWinId=1   }
//        }
        
        if let win = playerList.first {
            let type = Computerd.playerCardType(cards:win.playerCardList)
            //显示赢家信息
            print("赢家是：\(win.name),牌面是：\(Computerd.cardType_toString(cardType:type))")
        }else{
            print("没有玩家")
        }
       
    }
}
