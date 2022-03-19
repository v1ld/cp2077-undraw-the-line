@wrapMethod(WeaponTransition)
  protected final func ShowAttackPreview(showIfAiming: Bool, weaponObject: ref<WeaponObject>, scriptInterface: ref<StateGameScriptInterface>, stateContext: ref<StateContext>) -> Void {
    this.Mod_UnDrawTheLine(weaponObject, scriptInterface);
    wrappedMethod(showIfAiming, weaponObject, scriptInterface, stateContext);
  }

@addMethod(WeaponTransition)
  private final func Mod_UnDrawTheLine(weaponObject: ref<WeaponObject>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
    let ricochetEnableStat: Float;
    let mod: ref<gameStatModifierData>;
    let statSystem: ref<StatsSystem> = scriptInterface.GetStatsSystem();
    let weaponRecord: ref<WeaponItem_Record> = weaponObject.GetWeaponRecord();

    if IsDefined(weaponRecord) && NotEquals(weaponRecord.PreviewEffectName(), n"") {
      if Equals(weaponRecord.PreviewEffectTag(), n"ricochet") {
        ricochetEnableStat = statSystem.GetStatValue(Cast<StatsObjectID>(scriptInterface.executionOwnerEntityID), gamedataStatType.CanSeeRicochetVisuals);
        if ricochetEnableStat <= 0.0 {
          mod = RPGManager.CreateStatModifier(gamedataStatType.CanSeeRicochetVisuals, gameStatModifierType.Additive, 1.0 - ricochetEnableStat);
          statSystem.AddSavedModifier(Cast<StatsObjectID>(weaponObject.GetEntityID()), mod);
        }
      }
    }
  }