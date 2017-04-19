//
//  GameScene.swift
//  WoodbineSlot
//
//  Created by Sagar patel on 2017-04-03.
//  Copyright © 2017 segy. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
   let sound = SKAction.playSoundFileNamed("117985_SOUNDDOGS__sl.mp3", waitForCompletion: false)
   
    
    var spinbtn : SKSpriteNode?
    var Diamond : SKSpriteNode?
    var Bar : SKSpriteNode?
    var Seven : SKSpriteNode?
    var onehundred : SKSpriteNode?
    var five : SKSpriteNode?
    var fifty : SKSpriteNode?
    var twentyfive : SKSpriteNode?
    var slotmac : SKSpriteNode?
    var displayres : SKLabelNode?;
    var betamount : SKLabelNode?;
    var jackpotamount : SKLabelNode?;
    var playmon : SKLabelNode?;
    var currentplayerbetmoney = 100
    var playerMoney = 1000
    var winnerpaid = 0
    var jackpot = 5000
    var turn = 0
    var playerBet = 0
    var winno = 0
    var lossNumber = 0
    var resultofspin = [String]()
    var fruits = "";
    var winRatio = 0
    var watermellon = 0
    var seeven = 0
    var boxer = 0
    var lemons = 0
    var cherry = 0
    var sevens = 0
    var hardluck = 0
    var juice = 0
    var bell = 0

    
    /* Utility function to show Player Stats */
   
    func resetvalues() {
        watermellon = 0;
        seeven = 0;
        boxer = 0;
        lemons = 0;
        cherry = 0;
        sevens = 0;
        hardluck = 0;
        juice = 0;
        bell = 0;
    }
    
    func resetAll() {
        playerMoney = 1000;
        winnerpaid = 0;
        jackpot = 2000;
        turn = 0;
        playerBet = 0;
        winno = 0;
        lossNumber = 0;
        winRatio = 0;
    }
    
    
    /* Check to see if the player won the jackpot */
    func checkJackPot() {
        /* compare two random values */
        let jackPotTry = Int(arc4random_uniform(10)) + 1;
        let jackPotWin = Int(arc4random_uniform(10)) + 1;
        if (jackPotTry == jackPotWin) {
            print("you hit the jackpot.. congrats..wait for handspay jackpot")
            playerMoney += jackpot;
            jackpot = 1000;
        }
    }
    
    /* Utility function to show a win message and increase player money */
    func showWinMessage() {
         displayres?.text="";
        playerMoney += winnerpaid;
        print("You Won: $", winnerpaid)
        
        let displayresult = SKLabelNode(fontNamed:"Times New Roman")
        displayres?.text="You Won";
        displayresult.fontSize = 14
        displayresult.position = CGPoint(x:90, y:-115)
        self.addChild(displayresult)
        self.displayres = displayresult
        displayres?.text="";
        resetvalues()
        checkJackPot();
    }
    
    
    
    /* Utility function to calculate player money and to display message of any lost during the game */
    func showLossMessage() {
        playerMoney -= playerBet
        
        print("You Lost!")
        
        let displaylostresult = SKLabelNode(fontNamed:"Times New Roman")
        displayres?.text="You Lost";
        //displaylostresult.text = displayres?.description
        //moneyLabel.text=" ";
        displaylostresult.fontSize = 14
        displaylostresult.position = CGPoint(x:90, y:-115)
        self.addChild(displaylostresult)
        self.displayres = displaylostresult
       displayres?.text
        resetvalues()
    }
    
    
    
    /* function to check the range */
    func checkRange(value : Int, lowerBounds : Int, upperBounds : Int) -> Int
    {
        var returnValue=0
        if (value >= lowerBounds && value <= upperBounds)
        {
            returnValue=value;
        }
        
        return returnValue;
    }
    
    
    
    
   
    func Reels() -> Array<String>
    {
        var betLine = [" ", " ", " "];
        var outCome = [0, 0, 0];
        
        for var spin in 0..<3 {
            
            outCome[spin] = Int(arc4random_uniform(60)) + 1;
            
            switch (outCome[spin]) {
            case checkRange(value: outCome[spin], lowerBounds: 1, upperBounds: 27):
                betLine[spin] = "hardluck";
                hardluck += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 28, upperBounds: 37):
                betLine[spin] = "bell";
                bell += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 38, upperBounds: 46):
                betLine[spin] = "seven";
                seeven += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 47, upperBounds: 54):
                betLine[spin] = "watermellon";
                watermellon += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 55, upperBounds: 59):
                betLine[spin] = "boxer";
                boxer += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 60, upperBounds: 62):
                betLine[spin] = "lemon";
                lemons += 1;		
                break;
            case checkRange(value: outCome[spin], lowerBounds: 63, upperBounds: 64):
                betLine[spin] = "cherry";
                cherry += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 65, upperBounds: 65):
                betLine[spin] = "juice";
                juice += 1;
                break;
                
            default:
                betLine[spin] = "hardluck";
                hardluck += 1;
                break;
                
            }
        }
        return betLine;
    }
    
    /* This function calculates the player's winnings, if any */
    func determineWinnings()
    {
        if (hardluck == 0)
        {
            if (bell == 3) {
                winnerpaid = playerBet * 10;
                run(sound)
            }
            else if(seeven == 3) {
                winnerpaid = playerBet * 20;
                run(sound)
            }
            else if (watermellon == 3) {
                winnerpaid = playerBet * 30;
                run(sound)
            }
            else if (boxer == 3) {
                winnerpaid = playerBet * 40;
                run(sound)
            }
            else if (lemons == 3) {
                winnerpaid = playerBet * 50;
                run(sound)
            }
            else if (cherry == 3) {
                winnerpaid = playerBet * 75;
                run(sound)
            }
            else if (sevens == 3) {
                winnerpaid = playerBet * 100;
                run(sound)
            }
            else if (watermellon == 2) {
                winnerpaid = playerBet * 3;
            }
            else if (seeven == 2) {
                winnerpaid = playerBet * 2;
            }
            else if (bell == 2) {
                winnerpaid = playerBet * 2;
            }
            else if (boxer == 2) {
                winnerpaid = playerBet * 4;
                
            }
            else if (lemons == 2) {
                winnerpaid = playerBet * 5;
            }
            else if (cherry == 2) {
                winnerpaid = playerBet * 10;
            }
            else if (sevens == 2) {
                winnerpaid = playerBet * 20;
            }
           
           else {
                winnerpaid = playerBet * 1;
            }
            winno += 1;
            showWinMessage();
        }
        else
        {
            lossNumber += 1;
            showLossMessage();
        }
        
    }
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        let music = SKAudioNode(fileNamed: "Chill-house-music-loop-116-bpm.wav")
        addChild(music)
        
        music.isPositional = true
        music.position = CGPoint(x: -500, y: 500)
        
        let moveForward = SKAction.moveTo(x: 500, duration: 0.5)
        let moveBack = SKAction.moveTo(x: -500, duration: 0.5)
        let sequence = SKAction.sequence([moveForward, moveBack])
        let repeatForever = SKAction.repeatForever(sequence)
        
        music.run(repeatForever)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        slotmac = SKSpriteNode(imageNamed: "slotmachine")
        slotmac?.size = size
        addChild(slotmac!)

        
        
        spinbtn = SKSpriteNode(imageNamed: "spinButton")
        spinbtn?.position = CGPoint(x: 10, y: -187)
        spinbtn?.scale(to: CGSize(width:50, height:50))
        self.addChild(spinbtn!)
       
        
        // hardluck
        Diamond = SKSpriteNode(imageNamed: "hardluck")
        Diamond?.position = CGPoint(x: -90, y: -30)
        Diamond?.scale(to: CGSize(width:70, height:100))
        self.addChild(Diamond!)
        
        //hardluck
        
        Seven = SKSpriteNode(imageNamed: "hardluck")
        Seven?.position = CGPoint(x: 0, y: -30)
        Seven?.scale(to: CGSize(width:70, height:100))
        self.addChild(Seven!)
        
        //hardluck
        
        Bar = SKSpriteNode(imageNamed: "hardluck")
        Bar?.position = CGPoint(x: 90, y: -30)
        Bar?.scale(to: CGSize(width:70, height:100))
        self.addChild(Bar!)
        
        //bet5
        
        five = SKSpriteNode(imageNamed: "bet5")
        five?.position = CGPoint(x: -90, y: -170)
        five?.scale(to: CGSize(width:40, height:40))
        self.addChild(five!)
        
        //bet25
        
        twentyfive = SKSpriteNode(imageNamed: "bet25")
        twentyfive?.position = CGPoint(x: -50, y: -170)
        twentyfive?.scale(to: CGSize(width:40, height:40))
        self.addChild(twentyfive!)
        
        //bet50
        
        fifty = SKSpriteNode(imageNamed: "bet50")
        fifty?.position = CGPoint(x: 60, y: -170)
        fifty?.scale(to: CGSize(width:40, height:40))
        self.addChild(fifty!)
        
        //bet100
        
        onehundred = SKSpriteNode(imageNamed: "bet100")
        onehundred?.position = CGPoint(x: 100, y: -170)
        onehundred?.scale(to: CGSize(width:40, height:40))
        self.addChild(onehundred!)
        
     
    }
    func showPlayerStats()
    {
        winRatio = winno / turn;
        print("Jackpot: " , jackpot);
        
        let jackpotLabel = SKLabelNode(fontNamed:"Times New Roman")
        jackpotamount?.text="";
        jackpotLabel.text = jackpot.description
        //moneyLabel.text=" ";
        jackpotLabel.fontSize = 14
        jackpotLabel.position = CGPoint(x:0, y:75)
        self.addChild(jackpotLabel)
        self.jackpotamount = jackpotLabel
        
        
        
        print("Player Money: " , playerMoney);
        let moneyLabel = SKLabelNode(fontNamed:"Times New Roman")
        playmon?.text="";
        moneyLabel.text = playerMoney.description
        moneyLabel.fontSize = 14
        moneyLabel.position = CGPoint(x:-90, y:-115)
        self.addChild(moneyLabel)
        self.playmon = moneyLabel
        
        print("Total Turn: " , turn);
        print("Total Wins: " , winno);
        print("Total Losses: " , lossNumber);
        print("Win Ratio: " , (winRatio * 100) , "%");
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
           
            
            //let touch = touches.first!
            if (spinbtn?.contains(touch.location(in: self)))! {
                
                playerBet = currentplayerbetmoney;
                
                
                if (playerMoney == 0)
                {
                   
                    let alert = UIAlertView()
                    alert.title = "You ran out of Money! Do you want to play again"
                    alert.message = ""
                    alert.addButton(withTitle: "Ok")
                    alert.show()
                    resetAll();
                    showPlayerStats();
                }
                else if (playerBet > playerMoney) {
                    let alert = UIAlertView()
                    alert.title = "You don't have enough Money to place that bet."
                    alert.message = ""
                    alert.addButton(withTitle: "Ok")
                    alert.show()
                    
                    
                }
                else if (playerBet < 0) {
                   
                    let alert = UIAlertView()
                    alert.title = "Enter the positive bet amount..."
                    alert.message = ""
                    alert.addButton(withTitle: "Ok")
                    alert.show()
                }
                else if (playerBet <= playerMoney) {
                    resultofspin = Reels();
                    fruits = resultofspin[0] + " - " + resultofspin[1] + " - " + resultofspin[2];
                    //image here
                    
                    Diamond?.texture = SKTexture(imageNamed:resultofspin[0])
                    Seven?.texture = SKTexture(imageNamed:resultofspin[1])
                    Bar?.texture = SKTexture(imageNamed:resultofspin[2])
                    print("\n\n  1 line Result: " ,fruits);
                    determineWinnings();
                    turn += 1;
                    showPlayerStats();
                }
                else {
                    
                }
                
                
                
                
                
                
            }
            else if (five?.contains(touch.location(in: self)))! {
                
                currentplayerbetmoney = 5;
                let betamounts = SKLabelNode(fontNamed:"Times New Roman")
                betamount?.text="";
                betamounts.text = currentplayerbetmoney.description
                betamounts.fontSize = 14
                betamounts.position = CGPoint(x:0, y:-115)
                self.addChild(betamounts)
                self.betamount = betamounts
                
                
            }
            else if (twentyfive?.contains(touch.location(in: self)))! {
                
                currentplayerbetmoney = 25;
                let betamounts = SKLabelNode(fontNamed:"Times New Roman")
                betamount?.text="";
                betamounts.text = currentplayerbetmoney.description
                betamounts.fontSize = 14
                betamounts.position = CGPoint(x:0, y:-115)
                self.addChild(betamounts)
                self.betamount = betamounts
                
                
                
            }
            else if (fifty?.contains(touch.location(in: self)))! {
                
                currentplayerbetmoney = 50;
                let betamounts = SKLabelNode(fontNamed:"Times New Roman")
                betamount?.text="";
                betamounts.text = currentplayerbetmoney.description
                betamounts.fontSize = 14
                betamounts.position = CGPoint(x:0, y:-115)
                self.addChild(betamounts)
                self.betamount = betamounts
                
                
                
            }
            else if (onehundred?.contains(touch.location(in: self)))! {
                
                currentplayerbetmoney = 100;
                let betamounts = SKLabelNode(fontNamed:"Times New Roman")
                betamount?.text="";
                betamounts.text = currentplayerbetmoney.description
                betamounts.fontSize = 14
                betamounts.position = CGPoint(x:0, y:-115)
                self.addChild(betamounts)
                self.betamount = betamounts
                
                
                
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

