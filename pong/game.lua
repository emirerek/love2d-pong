Game = {}
Game.__index = Game

function Game:new()

    local newGame = {

        isRunning = false,
        turn = 1,
        playerOneScore = 0,
        playerTwoScore = 0,
        winner = nil
    
    }
    
    setmetatable(newGame, Game)
    return newGame

end

function Game:run()

    if self.isRunning == false then

        self.isRunning = true
    
    else

        self.isRunning = false

    end

end

function Game:reset()

    self.isRunning = false
    self.turn = 1
    self.playerOneScore = 0
    self.playerTwoScore = 0
    self.winner = nil

end

function Game:toggleTurn() 

    if self.turn == -1 then

        self.turn = 1
    
    else

        self.turn = -1

    end    

end

function Game:incrementPlayerOne()

    game.playerOneScore = game.playerOneScore + 1

end

function Game:incrementPlayerTwo()

    game.playerTwoScore = game.playerTwoScore + 1

end

function Game:checkStatus()

    if self.playerOneScore == 5 or self.playerTwoScore == 5 then

        if self.playerOneScore > self.playerTwoScore then

            self.winner = 0

        elseif self.playerTwoScore < self.playerOneScore then

            self.winner = 1

        end

    end

end

function Game:renderScores(windowWidth, windowHeigth)

    love.graphics.print(self.playerOneScore, windowWidth / 2 - windowWidth / 4, windowHeigth / 10)
    love.graphics.print(self.playerTwoScore, windowWidth / 2 + windowWidth / 4, windowHeigth / 10)

end

function Game:renderWinner(windowWidth, windowHeigth)

    if self.winner == 0 then

        love.graphics.print("Player 1 won!", windowWidth / 2, windowHeigth / 10)

    else

        love.graphics.print("Player 2 won!", windowWidth / 2, windowHeigth / 10)

    end

end
