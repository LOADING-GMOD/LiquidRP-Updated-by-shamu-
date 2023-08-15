




local currencyThousandSeparator = ","

local function attachCurrency(str)
    local config = GAMEMODE.Config
    return config.currencyLeft and config.currency .. str or str .. config.currency
end

function PrettyFormatNumber(n)  // taken from the newest version of darkrp 

    if not n then return attachCurrency("0") end

    if n >= 1e14 then return attachCurrency(tostring(n)) end
    if n <= -1e14 then return "-" .. attachCurrency(tostring(math.abs(n))) end

    local config = GAMEMODE.Config

    local negative = n < 0

    n = tostring(math.abs(n))

    local dp = string.find(n, ".", 1, true) or #n + 1

    for i = dp - 4, 1, -3 do
     //   n = n:sub(1, i) .. config.currencyThousandSeparator .. n:sub(i + 1)

          n = n:sub(1, i) .. currencyThousandSeparator .. n:sub(i + 1)


    end

    -- Make sure the amount is padded with zeroes
    if n[#n - 1] == "." then
        n = n .. "0"
    end

    return (negative and "-" or "") .. attachCurrency(n)

end
