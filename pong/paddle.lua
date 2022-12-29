Paddle = {}
Paddle.__index = Paddle

function Paddle:create(x, y, width, height, upKey, downKey)

    local newPaddle = {

        x = x,
        y = y,
        width = width,
        height = height,
        upKey = upKey,
        downKey = downKey,
        speed = 600,

    }
    
    setmetatable(newPaddle, Paddle)
    return newPaddle

end

function Paddle:setPosition(x, y) 

    self.x = x
    self.y = y

end

function Paddle:moveUp(dt)

    self.y = math.max(0, self.y - self.speed * dt)

end

function Paddle:moveDown(dt)

    self.y = math.min(love.graphics.getHeight() - self.height, self.y + self.speed * dt)

end

function Paddle:move(dt) 

    if love.keyboard.isDown(self.upKey) then

        self:moveUp(dt)

    end

    if love.keyboard.isDown(self.downKey) then

        self:moveDown(dt)

    end

end

function Paddle:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end