/*
 * This file is part of the OregonCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "QuestDef.h"
#include "Player.h"
#include "World.h"

Quest::Quest(Field* questRecord)
{
    QuestId = questRecord[0].GetUInt32();
    QuestMethod = questRecord[1].GetUInt32();
    ZoneOrSort = questRecord[2].GetInt32();
    MinLevel = questRecord[3].GetUInt32();
    QuestLevel = questRecord[4].GetInt32();
    Type = questRecord[5].GetUInt32();
    RequiredClasses = questRecord[6].GetUInt32();
    RequiredRaces = questRecord[7].GetUInt32();
    RequiredSkill = questRecord[8].GetUInt32();
    RequiredSkillValue = questRecord[9].GetUInt32();
    RepObjectiveFaction = questRecord[10].GetUInt32();
    RepObjectiveValue = questRecord[11].GetInt32();
    RequiredMinRepFaction = questRecord[12].GetUInt32();
    RequiredMinRepValue = questRecord[13].GetInt32();
    RequiredMaxRepFaction = questRecord[14].GetUInt32();
    RequiredMaxRepValue = questRecord[15].GetInt32();
    SuggestedPlayers = questRecord[16].GetUInt32();
    LimitTime = questRecord[17].GetUInt32();
    QuestFlags = questRecord[18].GetUInt16();
    SpecialFlags = questRecord[19].GetUInt8();
    CharTitleId = questRecord[20].GetUInt32();
    PrevQuestId = questRecord[21].GetInt32();
    NextQuestId = questRecord[22].GetInt32();
    ExclusiveGroup = questRecord[23].GetInt32();
    NextQuestInChain = questRecord[24].GetUInt32();
    SrcItemId = questRecord[25].GetUInt32();
    SrcItemCount = questRecord[26].GetUInt32();
    SrcSpell = questRecord[27].GetUInt32();
    Title = questRecord[28].GetCppString();
    Details = questRecord[29].GetCppString();
    Objectives = questRecord[30].GetCppString();
    OfferRewardText = questRecord[31].GetCppString();
    RequestItemsText = questRecord[32].GetCppString();
    EndText = questRecord[33].GetCppString();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ObjectiveText[i] = questRecord[34 + i].GetCppString();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ReqItemId[i] = questRecord[38 + i].GetUInt32();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ReqItemCount[i] = questRecord[42 + i].GetUInt32();

    for (int i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
        ReqSourceId[i] = questRecord[46 + i].GetUInt32();

    for (int i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
        ReqSourceCount[i] = questRecord[50 + i].GetUInt32();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ReqCreatureOrGOId[i] = questRecord[54 + i].GetInt32();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ReqCreatureOrGOCount[i] = questRecord[58 + i].GetUInt32();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ReqSpell[i] = questRecord[62 + i].GetUInt32();

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        RewChoiceItemId[i] = questRecord[66 + i].GetUInt32();

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        RewChoiceItemCount[i] = questRecord[72 + i].GetUInt32();

    for (int i = 0; i < QUEST_REWARDS_COUNT; ++i)
        RewItemId[i] = questRecord[78 + i].GetUInt32();

    for (int i = 0; i < QUEST_REWARDS_COUNT; ++i)
        RewItemCount[i] = questRecord[82 + i].GetUInt32();

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        RewRepFaction[i] = questRecord[86 + i].GetUInt32();

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        RewRepValue[i] = questRecord[91 + i].GetInt32();

    RewHonorableKills = questRecord[96].GetUInt32();
    RewOrReqMoney = questRecord[97].GetInt32();
    RewMoneyMaxLevel = questRecord[98].GetUInt32();
    RewXP = questRecord[99].GetUInt32();
    RewSpell = questRecord[100].GetUInt32();
    RewSpellCast = questRecord[101].GetUInt32();
    RewMailTemplateId = questRecord[102].GetUInt32();
    RewMailDelaySecs = questRecord[103].GetUInt32();
    PointMapId = questRecord[104].GetUInt32();
    PointX = questRecord[105].GetFloat();
    PointY = questRecord[106].GetFloat();
    PointOpt = questRecord[107].GetUInt32();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        DetailsEmote[i] = questRecord[108 + i].GetUInt32();

    IncompleteEmote = questRecord[112].GetUInt32();
    CompleteEmote = questRecord[113].GetUInt32();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        OfferRewardEmote[i] = questRecord[114 + i].GetInt32();

    QuestStartScript = questRecord[118].GetUInt32();
    QuestCompleteScript = questRecord[119].GetUInt32();

    _reqItemsCount = 0;
    _reqCreatureOrGOcount = 0;
    _rewItemsCount = 0;
    _rewChoiceItemsCount = 0;

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
    {
        if (ReqItemId[i])
            ++_reqItemsCount;
        if (ReqCreatureOrGOId[i])
            ++_reqCreatureOrGOcount;
    }

    for (int i = 0; i < QUEST_REWARDS_COUNT; i++)
    {
        if (RewItemId[i])
            ++_rewItemsCount;
    }

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; i++)
    {
        if (RewChoiceItemId[i])
            ++_rewChoiceItemsCount;
    }
}

uint32 Quest::XPValue (Player* pPlayer) const
{
    if (pPlayer)
    {
        if (RewMoneyMaxLevel > 0)
        {
            uint32 pLevel = pPlayer->getLevel();
            uint32 qLevel = QuestLevel > 0 ? (uint32)QuestLevel : 0;
            float fullxp = 0;

            if (qLevel >= 65)
                fullxp = RewMoneyMaxLevel / 6.0f;
            else if (qLevel == 64)
                fullxp = RewMoneyMaxLevel / 4.8f;
            else if (qLevel == 63)
                fullxp = RewMoneyMaxLevel / 3.6f;
            else if (qLevel == 62)
                fullxp = RewMoneyMaxLevel / 2.4f;
            else if (qLevel == 61)
                fullxp = RewMoneyMaxLevel / 1.2f;
            else if (qLevel > 0 && qLevel <= 60)
                fullxp = RewMoneyMaxLevel / 0.6f;

            if (RewXP > 0)
            {
                fullxp = RewXP;
                return uint32(ceilf(fullxp));
            }
                

            if (pLevel <= qLevel + 5)
                return uint32(ceilf(fullxp));
            else if (pLevel == qLevel + 6)
                return uint32(ceilf(fullxp * 0.8f));
            else if (pLevel == qLevel + 7)
                return uint32(ceilf(fullxp * 0.6f));
            else if (pLevel == qLevel + 8)
                return uint32(ceilf(fullxp * 0.4f));
            else if (pLevel == qLevel + 9)
                return uint32(ceilf(fullxp * 0.2f));
            else
                return uint32(ceilf(fullxp * 0.1f));
        }
    }
    return 0;
}

int32 Quest::GetRewOrReqMoney() const
{
    if (RewOrReqMoney <= 0)
        return RewOrReqMoney;

    return int32(RewOrReqMoney * sWorld.getRate(RATE_DROP_MONEY));
}

