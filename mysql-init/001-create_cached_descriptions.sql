-- 002-create_cached_descriptions.sql

-- switch to your existing schema
USE description_db;

-- create the cache table if it doesn't already exist
CREATE TABLE IF NOT EXISTS CachedDescriptions (
  Id             INT           AUTO_INCREMENT PRIMARY KEY,
  PromptHash     VARCHAR(64)   NOT NULL,
  OriginalPrompt TEXT          NOT NULL,
  EnhancedText   LONGTEXT      NOT NULL,
  CreatedAt      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY UK_CachedDescriptions_PromptHash (PromptHash)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci;
