#encoding: UTF-8
class RoomsController < ApplicationController
  require 'open-uri'
  layout 'losses'
  def index
    @rooms = []
    @actions = ["在线大厅"]
    respond_to do |format|
      format.html # index.html.erb
      format.json  do
        open('http://140.113.242.66:7922/?operation=getroomjson') do |file|
          file.set_encoding("GBK")
          file.read.encode("UTF-8").scan(Room_Filter) do |id, name, status, users|
            room = {id: id.to_i, name: name, status: status}
            room[:users] = []
            users.scan(User_Filter) do |player, name, certified|
              certified = if certified.nil?
                name[-5,5] != "(未认证)"
              else
                certified == "-1"
              end
              if certified
                user = User.find_by_name(name)
                user = {player: player.to_i, id: user ? user.id : 0, name: name, certified: true}
              else
                user = {player: player.to_i, id: 0, name: name, certified: false}
              end
              room[:users] << user
            end
            @rooms << room
          end
        end
        render json: @rooms
      end
    end
  end
end
