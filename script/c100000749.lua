--brave
function c100000749.initial_effect(c)
c:SetUniqueOnField(1,0,100000749)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x753),8,2)
	c:EnableReviveLimit()
	--Remove self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000749,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c100000749.sptg)
	e1:SetOperation(c100000749.spop)
	c:RegisterEffect(e1)
	--seother
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000749,1))
	e2:SetCountLimit(1,100000749)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c100000749.remcon)
	e2:SetTarget(c100000749.remtg)
	e2:SetOperation(c100000749.remop)
	c:RegisterEffect(e2)
	--Negate
	local e3=Effect.CreateEffect(c)
	e3:SetCountLimit(1,100000749)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetDescription(aux.Stringid(100000749,2))
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000749.discon)
	e3:SetCost(c100000749.cost)
	e3:SetTarget(c100000749.targetg)
	e3:SetOperation(c100000749.operationg)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetOperation(c100000749.regop)
	c:RegisterEffect(e4)
	--dam
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e21:SetDescription(aux.Stringid(100000749,1))
	e21:SetCategory(CATEGORY_DAMAGE)
	e21:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e21:SetRange(LOCATION_MZONE)
	e21:SetCountLimit(1)
	e21:SetCondition(c100000749.damcon7)
	e21:SetTarget(c100000749.damtg7)
	e21:SetOperation(c100000749.damop7)
	c:RegisterEffect(e21)
	--atkup
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_UPDATE_ATTACK)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c100000749.val)
	c:RegisterEffect(e8)
	--defup
	local e9=e8:Clone()
	e9:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e9)
end
function c100000749.val(e,c)
	return Duel.GetMatchingGroupCount(c100000749.vfilter,c:GetControler(),LOCATION_GRAVE+LOCATION_REMOVED,0,nil)*200
end
function c100000749.vfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x753) and c:IsType(TYPE_MONSTER)
end
function c100000749.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c100000749.damcon7(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000749.damtg7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,800)
end
function c100000749.damop7(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000749.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(100000749)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c100000749.spop(e,tp,eg,ep,ev,re,r,rp)
		if e:GetHandler():IsRelateToEffect(e) then end
		Duel.Remove(e:GetHandler(),nil,nil,REASON_EFFECT)
end
function c100000749.remcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return bit.band(r,REASON_EFFECT) and re:GetHandler():IsSetCard(0x753)
end
function c100000749.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000749.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c100000749.filter(c)
	return c:IsAbleToHand() and c:IsCode(100000876)
end
function c100000749.remop(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100000749.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c100000749.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFaceup() then
		e:GetHandler():RegisterFlagEffect(100000749,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c100000749.targetg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then end
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c100000749.operationg(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then end
		Duel.Destroy(eg,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	end
function c100000749.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end