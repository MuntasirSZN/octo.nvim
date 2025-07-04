local M = {}

---@class ReviewComment
--- https://docs.github.com/en/graphql/reference/objects#pullrequestreviewcomment
---@field id string|-1
---@field author { login: string }
---@field state string
---@field replyTo any
---@field url any
---@field diffHunk string
---@field createdAt string
---@field originalCommit { oid: string, abbreviatedOid: string }
---@field body string
---@field viewerCanUpdate boolean
---@field viewerCanDelete boolean
---@field viewerDidAuthor boolean
---@field pullRequestReview { id: string|-1 }
---@field reactionGroups { content: string, users: { totalCount: number } }[]

---@class ReviewThread
--- https://docs.github.com/en/graphql/reference/objects#pullrequestreviewthread
---@field originalStartLine integer
---@field originalLine integer
---@field line? integer
---@field startLine? integer
---@field startDiffSide? string
---@field path string
---@field isOutdated boolean
---@field isResolved boolean
---@field diffSide string
---@field isCollapsed boolean
---@field id string|-1
---@field comments { nodes: ReviewComment[] }

local default_id = -1

local ReviewThread = {}
ReviewThread.__index = ReviewThread

---ReviewThread stub representing a new comment thread.
---@param opts {
--- line1: integer|nil,
--- line2: integer|nil,
--- file_path: string,
--- split: string,
--- diff_hunk: string,
--- commit: string,
--- commit_abbrev: string,
--- review_id: string|-1,
---}
---@return ReviewThread
function ReviewThread:stub(opts)
  ---@type ReviewThread
  return {
    originalStartLine = opts.line1,
    originalLine = opts.line2,
    path = opts.file_path,
    isOutdated = false,
    isResolved = false,
    diffSide = opts.split,
    isCollapsed = false,
    id = default_id,
    comments = {
      nodes = {
        {
          id = default_id,
          author = { login = vim.g.octo_viewer },
          state = "PENDING",
          replyTo = vim.NIL,
          url = vim.NIL,
          diffHunk = opts.diff_hunk,
          createdAt = os.date "!%FT%TZ" --[[@as string]],
          originalCommit = { oid = opts.commit, abbreviatedOid = opts.commit_abbrev },
          body = " ",
          viewerCanUpdate = true,
          viewerCanDelete = true,
          viewerDidAuthor = true,
          pullRequestReview = { id = opts.review_id },
          reactionGroups = {
            { content = "THUMBS_UP", users = { totalCount = 0 } },
            { content = "THUMBS_DOWN", users = { totalCount = 0 } },
            { content = "LAUGH", users = { totalCount = 0 } },
            { content = "HOORAY", users = { totalCount = 0 } },
            { content = "CONFUSED", users = { totalCount = 0 } },
            { content = "HEART", users = { totalCount = 0 } },
            { content = "ROCKET", users = { totalCount = 0 } },
            { content = "EYES", users = { totalCount = 0 } },
          },
        },
      },
    },
  }
end

M.ReviewThread = ReviewThread

return M
