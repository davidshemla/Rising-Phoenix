-- Created and scripted by Rising Phoenix
local s, id = GetID()

function s.initial_effect(c)
    -- Banish 5
    local e4 = Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(id, 2))
    e4:SetCountLimit(1, id)
    e4:SetCategory(CATEGORY_REMOVE)
    e4:SetType(EFFECT_TYPE_IGNITION)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCost(s.bancost)
    e4:SetCondition(s.bancon)
    e4:SetTarget(s.bantg)
    e4:SetOperation(s.banop)
    c:RegisterEffect(e4)
    
    -- Banish 10
    local e5 = Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(id, 3))
    e5:SetCountLimit(1, id)
    e5:SetCategory(CATEGORY_REMOVE)
    e5:SetType(EFFECT_TYPE_IGNITION)
    e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCost(s.bancost)
    e5:SetCondition(s.bancon2)
    e5:SetTarget(s.bantg2)
    e5:SetOperation(s.banop2)
    c:RegisterEffect(e5)
    
    -- Banish 15
    local e6 = Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(id, 4))
    e6:SetCountLimit(1, id)
    e6:SetCategory(CATEGORY_REMOVE)
    e6:SetType(EFFECT_TYPE_IGNITION)
    e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCost(s.bancost)
    e6:SetCondition(s.bancon3)
    e6:SetTarget(s.bantg3)
    e6:SetOperation(s.banop3)
    c:RegisterEffect(e6)
    
    -- Damage or recover
    local e21 = Effect.CreateEffect(c)
    e21:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e21:SetCategory(CATEGORY_DAMAGE)
    e21:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e21:SetRange(LOCATION_GRAVE)
    e21:SetCountLimit(1)
    e21:SetCondition(s.damcon7)
    e21:SetTarget(s.damtg7)
    e21:SetOperation(s.damop7)
    c:RegisterEffect(e21)
end

function s.cfilter(c)
    return c:IsSetCard(0x75F) and not c:IsPublic()
end

function s.bancost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(s.cfilter, tp, LOCATION_HAND, 0, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_CONFIRM)
    local g = Duel.SelectMatchingCard(tp, s.cfilter, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.ConfirmCards(1 - tp, g)
    Duel.ShuffleHand(tp)
end

function s.damcon7(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function s.damtg7(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_EFFECT)
    local op = Duel.SelectOption(tp, aux.Stringid(id, 0), aux.Stringid(id, 1))
    e:SetLabel(op)
    if op == 0 then
        e:SetCategory(CATEGORY_RECOVER)
        Duel.SetTargetPlayer(tp)
        Duel.SetTargetParam(300)
        Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, 0, tp, 300)
    else
        e:SetCategory(CATEGORY_DAMAGE)
        Duel.SetTargetPlayer(tp)
        Duel.SetTargetParam(300)
        Duel.SetOperationInfo(0, CATEGORY_DAMAGE, nil, 0, tp, 300)
    end
end

function s.damop7(e, tp, eg, ep, ev, re, r, rp)
    local p, d = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    if e:GetLabel() == 0 then
        Duel.Recover(p, d, REASON_EFFECT)
    else
        Duel.Damage(p, d, REASON_EFFECT)
    end
end

function s.bancon(e, tp, eg, ep, ev, re, r, rp)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    return Duel.GetLP(tp) <= 7000 and oppo_g:GetCount() > 0
end

function s.bantg(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(5, oppo_g:GetCount())
    if count <= 0 then
        return false
    end
    if chkc then
        return chkc:GetLocation() == LOCATION_GRAVE and chkc:IsAbleToRemove()
    end
    if chk == 0 then
        return Duel.IsExistingTarget(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectTarget(tp, Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, count, nil)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, #g, 0, 0)
end

function s.banop(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if not g then
        return
    end
    local sg = g:Filter(Card.IsRelateToEffect, nil, e)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(5, oppo_g:GetCount())
    local rg = oppo_g:RandomSelect(tp, count)
    Duel.Remove(rg, POS_FACEUP, REASON_EFFECT)
end

function s.bancon2(e, tp, eg, ep, ev, re, r, rp)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    return Duel.GetLP(tp) <= 5000 and oppo_g:GetCount() > 0
end

function s.bantg2(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(10, oppo_g:GetCount())
    if count <= 0 then
        return false
    end
    if chkc then
        return chkc:GetLocation() == LOCATION_GRAVE and chkc:IsAbleToRemove()
    end
    if chk == 0 then
        return Duel.IsExistingTarget(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectTarget(tp, Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, count, nil)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, #g, 0, 0)
end

function s.banop2(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if not g then
        return
    end
    local sg = g:Filter(Card.IsRelateToEffect, nil, e)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(10, oppo_g:GetCount())
    local rg = oppo_g:RandomSelect(tp, count)
    Duel.Remove(rg, POS_FACEUP, REASON_EFFECT)
end

function s.bancon3(e, tp, eg, ep, ev, re, r, rp)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    return Duel.GetLP(tp) <= 2000 and oppo_g:GetCount() > 0
end

function s.bantg3(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(15, oppo_g:GetCount())
    if count <= 0 then
        return false
    end
    if chkc then
        return chkc:GetLocation() == LOCATION_GRAVE and chkc:IsAbleToRemove()
    end
    if chk == 0 then
        return Duel.IsExistingTarget(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectTarget(tp, Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 1, count, nil)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, #g, 0, 0)
end

function s.banop3(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if not g then
        return
    end
    local sg = g:Filter(Card.IsRelateToEffect, nil, e)
    local oppo_g = Duel.GetMatchingGroup(Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, nil)
    local count = math.min(15, oppo_g:GetCount())
    local rg = oppo_g:RandomSelect(tp, count)
    Duel.Remove(rg, POS_FACEUP, REASON_EFFECT)
end