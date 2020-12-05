local pnum = 0

local function register_present(c1, c2)
    minetest.register_node("presents:present_" .. tostring(pnum), {
        description = "Christmas Present",
        tiles = {
            "presents_blank.png^[multiply:" .. c1 .. "^(presents_bow.png^[multiply:" .. c2 .. ")",
            "presents_blank.png^[multiply:" .. c1 .. "^(presents_cross.png^[multiply:" .. c2 .. ")",
            "presents_blank.png^[multiply:" .. c1 .. "^(presents_line.png^[multiply:" .. c2 .. ")"
        },
        paramtype2 = "facedir",
        groups = {oddly_diggable_by_hand = 1, crumbly = 2},
        on_punch = function(pos, node, puncher, pointed_thing)
            if not puncher or not puncher:is_player() then return end
            minetest.chat_send_player(puncher:get_player_name(), "Bring this present to the Christmas shop to redeem it!")
        end
    })
    pnum = pnum + 1
end

register_present("#bb2528", "#146b3a")
register_present("#146b3a", "#bb2528")
register_present("#bb2528", "#f0f0f0")

minetest.register_on_dignode(function(pos, oldnode, digger)
    if not digger or not digger:is_player() then return end
    if math.random(1, 100) == 1 then
        minetest.item_drop(ItemStack("presents:present_" .. tostring(math.random(0, pnum - 1))), digger, pos)
    end
end)