#encoding: UTF-8
STDOUT.set_encoding("GBK", "UTF-8")
require 'yaml'
y = YAML.load_file 'deck.yml'
$sql = 'insert into decks (duel_id, user_id, library_id) select duel_id, user_id, (case ' + "\n"
ancestor = nil
ancestor_id = nil
has_child = false
y.each_with_index do |item, index|
  key, values = item
  id = index + 1
  if values.first["parent"]
    raise if values.shift["parent"] != ancestor #目前只允许一层嵌套
    if has_child
    else
      $sql << "then case\n"
      has_child = true
    end
  else
    if ancestor
      if has_child
        $sql << "else '#{ancestor_id}' end\n"
      else
        $sql << "then '#{ancestor_id}'\n"
      end
    end
    ancestor = key
    ancestor_id = id
    has_child = false
  end
  
  $sql << " when "
  first = true
  values.each do |value|
    value["operator"] = '=' if value["operator"].nil?
    condition = case value["operator"]
    when 'instr'
      result = "INSTR(#{value.keys.first}, '#{value[value.keys.first]}')"
      if ancestor == key
        result = "!(!(#{result}))"
      end
      result
    when '=', '>=', '<=', '>', '<', '!='
      "#{value.keys.first} #{value["operator"]} '#{value[value.keys.first]}'"
    else
      raise "UNKNOWN OPERATOR: #{value["operator"]}, #{key}, '#{value}'"
    end
    if first
      first = false
    else
      $sql << "and "
    end
    if ancestor == key
      $sql << "sum(#{condition}) >= #{value["count"]} "
    else
      $sql << "(select count(*) from duels_users_cards t left join cards c on t.card_id=c.id where t.duel_id = a.duel_id and t.user_id = a.user_id and #{condition}) >= #{value['count']} "
    end
  end
  if ancestor != key
    $sql << "then '#{id}'\n"
  end
end
if has_child
  $sql << "else '#{ancestor_id}' end\n"
else
  $sql << "then '#{ancestor_id}'\n"
end
$sql << ' end
) as library_id from duels_users_cards a 
left join cards b on a.card_id=b.id group by a.duel_id, a.user_id'

#puts $sql
db = YAML.load_file('database.yml')["development"]
require 'mysql2'
Mysql = Mysql2::Client.new(host: db["host"], username: db["username"], password: db["password"])
Mysql.query('use `mycard_production`')
Mysql.query('truncate table decks')
Mysql.query($sql)
