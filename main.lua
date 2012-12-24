require "cutoutpro-cannonball"

local distance = 200
local gravity = 120
local velocity = 300
local ground = 400

local angle1, angle2
local bullet1
local bullet2
local bullets = {}

function addBullets()
  distance = love.mouse.getX()
  angle1, angle2 = cutoutpro.cannonball.angleInRadians(gravity, distance, velocity)
  angle1, angle2 = -angle1, -angle2
  bullet1 = {x = 0, y = ground, vx = math.cos(angle1)*velocity, vy = math.sin(angle1)*velocity}
  bullet2 = {x = 0, y = ground, vx = math.cos(angle2)*velocity, vy = math.sin(angle2)*velocity}
  bullets[#bullets+1] = bullet1
  bullets[#bullets+1] = bullet2
end

function love.load()
  addBullets()
end

function love.mousepressed()
  addBullets()
end

function moveBullets(bullets)
  local dt = love.timer.getDelta()
  for i = 1, #bullets do
    local bullet = bullets[i]
    bullet.vy = bullet.vy + 0.5 * gravity * dt
    bullet.x, bullet.y = bullet.x + bullet.vx * dt, bullet.y + bullet.vy * dt
    bullet.vy = bullet.vy + 0.5 * gravity * dt
  end
end

function drawBullets(bullets)
  love.graphics.setColor(0, 0, 0, 255)
  for i = 1, #bullets do
    local bullet = bullets[i]
    love.graphics.circle("fill", bullet.x, bullet.y, 5)
  end
end

function drawTarget()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.line(distance, 0, distance, h)
  love.graphics.line(0, ground, w, ground)
end

function love.update()
  moveBullets(bullets)
end

function love.draw()
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  
  drawBullets(bullets)
  drawTarget()
  
  -- Show how many bullets are shot.
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print(#bullets, 300, 300)
end
