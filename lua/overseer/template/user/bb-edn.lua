local bbscript = [[
(require '[clojure.edn :as edn])
(require '[cheshire.core :as json])

(assert *command-line-args*)
(def bbedn (slurp (first *command-line-args*)))
(def template (edn/read-string bbedn))
(def tasks (->> (keys (:tasks template))
                (filter symbol?)
                (map #(let [n (name %)
                            t (get-in template [:tasks %])
                            task (if (map? t) t {:task t})]
                        {:name n
                         :doc (:doc task)
                         :args (or (:spec task)
                                   (not= nil
                                     (re-find #"\*command-line-args\*"
                                              (pr-str (:task task)))))}))))

(print (json/encode tasks))
]]

local bb_script_path = vim.fn.tempname()
vim.fn.writefile({ bbscript:gsub('\n', '') }, bb_script_path)

local function get_bb_edn(opts)
  return vim.fs.find('bb.edn', { upward = true, type = 'file', path = opts.dir })[1]
end

local function get_env_vars()
  return {
    BBT_CWD = vim.fn.getcwd(),
    BBT_FILE = vim.fn.expand('%:p'),
    BBT_RELATIVE_FILE = vim.fn.expand('%:.'),
    BBT_RELATIVE_DIR = vim.fn.expand('%:.:h'),
    BBT_BASENAME = vim.fn.expand('%:t'),
    BBT_BASENAME_WO_EXT = vim.fn.expand('%:t:r'),
    BBT_FILE_ABS = vim.fn.expand('%:p:h'),
    BBT_FILE_EXT = vim.fn.expand('%:e'),
  }
end

local function build_task_params(task)
  local params = {}
  if type(task.args) == 'table' then
    for k, arg in pairs(task.args) do
      params[k] = {
        type = 'string',
        optional = not arg.require,
      }
    end
  elseif task.args then
    params.args = {
      optional = false,
      type = 'list',
      delimiter = ' ',
    }
  end
  return params
end

local function build_task_args(task_params, params)
  local args = {}
  for k, v in pairs(params) do
    if task_params[k].type == 'list' then
      table.insert(args, v)
    else
      table.insert(args, ':' .. k)
      table.insert(args, v)
    end
  end
  return args
end

return {
  cache_key = get_bb_edn,
  condition = {
    callback = function(opts)
      if vim.fn.executable('bb') == 0 then
        return false, 'Command "bb" not found'
      end
      if not get_bb_edn(opts) then
        return false, 'No "bb.edn" file found'
      end
      return true
    end,
  },
  generator = function(opts, cb)
    local json = require('overseer.json')
    local log = require('overseer.log')

    local ret = {}

    local bbedn = get_bb_edn(opts)

    local jid = vim.fn.jobstart({ 'bb', bb_script_path, bbedn }, {
      stdout_buffered = true,
      on_stdout = vim.schedule_wrap(function(_, output)
        local result = json.decode(output[1])
        for _, task in ipairs(result) do
          local task_params = build_task_params(task)
          table.insert(ret, {
            name = string.format('bb %s', task.name),
            desc = task.doc,
            params = task_params,
            builder = function(params)
              return {
                cmd = { 'bb', task.name },
                args = build_task_args(task_params, params),
                cwd = params.cwd,
                env = get_env_vars(),
              }
            end,
          })
        end
      end),
      on_exit = vim.schedule_wrap(function()
        cb(ret)
      end),
    })

    if jid <= 0 then
      log:error('Failed to execute bb')
      cb(ret)
    end
  end,
}
