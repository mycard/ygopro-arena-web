#!/usr/bin/env rake
#encoding: UTF-8
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rake/dsl_definition'
require File.expand_path('../config/application', __FILE__)

MycardServerHttp::Application.load_tasks

if RUBY_PLATFORM["mswin"] or RUBY_PLATFORM["ming"]
  STDOUT.set_encoding "GBK", "UTF-8", :invalid => :replace, :undef => :replace
  #STDERR.set_encoding "GBK", "UTF-8"
end
def connect_fh(db='1.accdb')
  puts '连接数据库...'
  require 'win32ole'
  conn = WIN32OLE.new('ADODB.connection')
  conn.Open('Provider = Microsoft.ACE.OlEDB.12.0;Data Source=1.accdb')
  rs = WIN32OLE.new('ADODB.Recordset')
  [conn, rs]
end
task :load_from_fh => :environment do
  conn, rs = connect_fh
  puts '读取决斗信息...'
  rs.Open("select d.*, w.getcount as winner_credits, l.getcount as loser_credits 
    from duel d, duelcount w, duelcount l
    where d.id*2-1 = w.id and d.id*2 = l.id
    and d.id not in (#{Duel.all.collect{|duel|duel.id}.push(0).join(',')})", conn)
  columns = [:id,:user1_id,:user2_id,:winner_id,:winreason,:replay,:user1_credits,:user2_credits]#,created_at,updated_at
  values = []
  while !rs.EOF
    
    duel = [
      rs.Fields["id"].value,
      User.find_or_create_by_name(rs.Fields["dueluser1"].value).id,
      User.find_or_create_by_name(rs.Fields["dueluser2"].value).id,
      :winner_id,
      rs.Fields["winreason"].value,
      rs.Fields["duelname"].value,
      :user1_credits,
      :user2_credits#,
      #time,
      #time
    ]
    if rs.Fields["winnerpos"].value == 0
      duel[3] = duel[1]
      duel[6] = rs.Fields["winner_credits"].value 
      duel[7] = rs.Fields["loser_credits"].value
    else
      duel[3] = duel[2]
      duel[6] = rs.Fields["loser_credits"].value 
      duel[7] = rs.Fields["winner_credits"].value
    end
    puts "#{duel[0]}: #{rs.Fields["dueluser1"].value} - #{rs.Fields["dueluser2"].value}"
    values << duel
    rs.MoveNext
  end
  rs.Close
  puts '导入决斗信息...'
  Duel.import columns, values, :validate => false
  
  puts '读取玩家卡组信息...'
  rs.Open("select count(*) as _count from deck", conn)
  count = rs.Fields["_count"].value
  rs.Close
  
  columns = [:id, :duel_id, :user_id, :card_id, :main]
  values = []
  rs.Open("select * from deck where id not in (#{DuelUserCard.all.collect{|duel_user_card|duel_user_card.id}.push(0).join(',')})", conn)
  while !rs.EOF
    duel = Duel.find_or_create_by_id(rs.Fields["duelid"].value)
    card = Card.find_by_number(rs.Fields["decknumber"].value)
    duel_user_card = [
      rs.Fields["ID"].value,
      duel.id,
      :user_id,
      card ? card.id : p(card = (Card.create :number => rs.Fields["decknumber"].value, :name => rs.Fields["decknumber"].value.to_s)),
      rs.Fields["deckpos"].value % 2,
    ]
    duel_user_card[2] = rs.Fields["deckpos"].value <= 2 ? duel.user1_id : duel.user2_id
    
    values << duel_user_card
    puts "(#{duel_user_card[0]}/#{count})#{duel_user_card[2] || 'unknown'} - #{card.name}"
    rs.MoveNext
  end
  rs.Close
  puts '导入玩家卡组信息...'
  DuelUserCard.import columns, values, :validate => false
  puts '运行完毕'
end
#"update users u, duels_users_cards duc, duels d set u.credits = SUM()"
#select 
task :refresh_user_count => :environment do
  count = User.maximum(:id)
  User.find_each do |user|
    user.update_attributes :credits => Duel.where(:user1_id => user.id).sum(:user1_credits) + Duel.where(:user2_id => user.id).sum(:user2_credits),
      :win => user.wins.count,
      :lost => user.losts.count
    puts "(#{user.id}/#{count})#{user.name}"
  end
end

task :refresh_user_pass => :environment do
  require 'cgi'
  require 'open-uri'
  servers = Server.all
  users = []
  User.find_each do |user|
    if user.password.nil? 
      print "#{user.id} #{user.name} ..无密码\n"
      next
    end
    users << user
  end
  threads = []
  100.times do |i|
    threads << Thread.new do      
      while user = users.pop
        out = "#{user.id} #{user.name} "
        servers.each do |server|
          open("http://#{server.ip}:#{server.http_port}/?pass=#{server.password}&operation=forceuserpass&username=#{CGI.escape user.name}&password=#{CGI.escape user.password}"){|f|out << f.read + " "} rescue out << $!.inspect.encode("UTF-8", :invalid => :replace, :undef => :replace)
        end
        print out+"\n"
      end
    end
  end
  threads.each{|thread|thread.join}
end