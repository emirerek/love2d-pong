Paddle = {}
Paddle.__index = Paddle

function Paddle:create(x, y, width, height, upKey, downKey)

    local newPaddle = {

        pos = {

            x = x,
            y = y

        },
        width = width,
        height = height,
        upKey = upKey,
        downKey = downKey,
        speed = 800,

    }
    
    setmetatable(newPaddle, Paddle)
    return newPaddle

end

function Paddle:moveUp(dt)

    self.pos.y = math.max(0, self.pos.y - self.speed * dt)

end

function Paddle:moveDown(dt)

    self.pos.y = math.min(love.graphics.getHeight() - self.height, self.pos.y + self.speed * dt)

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

    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)

end