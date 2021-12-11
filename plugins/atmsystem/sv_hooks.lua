local plugin = PLUGIN
local ix = ix or {}
ix.ATM = ix.ATM or {}

function ix.ATM:GetMoney(ply)
    return ply:GetCharacter():GetData("ix.ATM.Money") or 0
end

function ix.ATM:DepositMoney(ply, amount)
    if !isnumber(amount) then return end
    if IsValid(ply) then
        local char = ply:GetCharacter()
        char:SetMoney(char:GetMoney() - amount)
        char:SetData("ix.ATM.Money", math.abs(char:GetData("ix.ATM.Money", 0) + amount))
    end
end

function ix.ATM:WithdrawMoney(ply, amount)
    if !isnumber(amount) then return end
    if IsValid(ply) then
        local char = ply:GetCharacter()
        char:SetMoney(char:GetMoney() + amount)
        char:SetData("ix.ATM.Money", math.abs(char:GetData("ix.ATM.Money", 0) - amount))
    end
end

function ix.ATM:AbortMoney(ply)
    if IsValid(ply) then
        local char = ply:GetCharacter()
        if not char then return end
        char:SetData("ix.ATM.Money", 0)
    end
end