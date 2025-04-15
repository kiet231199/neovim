Api = {}

local icons = {
    external = {
        left = '', right = '',
        -- left = '', right = '',
    },
    internal = {
        left_t = '', right = '',
        -- left = '', right = '',
    },
}

Api.get_icon = function()
    return icons
end

return Api
