 --Created and coded by Rising Phoenix
function c100000926.initial_effect(c)
	--atk def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000926,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c100000926.target)
	e1:SetOperation(c100000926.operation)
	c:RegisterEffect(e1)
		--spsummon proc
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c100000926.hspcon)
	e4:SetOperation(c100000926.hspop)
	c:RegisterEffect(e4)
		--seother
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000926,1))
		e2:SetCountLimit(1)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c100000926.remcon)
	e2:SetTarget(c100000926.remtg)
	e2:SetOperation(c100000926.remop)
	c:RegisterEffect(e2)
end
function c100000926.spfilter(c)
	return c:IsSetCard(0x757) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c100000926.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000926.spfilter,c:GetControler(),LOCATION_GRAVE+LOCATION_HAND,0,1,c)
end
function c100000926.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c100000926.spfilter,c:GetControler(),LOCATION_GRAVE+LOCATION_HAND,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100000926.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c100000926.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c100000926.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000926.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c100000926.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000926.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(tc:GetBaseDefense())
		e2:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CHANGE_RACE)
			if tc:IsHasEffect(EFFECT_ADD_RACE) and not tc:IsHasEffect(EFFECT_CHANGE_RACE) then
				e3:SetValue(tc:GetOriginalRace())
			else
				e3:SetValue(tc:GetRace())
			end
			e3:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			if tc:IsHasEffect(EFFECT_ADD_ATTRIBUTE) and not tc:IsHasEffect(EFFECT_CHANGE_ATTRIBUTE) then
				e4:SetValue(tc:GetOriginalAttribute())
			else
				e4:SetValue(tc:GetAttribute())
			end
			e4:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e4)
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE)
			e5:SetCode(EFFECT_CHANGE_LEVEL)
			e5:SetValue(tc:GetLevel())
			e5:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e5)
				local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetCode(EFFECT_CHANGE_CODE)
		e6:SetValue(tc:GetOriginalCode())
		e6:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e6)
	end
end
function c100000926.remcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return bit.band(r,REASON_EFFECT) and re:GetHandler():IsSetCard(0x757)
end
function c100000926.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c100000926.filtermm(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000926.filtermm,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c100000926.filtermm,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c100000926.filtermm(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c100000926.remop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end