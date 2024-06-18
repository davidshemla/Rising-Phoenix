function c100001194.initial_effect(c)
	--atk
		local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_ATKCHANGE)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetCondition(c100001194.condition2)
	e7:SetTarget(c100001194.target2)
	e7:SetOperation(c100001194.operation2)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_ATKCHANGE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetCondition(c100001194.condition2)
	e8:SetTarget(c100001194.target2)
	e8:SetOperation(c100001194.operation2)
	c:RegisterEffect(e8)
		local e9=Effect.CreateEffect(c)
	e9:SetCategory(CATEGORY_ATKCHANGE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e9:SetCondition(c100001194.condition2)
	e9:SetTarget(c100001194.target2)
	e9:SetOperation(c100001194.operation2)
	c:RegisterEffect(e9)
		--special summon
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_SPSUMMON_PROC)
	e10:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e10:SetRange(LOCATION_HAND)
	e10:SetCondition(c100001194.spconm)
	c:RegisterEffect(e10)
		--shu
	local e12=Effect.CreateEffect(c)
	e12:SetCategory(CATEGORY_DRAW)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e12:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e12:SetCode(EVENT_TO_GRAVE)
		e12:SetCost(c100001194.cost)
	e12:SetTarget(c100001194.eqtga)
	e12:SetOperation(c100001194.eqopa)
	c:RegisterEffect(e12)
	
		--damage
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(100001194,1))
	e22:SetCategory(CATEGORY_DRAW)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCode(EVENT_SPSUMMON_SUCCESS)
		e22:SetCountLimit(1,100001194)
	e22:SetCondition(c100001194.condition)
	e22:SetTarget(c100001194.target)
	e22:SetOperation(c100001194.operation)
	c:RegisterEffect(e22)
	local e23=Effect.CreateEffect(c)
	e23:SetDescription(aux.Stringid(100001194,1))
	e23:SetCategory(CATEGORY_DRAW)
		e23:SetCountLimit(1,100001194)
	e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e23:SetRange(LOCATION_MZONE)
	e23:SetCode(EVENT_SUMMON_SUCCESS)
	e23:SetCondition(c100001194.condition)
	e23:SetTarget(c100001194.target)
	e23:SetOperation(c100001194.operation)
	c:RegisterEffect(e23)
	local e24=Effect.CreateEffect(c)
	e24:SetDescription(aux.Stringid(100001194,1))
	e24:SetCategory(CATEGORY_DRAW)
		e24:SetCountLimit(1,100001194)
	e24:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e24:SetRange(LOCATION_MZONE)
	e24:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e24:SetCondition(c100001194.condition)
	e24:SetTarget(c100001194.target)
	e24:SetOperation(c100001194.operation)
	c:RegisterEffect(e24)
end
function c100001194.condition(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c100001194.spfilterm,1,nil)
end
function c100001194.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c100001194.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c100001194.filter(c)
	return  c:IsSetCard(0x75D) and c:IsAbleToGraveAsCost() and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c100001194.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100001194.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100001194.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100001194.eqtga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100001194.eqopa(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c100001194.spfilterm(c)
	return c:IsFaceup() and c:IsSetCard(0x75D) and c:IsType(TYPE_MONSTER)
end
function c100001194.spconm(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100001194.spfilterm,tp,LOCATION_MZONE,0,1,nil)
end
function c100001194.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c100001194.cfilter,1,nil,tp)
end
function c100001194.cfilter(c,tp)
	return c:IsSetCard(0x75D) and c:IsFaceup()
end
function c100001194.target2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() end
end
function c100001194.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	end
end