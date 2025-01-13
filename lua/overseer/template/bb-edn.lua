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
                         :args (not= nil
                                     (re-find #"\*command-line-args\*"
                                              (pr-str (:task task))))}))))

(print (json/encode tasks))
]]

local bb_script_path = vim.fn.tempname()
vim.fn.writefile({ bbscript:gsub('\n', '') }, bb_script_path)

local function get_bb_edn(opts)
  return vim.fs.find('bb.edn', { upward = true, type = 'file', path = opts.dir })[1]
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
          table.insert(ret, {
            priority = 60,
            name = string.format('bb %s', task.name),
            desc = task.doc,
            params = {
              args = {
                optional = not task.args,
                type = 'list',
                delimiter = ' ',
              },
            },
            builder = function(params)
              local args = params.args or {}
              table.insert(args, vim.fn.expand('%:p'))
              return {
                cmd = { 'bb', task.name },
                args = args,
                cwd = params.cwd,
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
