---@class JiraUser
---@field accountId string
---@field displayName string
---@field emailAddress? string
---@field active boolean
---@field avatarUrls? table<string, string>

---@class JiraStatus
---@field id string
---@field name string
---@field statusCategory? JiraStatusCategory

---@class JiraStatusCategory
---@field id number
---@field key string
---@field name string
---@field colorName string

---@class JiraIssueType
---@field id string
---@field name string
---@field subtask boolean
---@field iconUrl? string

---@class JiraProject
---@field id string
---@field key string
---@field name string

---@class JiraPriority
---@field id string
---@field name string
---@field iconUrl? string

---@class JiraAdfMark
---@field type string
---@field attrs? {href?: string, [string]: any}

---@class JiraAdfAttrs
---@field level? number
---@field language? string
---@field text? string
---@field href? string
---@field [string] any

---@class JiraAdfContent
---@field type string
---@field content? JiraAdfContent[]
---@field text? string
---@field marks? JiraAdfMark[]
---@field attrs? JiraAdfAttrs

---@class JiraAdf
---@field type string
---@field version number
---@field content JiraAdfContent[]

---@class JiraChecklist
---@field v string

---@class JiraIssueFields
---@field summary string
---@field description? JiraAdf
---@field status JiraStatus
---@field assignee? JiraUser
---@field reporter? JiraUser
---@field issuetype JiraIssueType
---@field project JiraProject
---@field priority? JiraPriority
---@field created string
---@field updated string
---@field customfield_10988? JiraChecklist

---@class JiraIssue
---@field id string
---@field key string
---@field self string
---@field fields JiraIssueFields

---@class JiraComment
---@field id string
---@field self string
---@field author JiraUser
---@field body JiraAdf
---@field created string
---@field updated string
---@field updateAuthor? JiraUser

---@class JiraWorklog
---@field id string
---@field self string
---@field author JiraUser
---@field timeSpent string
---@field timeSpentSeconds number
---@field started string
---@field created string
---@field updated string
---@field comment? JiraAdf

---@class JiraSearchResponse
---@field startAt number
---@field maxResults number
---@field total number
---@field issues JiraIssue[]

---@class JiraCommentsResponse
---@field startAt number
---@field maxResults number
---@field total number
---@field comments JiraComment[]

---@class JiraWorklogsResponse
---@field startAt number
---@field maxResults number
---@field total number
---@field worklogs JiraWorklog[]

---@class JiraConfig
---@field base_url string
---@field email string
---@field token string

---@class JiraError
---@field status? number
---@field message string
---@field errors? table<string, string>

return {}
