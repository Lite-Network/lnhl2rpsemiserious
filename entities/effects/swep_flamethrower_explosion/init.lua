//Main function
function EFFECT:Init(data)


//Default performance settings
local DrawFlame = 1
local DrawSmoke = 1
local DrawRefraction = 0

//Adjust performance depending on user settings
local PerfIndex = GetConVar("flamethrower_fx"):GetInt()
if PerfIndex == 3 then DrawRefraction = 1 end


//Play impact sound
sound.Play("ambient/fire/ignite.wav", self:GetPos(), 54, math.random(82,112))


	//Draw burst of flame
	if DrawFlame == 1 then

	//Create particle emmiter
	local FlameEmitter = ParticleEmitter(data:GetOrigin())

		//Amount of particles to create
		for i=0, 16 do

			//Safeguard
			if !FlameEmitter then return end

			//Pool of flame sprites
			local FlameMat = {}
			FlameMat[1] = "effects/muzzleflash2"
			FlameMat[2] = "effects/muzzleflash2edit"
			FlameMat[3] = "effects/muzzleflash3"

			local FlameParticle = FlameEmitter:Add( FlameMat[math.random(1,3)], data:GetOrigin() )

			//Refraction is too expensive to render on most machines
			if DrawRefraction == 1 then
			if math.random(1,12) == 12 then
			FlameParticle = FlameEmitter:Add( "sprites/heatwave", data:GetOrigin() )
			end
			end

			if (FlameParticle) then

				FlameParticle:SetVelocity( VectorRand() * 172 )
				
				FlameParticle:SetLifeTime(0)
				FlameParticle:SetDieTime(0.72)
				
				FlameParticle:SetStartAlpha(210)
				FlameParticle:SetEndAlpha(0)
				
				FlameParticle:SetStartSize(0)
				FlameParticle:SetEndSize(64)
				
				FlameParticle:SetRoll(math.Rand(-210, 210))
				FlameParticle:SetRollDelta(math.Rand(-3.2, 3.2))
				
				FlameParticle:SetAirResistance(350)
				
				FlameParticle:SetGravity(Vector(0, 0, 64))

			end
		end

	//We're done with this emmiter
	FlameEmitter:Finish()

	//Finished with flame
	end


	//Draw stream of smoke
	if DrawSmoke == 1 then

	//Create particle emmiter
	local SmokeEmitter = ParticleEmitter(data:GetOrigin())

		//Amount of particles to create
		for i=0, 4 do

			//Safeguard
			if !SmokeEmitter then return end

			SmokeParticle = SmokeEmitter:Add( "particle/smokesprites_000" .. math.random(1,8) .. "", data:GetOrigin() )

			if (SmokeParticle) then

				SmokeParticle:SetVelocity( VectorRand() * 210 )
				
				SmokeParticle:SetLifeTime(0)
				SmokeParticle:SetDieTime( math.Rand(1.92, 2.82) )
				
				SmokeParticle:SetStartAlpha(82)
				SmokeParticle:SetEndAlpha(0)
				
				SmokeParticle:SetStartSize(21)
				SmokeParticle:SetEndSize(82)
				
				SmokeParticle:SetRoll(math.Rand(-320, 320))
				SmokeParticle:SetRollDelta(math.Rand(-1.32, 1.32))
				
				SmokeParticle:SetAirResistance(420)
				
				SmokeParticle:SetGravity(Vector( 0, 0, math.random(112, 132) ))

				SmokeParticle:SetLighting(1)

			end
		end

	//We're done with this emmiter
	SmokeEmitter:Finish()

	//Finished with smoke
	end


end

//Kill effect
function EFFECT:Think()
return false
end

//Unused
function EFFECT:Render()
end