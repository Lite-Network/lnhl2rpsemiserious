local PANEL = {}

function PANEL:Init()
    self:SetTitle("")
    self:SetSize(800, 700)
    self:Center()
    self:MakePopup()

    self.dealerTable = {}
    self:SetupDealer()
end

function PANEL:SetupDealer()
    local ply = LocalPlayer()

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 128
	trace.filter = ply

    local traceEnd = util.TraceLine(trace)
    local entity = traceEnd.Entity
    self.dealerType = entity:GetNWInt("ixDealerType", 0)

    if ( entity and IsValid(entity) and entity:GetClass("ix_dealer") ) then
        if not ( self.dealerType == 0 ) then
            print("Dealer Approved!")
        else
            print("Dealer has unknown type!")
            return self:Remove()
        end
    else
        print("Dealer not Approved!")
        return self:Remove()
    end
    
    self.dealerTable = ix.dealers.data[self.dealerType]
    PrintTable(self.dealerTable)

    self.panelTop = self:Add("DPanel")
    self.panelTop:Dock(TOP)
    self.panelTop:DockMargin(5, 5, 5, 5)
    self.panelTop:SetSize(self:GetWide() - 10, 60)
    self.panelTop.Paint = function(self, w, h)
        surface.SetDrawColor(20, 20, 20, 100)
        surface.DrawRect(0, 0, w, h)
    end

    self.panelBuy = self:Add("DScrollPanel")
    self.panelBuy:SetSize(self:GetWide() / 2 - 15, 0)
    self.panelBuy:Dock(LEFT)
    self.panelBuy:DockMargin(5, 5, 5, 5)
    self.panelBuy.Paint = function(self, w, h)
        surface.SetDrawColor(20, 20, 20, 100)
        surface.DrawRect(0, 0, w, h)
    end

    for k, v in SortedPairs(self.dealerTable.buying) do
        local itemTable = ix.item.Get(k)
        self.buyButton = self.panelBuy:Add("ixMenuButton")
        self.buyButton:SetText("      "..itemTable.name)
        self.buyButton:SetFont("ixMediumFont")
        self.buyButton:Dock(TOP)
        self.buyButton:SetTall(40)
        self.buyButton.DoClick = function()
        end
        
        self.buyButtonIcon = self.buyButton:Add("SpawnIcon")
        self.buyButtonIcon:SetModel(itemTable.model)
        self.buyButtonIcon:SetSize(40, 40)
        self.buyButtonIcon:Dock(LEFT)
    end

    self.panelSell = self:Add("DScrollPanel")
    self.panelSell:SetSize(self:GetWide() / 2 - 15, 0)
    self.panelSell:Dock(RIGHT)
    self.panelSell:DockMargin(5, 5, 5, 5)
    self.panelSell.Paint = function(self, w, h)
        surface.SetDrawColor(20, 20, 20, 100)
        surface.DrawRect(0, 0, w, h)
    end

    self.dealerNick = self.panelTop:Add("ixLabel")
    self.dealerNick:SetText(entity:GetNWString("ixDealerName", "Invalid Nickname"))
    self.dealerNick:SetFont("ixMediumFont")
    self.dealerNick:Dock(LEFT)
    self.dealerNick:DockMargin(5, 5, 5, 5)
    self.dealerNick:SetContentAlignment(4)
    self.dealerNick:SizeToContents()

    self.dealerDesc = self.panelTop:Add("RichText")
    self.dealerDesc:SetText(self.dealerTable.description)
    self.dealerDesc:Dock(FILL)
    self.dealerDesc:DockMargin(5, 5, 5, 5)
    self.dealerDesc:SizeToContents()
    self.dealerDesc.PerformLayout = function(self)
        self:SetFontInternal("ixSmallFont")
    end
end

vgui.Register("LiteNetworkDealer", PANEL, "DFrame")