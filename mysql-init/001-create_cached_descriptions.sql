USE description_db;

-- create the cache table if it doesn't already exist
CREATE TABLE IF NOT EXISTS CachedDescriptions (
  Id               INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Uniquely identifies the base description (typically hash of original + journal/page identifiers)
  PromptHash       VARCHAR(64) NOT NULL,
  
  -- Raw original content (HTML/Markdown/plaintext)
  OriginalText     TEXT NOT NULL,
  
  -- Style (e.g., 'high-fantasy', 'film-noir')
  Style            VARCHAR(64) NOT NULL,

  -- Sequential version number within (PromptHash + Style)
  VersionNumber    INT NOT NULL,

  -- GPT-enhanced result
  EnhancedText     LONGTEXT NOT NULL,

  -- Timestamp for auditing
  CreatedAt        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  -- Optional metadata
  ModelUsed        VARCHAR(64),         -- e.g., 'gpt-4'
  Temperature      FLOAT,               -- e.g., 0.7

  -- Optional link to a prior version (if this is a re-enhancement)
  ParentId         INT DEFAULT NULL,

  -- Uniqueness constraint for versioning per prompt + style
  UNIQUE KEY UK_StyleVersion (PromptHash, Style, VersionNumber),

  -- Foreign key (optional, but safe for cascading deletes if needed)
  CONSTRAINT FK_CachedDescriptions_Parent
    FOREIGN KEY (ParentId)
    REFERENCES CachedDescriptions(Id)
    ON DELETE SET NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;