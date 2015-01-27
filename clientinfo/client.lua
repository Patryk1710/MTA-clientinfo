local sx, sy = guiGetScreenSize();
local timer = 500;
local info = {};
local showed = true;

local x = sx - 50;
local alpha = 100;

local fps;
info.fps = 0;
local function getCurrentFPS()
    return fps;
end
 
local function updateFPS(msSinceLastFrame)
    fps = (1 / msSinceLastFrame) * 1000;
end
addEventHandler('onClientPreRender', root, updateFPS);

setTimer(function()
	info.fps = fps;
end, 1000, 0);

local function showFunction()
	local now = getTickCount();
	local elapsedTime = now - info.startTime;
	local duration = timer;
	local progress = elapsedTime / duration;

	_, alpha, x = interpolateBetween ( 
		0, alpha, x,
		0, 200, sx - 350, 
		progress, 'InOutQuad');
end;

local function hideFunction()
	local now = getTickCount();
	local elapsedTime = now - info.startTime;
	local duration = timer;
	local progress = elapsedTime / duration;

	_, alpha, x = interpolateBetween ( 
		0, alpha, x, 
		0, 100, sx - 50,
		progress, 'InOutQuad');
end;

local function drawInfo()
	info.posVector = localPlayer.position;
	info.rotVector = localPlayer.rotation;
	info.zone = getZoneName (info.posVector.x, info.posVector.y, info.posVector.z, false);
	info.city = getZoneName (info.posVector.x, info.posVector.y, info.posVector.z, true);
	local vx, vy, vz = 0, 0, 0;

	if (localPlayer.inVehicle) then
		local vehicle = localPlayer.vehicle;
		info.velocityVector = vehicle.velocity;
	else
		info.velocityVector = localPlayer.velocity;
	end;

	if info.zone == info.city then
		info.zoneString = info.zone;
	else
		info.zoneString = info.zone..', '..info.city;
	end;

	dxDrawRectangle(x, sy / 2 - 150, 350, 300, tocolor(30, 30, 30, alpha), false);
	dxDrawRectangle(x, sy / 2 - 150, 50, 300, tocolor(90, 90, 255, alpha), false);
	dxDrawImage(x, sy / 2 - 150, 50, 300, 'title.png', 0, 0, 0, tocolor (255, 255, 255, alpha *1.2), false);

	dxDrawText(info.zoneString, x + 60, sy / 2 - 140, sx - 10, sy / 2 - 120, tocolor( 255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 121, sx - 10, sy / 2 - 121, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText(math.ceil(info.posVector.x)..', '..math.ceil(info.posVector.y)..', '..math.ceil(info.posVector.z), x + 60, sy / 2 - 120, sx - 10, sy / 2 - 100, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 101, sx - 10, sy / 2 - 101, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText('Rotation: '..math.ceil(info.rotVector.z)..', Skin: '..localPlayer.model, x + 60, sy / 2 - 100, sx - 10, sy / 2 - 80, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 81, sx - 10, sy / 2 - 81, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText('Health: '..math.floor(localPlayer.health)..', Armor: '..math.ceil(localPlayer.armor), x + 60, sy / 2 - 80, sx - 10, sy / 2 - 60, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 61, sx - 10, sy / 2 - 61, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText('Ping: '..localPlayer.ping..', FPS: '..math.ceil(info.fps), x + 60, sy / 2 - 60, sx - 10, sy / 2 - 40, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 41, sx - 10, sy / 2 - 41, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText(math.ceil(((info.velocityVector.x^2 + info.velocityVector.y^2 + info.velocityVector.z^2)^(0.5)) * 161)..' km/h', x + 60, sy / 2 - 40, sx - 10, sy / 2 - 20, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 21, sx - 10, sy / 2 - 21, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText('$'..localPlayer:getMoney(), x + 60, sy / 2 - 20, sx - 10, sy / 2, tocolor(0, 220, 0, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 - 1, sx - 10, sy / 2 - 1, tocolor (65, 65, 65, alpha), 1, false);

	dxDrawText('Oxygen: '..math.ceil(localPlayer.oxygenLevel/10)..'%', x + 60, sy / 2, sx - 10, sy / 2 + 20, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 + 19, sx - 10, sy / 2 + 19, tocolor(65, 65, 65, alpha), 1, false);

	dxDrawText(('You %s be knocked off bike.'):format(localPlayer:canBeKnockedOffBike() and 'can' or 'can\'t'), x + 60, sy / 2 + 20, sx - 10, sy / 2 + 40, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 + 39, sx - 10, sy / 2 + 39, tocolor(65, 65, 65, alpha), 1, false);

	dxDrawText(('You %shave a jetpack.'):format(localPlayer:doesHaveJetPack() and '' or 'don\'t '), x + 60, sy / 2 + 40, sx - 10, sy / 2 + 60, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 + 59, sx - 10, sy / 2 + 59, tocolor(65, 65, 65, alpha), 1, false);

	dxDrawText('Interior: '..localPlayer.interior..', Dimension: '..localPlayer.dimension, x + 60, sy / 2 + 60, sx - 10, sy / 2 + 80, tocolor(255, 255, 255, alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(x + 55, sy / 2 + 79, sx - 10, sy / 2 + 79, tocolor(65, 65, 65, alpha), 1, false);
end;

addEventHandler('onClientRender', root, drawInfo);

local function showOrHide()
	info.startTime = getTickCount();
	showed = not showed;

	if (showed) then
		removeEventHandler('onClientRender',root,showFunction);
		addEventHandler('onClientRender',root,hideFunction);
	else
		addEventHandler('onClientRender',root,showFunction);
		removeEventHandler('onClientRender',root,hideFunction);
	end;
end;

addEventHandler('onClientResourceStart', resourceRoot, function()
	bindKey ('i', 'down', showOrHide);
	info.startTime = getTickCount();
end);