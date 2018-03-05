#-------------------------------------------------
#
# Project created by QtCreator 2018-01-23T23:00:24
#
#-------------------------------------------------

QT       -= gui

TARGET = sc2-gamedata
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    main.cpp

HEADERS += \
    Abil.h \
    Achievement.h \
    AchievementTerm.h \
    Actor.h \
    ActorSupport.h \
    Alert.h \
    ArmyCategory.h \
    ArmyUnit.h \
    ArmyUpgrade.h \
    AttachMethod.h \
    BankCondition.h \
    Beam.h \
    Behavior.h \
    Button.h \
    Camera.h \
    Character.h \
    Cliff.h \
    CliffMesh.h \
    Conversation.h \
    ConversationState.h \
    Cursor.h \
    DSP.h \
    Effect.h \
    Error.h \
    Footprint.h \
    FoW.h \
    Game.h \
    GameData.h \
    GameUI.h \
    Herd.h \
    HerdNode.h \
    Hero.h \
    HeroAbil.h \
    HeroStat.h \
    Item.h \
    ItemClass.h \
    ItemContainer.h \
    Light.h \
    Location.h \
    Loot.h \
    Map.h \
    Model.h \
    Mover.h \
    Objective.h \
    PhysicsMaterial.h \
    Preload.h \
    Race.h \
    Requirement.h \
    RequirementNode.h \
    Reverb.h \
    Reward.h \
    ScoreResult.h \
    ScoreValue.h \
    Sound.h \
    Soundtrack.h \
    TacCooldown.h \
    Tactical.h \
    TargetFind.h \
    TargetSort.h \
    Terrain.h \
    TerrainObject.h \
    TerrainTex.h \
    Texture.h \
    Tile.h \
    Turret.h \
    UnderlyingTypes.h \
    Unit.h \
    Upgrade.h \
    User.h \
    Validator.h \
    Water.h \
    Weapon.h
unix {
    target.path = /usr/lib
    INSTALLS += target
}
