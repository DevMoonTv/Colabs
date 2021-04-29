function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got "..tostring(ped).."]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end

function dxDrawEmptyRec(absX, absY, sizeX, sizeY, color, ancho)
	dxDrawRectangle(absX, absY, sizeX, ancho, color)
	dxDrawRectangle(absX, absY + ancho, ancho, sizeY - ancho, color)
	dxDrawRectangle(absX + ancho, absY + sizeY - ancho, sizeX - ancho, ancho, color)
	dxDrawRectangle(absX + sizeX-ancho, absY + ancho, ancho, sizeY - ancho*2, color)
end

local counter = 0
local starttick
local currenttick

addEventHandler("onClientRender", getRootElement(),
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(getLocalPlayer(), "FPS", counter)
			counter = 0
			starttick = false
		end
	end
)

function secondsToTimeDesc(seconds)
	if seconds then
		local results = {}
		local sec = (seconds % 60)
		local min = math.floor((seconds % 3600) / 60)
		local hou = math.floor((seconds % 86400) / 3600)
		local day = math.floor(seconds / 86400)

		if day > 0 then table.insert(results, day..(day == 1 and " dia" or " dias")) end
		if hou > 0 then table.insert(results, hou..(hou == 1 and " hora" or " horas")) end
		if min > 0 then table.insert(results, min..(min == 1 and " minuto" or " minutos")) end
		if sec > 0 then table.insert(results, sec..(sec == 1 and " segundo" or " segundos")) end

		return string.reverse(table.concat(results, " : "):reverse():gsub(" : ", " : ", 1))
	end
	return ""
end

function openColorPicker()
	veiculo = getPedOccupiedVehicle(getLocalPlayer())
	if (veiculo) then
		colorPicker.openSelect(colors)
	end
end

function closedColorPicker()
	local r1, g1, b1, r2, g2, b2 = getVehicleColor(veiculo, true)
	local r, g, b = getVehicleHeadLightColor(veiculo)
	triggerServerEvent("cor1", getLocalPlayer(), r1, g1, b1, r2, g2, b2, veiculo)
	triggerServerEvent("cor2", getLocalPlayer(), r ,g, b, veiculo)
	setVehicleHeadLightColor(veiculo, r, g, b)
	veiculo = nil
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (veiculo and isElement(veiculo)) then
		local r1, g1, b1, r2, g2, b2 = getVehicleColor(veiculo, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor3)) then
			setVehicleHeadLightColor(veiculo, r, g, b)
		end
		setVehicleColor(veiculo, r1, g1, b1, r2, g2, b2)
	end
end
addEventHandler("onClientRender", getRootElement(), updateColor)
