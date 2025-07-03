USE campaign_module_db;

CREATE TABLE IF NOT EXISTS CachedCampaignModule (
  Id           INT AUTO_INCREMENT PRIMARY KEY,
  ModuleUID    VARCHAR(255) NOT NULL,
  ModuleName   VARCHAR(255) NOT NULL,
  ModuleTitle  VARCHAR(255) NOT NULL,
  Version      VARCHAR(64)  NOT NULL,
  Synopsis     LONGTEXT,
  UNIQUE KEY (ModuleUID)
);

CREATE TABLE IF NOT EXISTS CachedJournalPage (
  Id              INT AUTO_INCREMENT PRIMARY KEY,
  CampaignModuleId INT NOT NULL,
  JournalId       VARCHAR(64) NOT NULL,
  JournalName     VARCHAR(255) NOT NULL,
  PageId          VARCHAR(64) NOT NULL,
  PageName        VARCHAR(255) NOT NULL,
  SourceType      VARCHAR(64) NOT NULL DEFAULT 'WorldJournal',
  OriginalText    LONGTEXT NOT NULL,
  EnhancedText    LONGTEXT,
  IsPlayerFacing  BOOLEAN DEFAULT FALSE,
  ValidationFeedback TEXT,
  LinkedPages     TEXT,
  FOREIGN KEY (CampaignModuleId) REFERENCES CachedCampaignModule(Id)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CachedScene (
  Id              INT AUTO_INCREMENT PRIMARY KEY,
  CampaignModuleId INT NOT NULL,
  SceneId         VARCHAR(64) NOT NULL,
  SceneName       VARCHAR(255) NOT NULL,
  NoteId          VARCHAR(64),
  LinkedEntry     VARCHAR(64),
  X               INT,
  Y               INT,
  Width           INT,
  Height          INT,
  OriginalText    LONGTEXT NOT NULL,
  EnhancedText    LONGTEXT,
  IsPlayerFacing  BOOLEAN DEFAULT FALSE,
  ValidationFeedback TEXT,
  FOREIGN KEY (CampaignModuleId) REFERENCES CachedCampaignModule(Id)
    ON DELETE CASCADE
);
