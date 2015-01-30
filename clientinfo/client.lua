local sx, sy = guiGetScreenSize();
local info = {};

info.showed = false;
info.timer = 500;
info.x = sx - 50;
info.alpha = 100;

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
	local elapsedTime = getTickCount() - info.startTime;
	local progress = elapsedTime / info.timer;

	_, info.alpha, info.x = interpolateBetween( 
		0, info.alpha, info.x,
		0, 200, sx - 350, 
		progress, 'InOutQuad');

	if progress >= 1 then
		removeEventHandler('onClientRender', root, showFunction);
	end
end

local function hideFunction()
	local elapsedTime = getTickCount() - info.startTime;
	local progress = elapsedTime / info.timer;

	_, info.alpha, info.x = interpolateBetween( 
		0, info.alpha, info.x, 
		0, 100, sx - 50,
		progress, 'InOutQuad');

	if progress >= 1 then
		removeEventHandler('onClientRender', root, hideFunction);
	end
end

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

	dxDrawRectangle(info.x, sy / 2 - 150, 350, 300, tocolor(30, 30, 30, info.alpha), false);
	dxDrawRectangle(info.x, sy / 2 - 150, 50, 300, tocolor(90, 90, 255, info.alpha), false);
	dxDrawImage(info.x, sy / 2 - 150, 50, 300, 'title.png', 0, 0, 0, tocolor(255, 255, 255, info.alpha *1.2), false);

	dxDrawText(info.zoneString, info.x + 60, sy / 2 - 140, sx - 10, sy / 2 - 120, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 121, sx - 10, sy / 2 - 121, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText(math.ceil(info.posVector.x)..', '..math.ceil(info.posVector.y)..', '..math.ceil(info.posVector.z), info.x + 60, sy / 2 - 120, sx - 10, sy / 2 - 100, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 101, sx - 10, sy / 2 - 101, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('Rotation: '..math.ceil(info.rotVector.z)..', Skin: '..localPlayer.model, info.x + 60, sy / 2 - 100, sx - 10, sy / 2 - 80, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 81, sx - 10, sy / 2 - 81, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('Health: '..math.floor(localPlayer.health)..', Armor: '..math.ceil(localPlayer.armor), info.x + 60, sy / 2 - 80, sx - 10, sy / 2 - 60, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 61, sx - 10, sy / 2 - 61, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('Ping: '..localPlayer.ping..', FPS: '..math.ceil(info.fps), info.x + 60, sy / 2 - 60, sx - 10, sy / 2 - 40, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 41, sx - 10, sy / 2 - 41, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText(math.ceil(((info.velocityVector.x^2 + info.velocityVector.y^2 + info.velocityVector.z^2)^(0.5)) * 161)..' km/h', info.x + 60, sy / 2 - 40, sx - 10, sy / 2 - 20, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 21, sx - 10, sy / 2 - 21, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('$'..localPlayer:getMoney(), info.x + 60, sy / 2 - 20, sx - 10, sy / 2, tocolor(0, 220, 0, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 - 1, sx - 10, sy / 2 - 1, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('Oxygen: '..math.ceil(localPlayer.oxygenLevel/10)..'%', info.x + 60, sy / 2, sx - 10, sy / 2 + 20, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 + 19, sx - 10, sy / 2 + 19, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText(('You %s be knocked off bike.'):format(localPlayer:canBeKnockedOffBike() and 'can' or 'can\'t'), info.x + 60, sy / 2 + 20, sx - 10, sy / 2 + 40, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 + 39, sx - 10, sy / 2 + 39, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText(('You %shave a jetpack.'):format(localPlayer:doesHaveJetPack() and '' or 'don\'t '), info.x + 60, sy / 2 + 40, sx - 10, sy / 2 + 60, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 + 59, sx - 10, sy / 2 + 59, tocolor(65, 65, 65, info.alpha), 1, false);

	dxDrawText('Interior: '..localPlayer.interior..', Dimension: '..localPlayer.dimension, info.x + 60, sy / 2 + 60, sx - 10, sy / 2 + 80, tocolor(255, 255, 255, info.alpha), 1, 'default', 'left', 'center', true, false, false);
	dxDrawLine(info.x + 55, sy / 2 + 79, sx - 10, sy / 2 + 79, tocolor(65, 65, 65, info.alpha), 1, false);
end

addEventHandler('onClientRender', root, drawInfo);

local function showOrHide()
	info.startTime = getTickCount();

	if (info.showed) then
		removeEventHandler('onClientRender',root,showFunction);
		addEventHandler('onClientRender',root,hideFunction);
	else
		addEventHandler('onClientRender',root,showFunction);
		removeEventHandler('onClientRender',root,hideFunction);
	end;

	info.showed = not info.showed;
end

addEventHandler('onClientResourceStart', resourceRoot, function()
	bindKey('i', 'down', showOrHide);
end);