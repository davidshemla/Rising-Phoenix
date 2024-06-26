--fieldsp
function c100001156.initial_effect(c)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100001156,0))
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetHintTiming(0,0x1e0)
	e3:SetOperation(c100001156.operation)
	e3:SetTarget(c100001156.target)
	e3:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e3)
end
function c100001156.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100001156.filt,tp,LOCATION_MZONE,0,1,nil) end
end
function c100001156.filt(c)
	return c:IsFaceup() and c:IsSetCard(0x750)
end
function c100001156.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c100001156.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100001156.filt,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetOperation(c100001156.operation)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e3:SetValue(c100001156.efilter)
	tc:RegisterEffect(e3)
	tc=g:GetNext()
	end
end