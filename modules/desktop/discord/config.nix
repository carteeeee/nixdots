{...}: {
  meow.desktop.discord = {
    quickCss = ''
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");
      /* hide gift button, courtesy of thunder :3 */
      button[aria-label="Send a gift"] {
          display: none;
      }
    '';

    vesktopSettings = {
      discordBranch = "ptb";
      minimizeToTray = false;
      arRPC = true;
      splashTheming = true;
      splashColor = "rgb(205, 214, 244)";
      splashBackground = "rgb(17, 17, 27)";
    };

    vencordSettings = {
      autoUpdate = true;
      useQuickCss = true;
      plugins = {
        AccountPanelServerProfile.enabled = true;
        AlwaysExpandRoles.enabled = true;
        BetterRoleContext.enabled = true;
        BetterSessions = {
          enabled = true;
          backgroundCheck = true;
          checkInterval = 30; # minutes
        };
        CharacterCounter = {
          enabled = true;
          colorEffects = true;
        };
        ClearURLs.enabled = true;
        CopyFileContents.enabled = true;
        Decor.enabled = true;
        FakeNitro = {
          enabled = true;
          transformCompoundSentence = true;
        };
        ForceOwnerCrown.enabled = true;
        LoadingQuotes = {
          enabled = true;
          replaceEvents = false;
          enablePluginPresetQuotes = false;
          enableDiscordPresetQuotes = false;
          additionalQuotes = ":3|:33|:333";
          additionalQuotesDelimiter = "|";
        };
        MesageLatency = {
          enabled = true;
          latency = 1;
          showMillis = true;
        };
        MutualGroupDMs.enabled = true;
        NoF1.enabled = true;
        oneko.enabled = true;
        PermissionsViewer.enabled = true;
        petpet.enabled = true;
        PlatformIndicators.enabled = true;
        ReviewDB.enabled = true;
        ShikiCodeBlocks = {
          enabled = true;
          theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/catppuccin-mocha.json";
        };
        Translate.enabled = true;
        TypingIndicator.enabled = true;
        TypingTweaks.enabled = true;
        UserMesagesPronouns = {
          enabled = true;
          pronounsFormat = "LOWERCASE";
          showSelf = true;
        };
        ValidUser.enabled = true;
        VencordToolbox.enabled = true;
        ViewRaw.enabled = true;
        VoiceChatDoubleClick.enabled = true;
        WebKeybinds.enabled = true;
        WebScreenShareFixes.enabled = true;
        WhoReacted.enabled = true;
      };
    };
  };
}
