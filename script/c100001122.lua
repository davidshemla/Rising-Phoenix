--created and scripted by rising phoenix
function c100001122.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,100001102,100001106,false,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
		--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c100001122.efilter)
	c:RegisterEffect(e5)
		--remove
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(100001122,0))
	e7:SetCategory(CATEGORY_REMOVE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_BATTLE_START)
	e7:SetTarget(c100001122.rmtg)
	e7:SetOperation(c100001122.rmop)
	c:RegisterEffect(e7)
	--special summon
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(100001122,0))
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e8:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e8:SetRange(LOCATION_MZONE)
		e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetCondition(c100001122.spcon)
	e8:SetCost(c100001122.spcost)
	e8:SetTarget(c100001122.sptg)
	e8:SetOperation(c100001122.spop)
	c:RegisterEffect(e8)
	end
	function c100001122.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(100001122)==0
end
function c100001122.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckOrExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c100001122.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100001122.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=1
		and Duel.IsExistingTarget(c100001122.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,100001100)
		and Duel.IsExistingTarget(c100001122.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,100001104) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c100001122.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,100001100)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c100001122.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,100001104)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,2,0,0)
end
function c100001122.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=2 or ft<2 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	function c100001122.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsControler(1-tp) and tc:IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
end
function c100001122.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end
function c100001122.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end