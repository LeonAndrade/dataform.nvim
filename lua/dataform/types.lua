---@diagnostic disable

---@class CompilationResult
---@field tables ITable[]
---@field operations IOperation[]
---@field projectConfig IProjectConfig
---@field graphErrors GraphErrors
---@field declarations IDeclaration[]
---@field dataformCoreVersion string
---@field targets ITarget[]

---@class ITable
---@field fileName string
---@field type string
---@field target ITarget
---@field query string
---@field disabled boolean
---@field preOps string[]
---@field tags string[]
---@field bigquery IBigQuery
---@field actionDescriptor IActionDescriptor
---@field incrementalQuery string
---@field dependencyTargets ITarget[]
---@field incrementalPreOps string[]
---@field enumType string

---@class IOperation
---@field target ITarget
---@field queries string[]
---@field fileName string
---@field hermeticity string
---@field canonicalTarget ITarget

---@class IActionDescriptor
---@field description string
---@field columns table<string, string>

---@class IBigQuery
---@field partitionBy string
---@field clusterBy string[]
---@field additionalOptions table<string, any>
---@field labels table<string, any>
---@field partitionExpirationDays number
---@field requirePartitionFilter boolean
---@field updatePartitionFilter string

---@class IDeclaration
---@field target ITarget
---@field fileName string
---@field canonicalTarget ITarget

---@class ITarget
---@field database string
---@field name string
---@field schema string

---@class IProjectConfig
---@field defaultDatabase string The default database.
---@field defaultSchema string The default schema.
---@field defaultLocation string The default BigQuery location to use.
---@field assertionSchema string The default schema for assertions.
---@field vars? table<string, string> User-defined compilation-time variables.
---@field databaseSuffix? string The suffix that should be appended to all database names.
---@field schemaSuffix? string The suffix that should be appended to all database schemas.
---@field tablePrefix? string The prefix that should be prepended to all table names.
---@field warehouse string Must be set to bigquery.

---@class GraphErrors
---@field compilationErrors ICompilationError[]

---@class ICompilationError
---@field fileName string
---@field message string
---@field stack string
---
---@type ITable | IOperation | IDeclaration
---@class IAction

---------------------------------
---------------------------------

---@class ActionPaths
---@field relative string Action path relative to the definitions folder.
---@field compiled string Absolute path where action compilation assets are stored.
---@field source string Absolute path for the source file of the action
