setDefaultTab("HP")
if voc() ~= 1 and voc() ~= 11 then
    if storage.foodItems then
        local t = {}
        for i, v in pairs(storage.foodItems) do
            if not table.find(t, v.id) then
                table.insert(t, v.id)
            end
        end
        local foodItems = { 11460, 8020, 3587, 6574, 3588, 8017, 3600, 11461, 3602, 3725, 8197, 10328, 6277, 6569, 3599, 3595, 3250, 11462, 3607, 3590, 8019, 3589, 11584, 6543, 6544, 6545, 6542, 6541, 3598, 3597, 6393, 10219, 8014, 3728, 6278, 11587, 3583, 11682, 11681, 3606, 3731, 3578, 6500, 3592, 3732, 7159, 3582, 7377, 7375, 7372, 7373, 8016, 8013, 6276, 8018, 3604, 5096, 901, 3577, 3593, 3580, 8015, 3586, 3726, 6279, 841, 3584, 11683, 11459, 8011, 11586, 8010, 3594, 7158, 8012, 3585, 3724, 10329, 3601, 3579, 3581, 3730, 3729, 3591, 11588, 10453, 3596, 5678, 6125, 6392, 836, 3723, 3727, 8177 }
        for i, item in pairs(foodItems) do
            if not table.find(t, item) then
                table.insert(storage.foodItems, item)
            end
        end
    end
	
    macro(2500, "Cast Food", function()
		for _, container in pairs(g_game.getContainers()) do
			for __, item in ipairs(container:getItems()) do
				for i, foodItem in ipairs(storage.foodItems) do
					if item:getId() == foodItem.id then return end
				end
			end
		end
		
		cast("exevo pan", 5000)
    end)
end

UI.Label("Eatable items:")
if type(storage.foodItems) ~= "table" then
  storage.foodItems = {3582, 3577}
end

local foodContainer = UI.Container(function(widget, items)
  storage.foodItems = items
end, true)
foodContainer:setHeight(70)
foodContainer:setItems(storage.foodItems)

macro(15000, "Eat Food", function()
  if player:getRegenerationTime() > 400 or not storage.foodItems[1] then return end
  -- search for food in containers
  for _, container in pairs(g_game.getContainers()) do
    for __, item in ipairs(container:getItems()) do
      for i, foodItem in ipairs(storage.foodItems) do
        if item:getId() == foodItem.id then
          return g_game.use(item)
        end
      end
    end
  end
end)
UI.Separator()