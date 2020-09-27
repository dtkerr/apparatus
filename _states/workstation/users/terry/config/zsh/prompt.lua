#!/usr/bin/lua
-- builds a prompt I find simple yet functional, and easy to extend.
require 'pl'
lfs = require 'lfs'
stringx.import()

---------
-- styles
pwd_color = '%F{white}'
venv_glyph = ''
venv_color = '%F{blue}'
branch_glyph = ''
branch_color = '%F{cyan}'
kube_glyph = ''
kube_color = '%F{magenta}'
ruby_glyph = ' '
ruby_color = '%F{red}'
sigil_glyph = '» %f'
sigil_ok_color = '%F{white}'
sigil_fail_color = '%F{red}'

---------
-- blocks

-- block of the n parent directories to give the
-- use an idea of where the hell they are
function pwd_block (n)
    if n == nil then n = 1 end

    local pwd = lfs.currentdir()
    local home = os.getenv('HOME')
    if pwd == nil then return '??' end

    -- replace $HOME/ with ~
    pwd = pwd:replace(home .. '/', '~/', 1)
    -- special case: if we're in $HOME the above
    -- replace won't work because the pwd will
    -- not have the trailing `/`
    if pwd == home then pwd = '~' end
    -- break the pwd in to a list, and determine
    -- if n dirs has up hit `/` or `~` in which
    -- case we bump n by 1 to include the leading
    -- `~/` or `/` before the block we print
    local dirs = pwd:split('/')
    if dirs:len() - 1 == n then n = n + 1 end

    return pwd_color .. dirs:slice(-n):join('/')
end

-- indicate the current git branch to the user if any
function branch_block ()
    local branch = os.getenv('GIT_BRANCH')
    if not branch then return '' end
    return branch_color .. branch_glyph .. branch
end

-- indicate what python virtualenv the user is in if any
function venv_block ()
    local venv_path = os.getenv('VIRTUAL_ENV')
    if not venv_path then return '' end
    local _, _, venv_name = stringx.rpartition(venv_path, '/')
    return venv_color .. venv_glyph .. venv_name
end

-- indicate what kubernetes context is implict, if any
function kube_block ()
    local kube_raw = os.getenv('KUBE_CONTEXT')
    if not kube_raw or kube_raw == '' then return '' end
    return kube_color .. kube_glyph .. kube_raw:shorten(32)
end

-- indicate what ruby version is implict, if any
function ruby_block ()
    local ruby_ver = os.getenv('RUBY_VERSION')
    if not ruby_ver or ruby_ver == '' then return '' end
    return ruby_color .. ruby_glyph .. ruby_ver
end

-- sigil to give success/fail feedback from the last command
-- and just generally look pretty while prompting the user
function sigil_block ()
    local last_status = os.getenv('LAST_STATUS')
    local color = sigil_ok_color
    if last_status ~= '0' then color = sigil_fail_color end
    return color .. sigil_glyph
end

---------------------
-- compose the prompt

blocks = List {
    pwd_block(3),
    branch_block(),
    venv_block(),
    kube_block(),
    ruby_block(),
	sigil_block(),
}
function not_empty (val) return val ~= '' end
blocks = blocks:filter(not_empty)

io.write((' '):join(blocks))
