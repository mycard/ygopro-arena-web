class DemoData < ActiveRecord::Migration
  def self.up
=begin
    Board.create  :id => 1,
                  :superboard_id => 0,
                  :name => "综合讨论中心"
                
    Board.create  :id => 2,
                  :superboard_id => 1,
                  :name => "测试版块",
                  :introduction => "版块简介",
                  :notice => "版块公告",
                  :logo => "http://bbs.66rpg.com/data/attachment/common/skin/VX.png",
                  :banner => "http://ftp.66rpg.com/WEB_PLUS/attachment/forum/201104/24/221009dzbmkp6666pp3mue.jpg"
                
    
    Link.create   :id => 1,
                  :name => "66RPG 实验室",
                  :displayorder => 0,
                  :introduction => "Reliz 开发组",
                  :url => "http://lab.66rpg.com:3000/",
                  :logo => "http://bbs.66rpg.com/logo.gif"
                
 
    Navigation.create :id => 1,
                      :name => "论坛",
                      :displayorder => 0,
                      :url => "/boards",
                      :Role_id => 0,
                      :super_id => 0
                    
    Navigation.create :id => 2,
                      :name => "测试导航1",
                      :displayorder => 1,
                      :url => "/boards",
                      :Role_id => 0,
                      :super_id => 1
                    
    Navigation.create :id => 3,
                      :name => "测试导航2",
                      :displayorder => 1,
                      :url => "/boards",
                      :Role_id => 0,
                      :super_id => 1

    User.create :id => 1,
                :name => "admin",
                :nickname => "华丽丽滴全能高管",
                :password => "admin",
                :email => "zh99998@163.com",
                :role_id => 1,
                :locked => false,
                :regip => '127.0.0.1',
                :lastloginip => '127.0.0.1',
                :viewnum => 0,
                :onlinetime => 0,
                :credit => 0,
                :credit1 => 0,
                :credit2 => 0,
                :credit3 => 0,
                :credit4 => 0,
                :credit5 => 0,
                :credit6 => 0,
                :credit7 => 0,
                :credit8 => 0,
                :locale => nil,
                :theme => nil

    Role.create  :id => 1,
                 :name => "创始人",
                 :topic_delete => true,
                 :topic_digest => 3,
                 :topic_displayorder => 3,
                 :topic_highlight => true,
                 :topic_edit => true,
                 :topic_lock => true
                    
    Role.create  :id => 2,
                 :name => "管理员",
                 :topic_delete => true,
                 :topic_digest => 3,
                 :topic_displayorder => 3,
                 :topic_highlight => true,
                 :topic_edit => true,
                 :topic_lock => true
                    
    Role.create  :id => 3,
                 :name => "超级版主",
                 :topic_delete => true,
                 :topic_digest => 3,
                 :topic_displayorder => 3,
                 :topic_highlight => true,
                 :topic_edit => true,
                 :topic_lock => true
    Role.create  :id => 4,
                 :name => "版主",
                 :topic_delete => true,
                 :topic_digest => 3,
                 :topic_displayorder => 3,
                 :topic_highlight => true,
                 :topic_edit => true,
                 :topic_lock => true
    Role.create  :id => 5,
                 :name => "普通用户"
=end
    Role.create  :id => 6,
                 :name => "游客"

                    
  end

  def self.down
  end
end
