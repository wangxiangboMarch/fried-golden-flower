import Foundation

//计算类，全部用静态方法
class Computerd{
    /**
     将牌面中的数字部份转换为编号数组(并将数组按从大到小排序)，用于比较大小
     */
    static func numberSort(cards:[Card]) -> [Int] {
        var tmpNumber:[Int]=[] //临时数组，用来存放转换为数字后的3张手牌编号
        //将手牌大小的数组转换成数字编号，用于确认是否顺子-》因为大小中含有JQKA，不能直接通过字符串转换成数字，需借用数组编号
        //一共3张牌，3次循环
        for i in 0..<3 {
            for j in 0..<13{   //J是扑克牌数字 的编号
                if cards[i].number==Game.number[j]{
                    tmpNumber.append(j)
                    //  print("牌面是：number=\(number[j]) ,j=\(j),tmpnubber=\(tmpNumber[i])")
                    break
                }
            }
        }
        
        //此时数组已转换成编号，按从小到大的顺序排序
        tmpNumber = tmpNumber.sorted() //默认从小到大排序
        var x:[Int]=[]
        x.append(tmpNumber[2])
        x.append(tmpNumber[1])
        x.append(tmpNumber[0])
        return x
    }
    
    /**
     比较2个数的大小，当第一个大时，返回0;当第2个大时，返回1；当相等时，返回-1
     */
    static func max_XY(x:Int,y:Int)->Int{
        if x>y   { return 0 }
        if x<y   { return 1 }
        if x==y  { return -1}
        return 0
    }
    
    /**
     返回数组中是对子的那个数(数组中个数为3)用于比较对子的大小，例如3，5，5，返回5.
     */
    static func number_DuiZhi(numbers:[Int])->Int{
        if numbers[0]==numbers[1] {return numbers[0]}
        if numbers[1]==numbers[2] {return numbers[1]}
        if numbers[0]==numbers[2]  {return numbers[0]}
        return 0
        
    }
    
    /**
     对比2个数字的大小，先比较第一张，相等再第二张，相等再第3张
     返回0代表第一个玩家赢。返回1代表第二个玩家赢
     */
    static func max_Cards(cards1:[Card],cards2:[Card])->Int{
        //第一个玩家手牌的数字数组，已从大到小排序
        let card1_numbers:[Int]=Computerd.numberSort(cards: cards1)
        //第二个玩家手牌的数字数组
        let card2_numbers:[Int]=Computerd.numberSort(cards: cards2)
        if card1_numbers[0]>card2_numbers[0] {return 0}
        if card1_numbers[0]<card2_numbers[0] {return 1}
        
        if card1_numbers[1]>card2_numbers[1] {return 0}
        if card1_numbers[1]<card2_numbers[1] {return 1}
        
        if card1_numbers[2]>card2_numbers[2] {return 0}
        if card1_numbers[2]<card2_numbers[2] {return 1}
        
        //下面就是2边的3张牌都相等，则比花色
        print("当为同花或者单张时，此时2边的3张牌都相等要比花色，此时默认1号玩家赢")
        return 0
    }
    
    /**
     根据数字返回牌型的文字描述，例如豹子、同花顺。。。。
     */
    static func cardType_toString(cardType:Int)->String{
        if cardType==DaXiaoType.type_Baozhi.rawValue {return "豹子"}
        if cardType==DaXiaoType.type_TongHuaShun.rawValue {return "同花顺"}
        if cardType==DaXiaoType.type_shunzhi.rawValue {return "顺子"}
        if cardType==DaXiaoType.type_TongHua.rawValue {return "同花"}
        if cardType==DaXiaoType.type_DuiZhi.rawValue {return "对子"}
        if cardType==DaXiaoType.type_DanZhang.rawValue {return "单张"}
        return "err"
    }
    
