--[[

cannonball - Calculate cannonball trajectory.
BSD license.
by Sven Nilsen, 2012
http://www.cutoutpro.com

Version: 0.000 in angular degrees version notation
http://isprogrammingeasy.blogspot.no/2012/08/angular-degrees-versioning-notation.html

It is actually a challenge to calculate which angle to shoot when the velocity is fixed on a cannon.
This algorithm uses the relationship between distance (s), gravity (g) and velocity (v):

  2 * vx * vy = g * s
  
  vx^2 + vy^2 = v

This is only valid when the ball is shot from the same level as the target.
The solution provides two solutions, one fast trajectory and one slower.
At 45 degrees, these two solutions becomes one, which is the most distant possible target.

--]]

--[[
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of the FreeBSD Project.
--]]

if not cutoutpro then
  cutoutpro = {}
end

if not cutoutpro.cannonball then
  cutoutpro.cannonball = {}
end

-- Calculates the possible angles to shoot to hit a distance.
-- The first angle returned is the shortest path, the second is longer.
-- When there is not enough velocity, the result will be nan.
function cutoutpro.cannonball.angleInRadians(gravity, distance, velocity)
  local x = gravity * distance
  local v2 = velocity * velocity
  local a = math.sqrt(v2 * v2 - x * x)
  local vyHigh = math.sqrt((v2 + a)/2)
  local vyLow = math.sqrt((v2 - a)/2)
  local vxHigh = math.sqrt(v2 - vyHigh * vyHigh)
  local vxLow = math.sqrt(v2 - vyLow * vyLow)
  return math.atan2(vyLow, vxLow), math.atan2(vyHigh, vxHigh)
end

