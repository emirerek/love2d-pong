Paddle = {}
Paddle.__index = Paddle

function Paddle:create(x, y, width, heigth)

    local newPaddle = {

        x = x,
        y = y,
        width = width,
        heigth = heigth,
        speed = 800,

    }
    
    setmetatable(newPaddle, Paddle)
    return newPaddle

end

function Paddle:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.heigth)

end

function Paddle:moveUp(dt)

    self.y = math.max(0, self.y - self.speed * dt)

end

function Paddle:moveDown(dt)

    self.y = math.min(love.graphics.getHeight() - self.heigth, self.y + self.speed * dt)

end