    /**
     输出数组完整内容
     */
    static func printArray(array:Array<Card>) {
        var tmp:String=""
        for  i in 0..<array.count{
            tmp=tmp+array[i].toString()+";"
        }
        print(tmp)
    }
    
    
    /**
     //选出玩家手牌的牌型
     //是哪种？豹子 6>同花顺5 >同花4 >顺子3 >对子2 >单张1
     */
    static func playerCardType(cards:[Card]) ->Int  {
        var type:Int=1  //默认值为1
        //判断豹子
        if cards[0].number==cards[1].number && cards[1].number==cards[2].number{
            type = DaXiaoType.type_Baozhi.rawValue
            return type
        }
        var tmpCardNumber:[String]=[] //临时数组，用来对比手牌数字的大小
        //将三张手牌的大小传到临时数组里面
        for  i in 0..<3 {
            tmpCardNumber.append(cards[i].number)
        }
        //对子
        if cards[0].number==cards[1].number || cards[1].number==cards[2].number || cards[0].number==cards[2].number         {
            type = DaXiaoType.type_DuiZhi.rawValue
            return type
        }
        //判断同花顺
        //同花
        if cards[0].color==cards[1].color && cards[1].color==cards[2].color{
            if isShunzhi(CardNumbers: tmpCardNumber)==true{
                type = DaXiaoType.type_TongHuaShun.rawValue   //花色相同且是顺子
                return type
            }
            else{
                type = DaXiaoType.type_TongHua.rawValue} //花色相同但不是顺子
            return type
        }
        //顺子   ： 花色不同但是顺子
        if cards[0].color != cards[1].color || cards[1].color != cards[2].color{
            if isShunzhi(CardNumbers: tmpCardNumber)==true{
                type = DaXiaoType.type_shunzhi.rawValue  //花色相同且是顺子
                return type
            }
        }
        //默认是单张
        return type
    }
    
    
    /**判断手牌是不是顺子
     */
    static func isShunzhi(CardNumbers:[String])->Bool{
        var tmpNumber:[Int]=[] //临时数组，用来存放转换为数字后的3张手牌编号
        
        //将手牌大小的数组转换成数字编号，用于确认是否顺子-》因为大小中含有JQKA，不能直接通过字符串转换成数字，需借用数组编号
        //一共3张牌，3次循环
        for i in 0..<3 {
            for  j in 0..<13{   //J是扑克牌数字 的编号
                if CardNumbers[i]==Game.number[j]{
                    tmpNumber.append(j)
                    //  print("牌面是：number=\(number[j]) ,j=\(j),tmpnubber=\(tmpNumber[i])")
                    break
                }
            }
        }
        //此时数组已转换成编号，按从小到大的顺序排序
        let sortNumber = tmpNumber.sorted()
//        print("牌面大小在数组中的编号是：\(sortNumber[0])..\(sortNumber[1])..\(sortNumber[2])")
        //是不是连续？
        if sortNumber[0]+1 == sortNumber[1] && sortNumber[1]+1 == sortNumber[2]{
            return true
        }
        return false
    }
    
    /**
     当2个玩家手牌的类型一样时，比较2张牌的大小 ,返回0代表第一个赢，返回1代表第二个赢
     */
    static func comparison(cards1:[Card],cards2:[Card]) ->Int {
        var winId:Int=0
        //第一个玩家手牌的数字数组，已从大到小排序
        let card1_numbers:[Int]=Computerd.numberSort(cards: cards1)
        //第二个玩家手牌的数字数组
        let card2_numbers:[Int]=Computerd.numberSort(cards: cards2)
        
        //当为豹子时,3张牌相同，比较第一张就OK
        if PlayerWin.cardWinType==6{
            if card1_numbers[0]>card2_numbers[0] {winId=0} //比较最后一张牌的大小
            else  { winId=1 }
        }
        
        //当为同花顺或者顺子时，比较第一张的大小就OK
        if PlayerWin.cardWinType==5 || PlayerWin.cardWinType==3{
            //当第一张牌大时返回0，说明是1号玩家赢
            winId=Computerd.max_XY(x: card1_numbers[0], y: card2_numbers[0])
        }
        
        //当为对子时，比较对子那一张即可
        if PlayerWin.cardWinType==2{
            //先分别计算2个数组中是对子的那一张，再比大小
            //第一个数组中是对子的那个数
            let i:Int=Computerd.number_DuiZhi(numbers: card1_numbers)
            //第二个数组中是对子的那个数
            let j:Int=Computerd.number_DuiZhi(numbers: card2_numbers)
            winId=Computerd.max_XY(x: i, y: j)
            
            //上面3行可以用下面一行代替
            //winId=Computerd.max_XY(x: Computerd.number_DuiZhi(numbers: card1_numbers), y: Computerd.number_DuiZhi(numbers: card2_numbers))
        }
        
        //当是同花或者单张时，要先比较第一张，相等再第二张，相等再第3张。如果都相等栋比较第一张花色。。。到第3张花色
        if PlayerWin.cardWinType==4 || PlayerWin.cardWinType==1{
            winId=Computerd.max_Cards(cards1: cards1, cards2: cards2)
        }
        return winId
    }
}
