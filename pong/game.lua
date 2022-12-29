Game = {}
Game.__index = Game

function Game:new()

    local newGame = {

        isRunning = false,
        turn = 1,
        playerOneScore = 0,
        playerTwoScore = 0,
        isRunning = false,
        winner = nil
    
    }
    
    setmetatable(newGame, Game)
    return newGame

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

function Game:decideWinner() 

    if self.playerOneScore > self.playerTwoScore then

        self.winner = 0

    elseif self.playerTwoScore > self.playerOneScore then

        self.winner = 1

    end

end

function Game:didEnd()

    if self.playerOneScore == 5 or self.playerTwoScore == 5 then
        
        return true

    end

    return false

end

function Game:renderLines() 

    love.graphics.setLineWidth(8)
    local lineHeight = 18
    local lineGap = 36
    local middle = WINDOW_WIDTH / 2 - 4

    for i = -9, WINDOW_HEIGHT, lineGap do

        love.graphics.line(middle, i, middle, i + lineHeight)

    end

end

function Game:renderScores()

    love.graphics.print(self.playerOneScore, WINDOW_WIDTH / 2 - WINDOW_WIDTH / 4, WINDOW_HEIGHT / 10)
    love.graphics.print(self.playerTwoScore, WINDOW_WIDTH / 2 + WINDOW_WIDTH / 4, WINDOW_HEIGHT / 10)

end

function Game:renderWinner()

    local winner, message

    if self.winner == 0 then

        winner = "Player One"

    else 

        winner = "Player Two"

    end

    message = winner .. " has won the game!"

    love.graphics.print(message, 120, 200)

end
