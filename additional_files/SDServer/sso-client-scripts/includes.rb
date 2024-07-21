require_relative 'core/constants'
require_relative 'core/db'
require_relative 'modules/server'
require 'colorize'

#current_time = DateTime.now.strftime('%F %T')
prompt = " >> ".colorize(:blue)
IRB.conf[:PROMPT_MODE] = :DEFAULT
IRB.conf[:PROMPT][:DEFAULT] = { 
  :PROMPT_I => "#{prompt}",
  :PROMPT_S => "#{prompt}",
  :PROMPT_C => "#{prompt}",
  :PROMPT_N => "#{prompt}",
  :RETURN => "=> %s\n",
}
